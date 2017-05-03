ArrayList<Zombie> zombieList = new ArrayList<Zombie>();
ArrayList<Missile> missileList = new ArrayList<Missile>();
boolean gameRunning, left, right, up, down;
float currentHP, maxHP, zombie_num, missileWidth, missileHeight, spawnTimer, lastSpawn, breakTimer, upgradeTimer = -3000;
int score = 40, difficulty = 0;
String gunType = "standard";
PImage img;
PVector gPlayerPos = new PVector(0, 0);
Shelter shelter = new Shelter();
Player player = new Player();
Zombie zombie = new Zombie(0, 0, 0, 0);
Sprite zombieSprite = new Sprite();
Sprite characterSpriteRun = new Sprite();
Sprite characterSpriteRunBack = new Sprite();
Sprite characterSpriteIdle = new Sprite();
Crosshead crosshead = new Crosshead();

void setup(){
  img = loadImage("background.png");
  currentHP = 2000;
  maxHP = 2000;
  player.damage = 1;
  gameRunning = true;
  zombieSprite.sprite("Zombie_Girl/PNG/Animation/Walk_", 6);
  characterSpriteRun.sprite("Character/Run_", 10);
  characterSpriteRunBack.sprite("Character/RunBack_", 10);
  characterSpriteIdle.sprite("Character/Idle__", 10);
  size(1600, 800);
}

void draw(){
  if(gameRunning){
    if(currentHP <= 0){
      currentHP = 0;
      gameRunning = false;
      print("game over");
    }
    tint(170);
    image(img, 400, -170);
    tint(220);
    shelter.runShelter();
    runPlayer();
    runMissiles();
    showScore();
    showFramerate();
    zombieSpawner();
    runZombie();
    runButtons();
    //ellipse(500, 400, 30, 30);
    crosshead.display();
  }
  print(score, "\n");
  
}

void runButtons(){
  noStroke();
  fill(70);
  rect(405, 770, 25, 25);
  fill(255, 0, 0);
  rect(417, 775, 4, 18);
  rect(410, 782, 18, 4);
  if(millis() - upgradeTimer < 3000){
    text("+1 DMG", player.playerPos.x+7, player.playerPos.y);
  }
}

void upgradeGun(){
  player.damage++;
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
  if(gunType == "standard"){
    missileWidth = 10;
    missileHeight = 10;
  }
  Missile newMissile = new Missile(player.playerPos.x, player.playerPos.y, mouseX, mouseY, missileWidth, missileHeight);
  missileList.add(newMissile);
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