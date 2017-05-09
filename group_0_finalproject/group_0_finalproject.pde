import ddf.minim.*;
Table highScore, newTable;

ArrayList<Zombie> zombieList = new ArrayList<Zombie>();
ArrayList<Missile> missileList = new ArrayList<Missile>();
boolean muted, gameRunning, gameOver, left, right, up, down, shooting, startScreen = true;
float currentHP, maxHP, zombie_num, missileWidth, missileHeight, spawnTimer, lastSpawn, breakTimer, upgradeTimer = -3000, shootTimer, gunSpeed = .1;
int score = 0, money = 0, difficulty = 0;
PImage img, muzzle_flash, missile1, hazard, wire, dead, lightningImg, img2;
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
String gunType =  "Missile";



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
  img2 = loadImage("zombie.PNG");
  muzzle_flash = loadImage("muzzle_flash.png");
  missile1 = loadImage("missile1.png");
  lightningImg = loadImage("lightning.png");
  hazard = loadImage("hazard.png");
  wire = loadImage("wire.png");
  currentHP = 2000;
  maxHP = 2000;
  player.damage = 0.5;
  //gameRunning = true;
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
  
  newTable = new Table();
  highScore = loadTable("High_Scores.csv", "header");
  
}

void draw(){

  if(startScreen){
    background(255);
    image(img2, 0, 0);
    fill(255);
    rect(213, 165, 100, 40);
    fill(255,0,0);
    text("HIGH SCORE:", 225, 180);
    for (int i = 0; i < 5; i++) {
      fill(0);
      text(highScore.getInt(0, 0), 253, 196);
    }
    fill(150);
    rect(730, 350, 200, 50);
    fill(255);
    text("Start Game", 800, 380);
  }
  if(gameRunning){
    if(currentHP <= 0){
      currentHP = 0;
      gameRunning = false;
      gameOver = true;
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
    runButtons();
  }
  
  if(gameOver){
    audioPlayer2.close();
    audioPlayer3.close();
    if(score > highScore.getInt(0, 0)){
      newTable.addColumn("Score");
      TableRow newRow = newTable.addRow();
      newRow.setInt("Score", score);
      saveTable(newTable, "data/High_Scores.csv");
    }
    score = 0;
    money = 0;
    player.damage = .5;
    currentHP = 2000;
    difficulty = 0;
    highScore = loadTable("High_Scores.csv", "header");
    startScreen = true;
    gameOver = false;
    
  }
  muteButton();
  crosshead.display();  
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
  
  fill(70);
  rect(435, 770, 25, 25);
  fill(255);
  text("S", 443, 787);
}

void upgradeGun(){
  player.damage += .5;
  money -= 50;
}

void muteButton(){
  fill(170);
  rect(0,0,25,25);
  fill(0);
  text("M", 5, 15);
}

void showScore(){
  fill(0);
  for (int x = -1; x<2; x++){  
    text(nf(score, 4), 850+x, 10);
    text(nf(score, 4), 850, 10+x);
    text(nf(money, 4), 950+x, 10);
    text(nf(money, 4), 950, 10+x);
  }
  fill(255);
  text("Score:", 810, 10);
  text(nf(score, 4), 850, 10);
  text("Money:", 905, 10);
  text(nf(money, 4), 950, 10);
}

void runZombie(){
    for(int i = 0; i < zombieList.size(); i++){
      Zombie currentZombie = zombieList.get(i);
      currentZombie.display();
      if(currentZombie.zombieHP <= 0){
        zombieList.remove(currentZombie);
        score++;
        money++;
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
  
  if(gameRunning){
    if(gunType == "Missile"){
      audioPlayer2.loop();    
    } else if(gunType == "Lightning"){
      audioPlayer3.loop();
    }
    shooting = true;
    
        
  }
  
  if(startScreen){
    if(mouseX > 730 && mouseX < 930){
      if(mouseY > 350 && mouseY < 400){
        rect(730, 350, 200, 50);
        gameRunning = true;
        startScreen = false;
      }
    }
  }
  
  
}

void mouseReleased(){
  if(mouseX > 0 && mouseX < 25){
    if(mouseY > 0 && mouseY < 25){
      if(muted){
        minim1 = new Minim(this);
        audioPlayer1 = minim1.loadFile("metalslug.mp3");
        input1 = minim1.getLineIn();
        audioPlayer1.loop();
        muted = false;
      }else{
        audioPlayer1.close();
        muted = true;
      }
    }
  }
  if(gameRunning){
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
    if(mouseX > 405 && mouseX < 430){
      if(mouseY > 770 && mouseY < 795){
        if (money >= 50){
          upgradeTimer = millis();
          upgradeGun();
          money -= 50;
        }
        if(money < 0){
          money  += 50;
        }
      }
    }
    if(mouseX > 435 && mouseX < 460){
      if(mouseY > 770 && mouseY < 795){
        if(gunType == "Missile"){
          gunType = "Lightning";
        }else{
          gunType = "Missile";
        }
      }
    }
  }
}

//moves character
void keyPressed(){
  if(gameRunning){
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
    //if(key == 'r' && gunType == "Missile"){
    //  gunType = "Lightning";
    //}else if(key == 'r' && gunType == "Lightning"){
    //  gunType = "Missile";
    //}
  }
}

//stops movement
void keyReleased(){
  
  if(gameRunning){
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
}