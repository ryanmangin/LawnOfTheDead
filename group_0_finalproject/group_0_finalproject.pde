import ddf.minim.*;


ArrayList<Zombie> zombieList = new ArrayList<Zombie>();
ArrayList<Missile> missileList = new ArrayList<Missile>();
boolean gameRunning, left, right, up, down;
float currentHP, maxHP, zombie_num, missileWidth, missileHeight, spawnTimer, lastSpawn, breakTimer, upgradeTimer = -3000, shootTimer, gunSpeed = .1;
int score = 40, difficulty = 0;
PImage img, muzzle_flash, missile1, hazard, wire, dead, lightningImg;
PVector gPlayerPos = new PVector(0, 0);
Shelter shelter = new Shelter();
Player player = new Player();
Zombie zombie = new Zombie(0, 0, 0, 0);
Sprite zombieSprite = new Sprite();
Sprite characterSpriteRun = new Sprite();
Sprite characterSpriteRunBack = new Sprite();
Sprite characterSpriteIdle = new Sprite();
Crosshead crosshead = new Crosshead();
Lightning lightning = new Lightning();
PImage forwardPOD;
PImage backwardPOD;
boolean shooting;
String gunType =  "Lightning";

// theme song
Minim minim1;
AudioPlayer audioPlayer1;
AudioInput input1;

// missile1 sound
Minim minim2;
AudioPlayer audioPlayer2;
AudioInput input2;

// electricity sound
Minim minim3;
AudioPlayer audioPlayer3;
AudioInput input3;



void setup(){
  img = loadImage("background.png");
  muzzle_flash = loadImage("muzzle_flash.png");
  missile1 = loadImage("missile1.png");
  lightningImg = loadImage("lightning.png");
  hazard = loadImage("hazard.png");
  wire = loadImage("wire.png");
  currentHP = 2000;
  maxHP = 2000;
  player.damage = .5;
  gameRunning = true;
  zombieSprite.sprite("Zombie_Girl/PNG/Animation/Walk_", 6);
  characterSpriteRun.sprite("Character/Run_", 5);
  characterSpriteRunBack.sprite("Character/RunBack_", 5);
  characterSpriteIdle.sprite("Character/Idle__", 5);
  size(1600, 800);
  forwardPOD = loadImage("forwardPOD.png");
  backwardPOD = loadImage("backwardPOD.png");

  minim1 = new Minim(this);
  audioPlayer1 = minim1.loadFile("metalslug.mp3");
  input1 = minim1.getLineIn();
  audioPlayer1.loop();
  
  minim2 = new Minim(this);
  audioPlayer2 = minim2.loadFile("missile1.mp3");
  input2 = minim2.getLineIn();
  
  minim3 = new Minim(this);
  audioPlayer3 = minim3.loadFile("electric.mp3");
  input3 = minim3.getLineIn();
  noCursor();
}

void draw(){
  if(gameRunning){
    if(currentHP <= 0){
      currentHP = 0;
      gameRunning = false;
      print("game over");
    }
    tint(110);
    image(img, 400, -170);
    tint(220);
    shelter.runShelter();
    zombieSpawner();
    runZombie();
    runPlayer();
    if(gunType == "Missile"){
      runMissiles();
    }
    if(gunType == "Lightning" && shooting){
      runLightning();
    }
    showScore();
    showFramerate();
    runButtons();
    //ellipse(500, 400, 30, 30);
    crosshead.display();
  }
  
}

void runButtons(){
  noStroke();
  fill(70);
  rect(405, 770, 25, 25);
  fill(255, 0, 0);
  rect(417, 775, 4, 18);
  rect(410, 782, 18, 4);
  if(millis() - upgradeTimer < 3000){
    text("+0.5 DMG", player.playerPos.x+7, player.playerPos.y);
  }
}

void upgradeGun(){
  player.damage += .5;
}

void showFramerate(){
  fill(150);
  textSize(12);
  text(frameRate, 0, 10);
}

void showScore(){
  fill(0);
  for (int x = -1; x<2; x++){  
    text(nf(score, 4), 850+x, 10);
    text(nf(score, 4), 850, 10+x);
  }
  fill(255);
  text(nf(score, 4), 850, 10);
}

void runZombie(){
    for(int i = 0; i < zombieList.size(); i++){
      Zombie currentZombie = zombieList.get(i);
      currentZombie.display();
      if(currentZombie.zombieHP <= 0){
        zombieList.remove(currentZombie);
        score++;
      }
    }
  }
  
void zombieSpawner(){
  spawnTimer = 1000*50/(score+50);
  if (score%50 == 0){
    breakTimer = millis() + 10000;
    difficulty++;
    score++;
    
  }
  if(millis() > breakTimer){
    if(millis() - lastSpawn > spawnTimer){
      lastSpawn = millis();
      zombieList.add(new Zombie(2+difficulty, 2+difficulty, 2+difficulty, 2+difficulty));
    }
  }
}

//displays missiles if on screen
  void runMissiles(){
    if(shooting == true && millis() - shootTimer > gunSpeed*1000){
      shootTimer = millis();
      Missile newMissile = new Missile(player.playerPos.x, player.playerPos.y, mouseX, mouseY);
      missileList.add(newMissile);
      image(muzzle_flash, player.playerPos.x - 35, player.playerPos.y - 50);
        
    }
    for(int i = 0; i < missileList.size(); i++){
      Missile currentMissile = missileList.get(i);
      if(currentMissile.inBounds()){
        currentMissile.display();
        currentMissile.update();
      }else{
        missileList.remove(currentMissile);
      }
    }
  }
  
  void runLightning(){
    lightning.display(player.playerPos.x, player.playerPos.y);
  }

void runPlayer(){
  if(right){
    player.displayRun();
  } else if(left){
    player.displayRunBack();
  } else if( up | down){
    player.displayRun();
  }
  else{
    player.displayIdle();
  }
    player.update(left, right, up, down);
  }



//creates missile
void mousePressed(){
  if(mouseX > 405 && mouseX < 430){
    if(mouseY > 770 && mouseY < 795){
      upgradeTimer = millis();
      upgradeGun();
    }
  }
  if(gunType == "Missile"){
    audioPlayer2.loop();    
  } else if(gunType == "Lightning"){
    audioPlayer3.loop();
  }
  shooting = true;
}

void mouseReleased(){
  shooting = false;
  if(gunType == "Missile"){
    audioPlayer2.close();
    //since close closes the file, we'll load it again
    audioPlayer2 = minim2.loadFile("missile1.mp3");
  } else if(gunType == "Lightning"){
    audioPlayer3.close();
    //since close closes the file, we'll load it again
    audioPlayer3 = minim3.loadFile("electric.mp3");
  }
}

//moves character
void keyPressed(){
  if(key == 'a'){
    left = true;
  }
  if(key == 'd'){
    right = true;
  }
  if(key == 'w'){
    up = true;
  }
  if(key == 's'){
    down = true;
  }
  if(key == 'r' && gunType == "Missile"){
    gunType = "Lightning";
  }
  if(key == 'r' && gunType == "Lightning"){
    gunType = "Missile";
  }
}

//stops movement
void keyReleased(){
  if(key == 'd'){
    right = false;
  }
  if(key == 'a'){
    left = false;
  }
  if(key == 'w'){
    up = false;
  }
  if(key == 's'){
    down = false;
  }  
}