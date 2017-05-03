ArrayList<Zombie> zombieList = new ArrayList<Zombie>();
ArrayList<Missile> missileList = new ArrayList<Missile>();
boolean gameRunning, left, right, up, down;
IntList wave_list;
IntList money_list;
IntList zombie_list;
float currentHP, maxHP, zombie_num, missileWidth, missileHeight;
String gunType = "standard";
boolean new_wave;
PImage img;
PVector gPlayerPos = new PVector(0, 0);
Shelter shelter = new Shelter();
Wave_Info data = new Wave_Info();
Player player = new Player();
Zombie zombie = new Zombie(0, 0, 0, 0);
Sprite zombieSprite = new Sprite();
Sprite characterSpriteRun = new Sprite();
Sprite characterSpriteRunBack = new Sprite();
Sprite characterSpriteIdle = new Sprite();
Crosshead crosshead = new Crosshead();


Zombie z = new Zombie(4, 4, 4, 4);



void setup(){
  img = loadImage("background.png");
  currentHP = 2000;
  maxHP = 2000;
  player.damage = 1;
  gameRunning = true;
  wave_list = new IntList();
  money_list = new IntList();
  zombie_list = new IntList();
  zombieSprite.sprite("Zombie_Girl/PNG/Animation/Walk_", 6);
  characterSpriteRun.sprite("Character/Run_", 10);
  characterSpriteRunBack.sprite("Character/RunBack_", 10);
  characterSpriteIdle.sprite("Character/Idle__", 10);
  Table table = loadTable("Waves.csv", "header");
  for (TableRow r : table.rows()) {
      wave_list.append(r.getInt("Wave"));
      money_list.append(r.getInt("Money"));
      zombie_list.append(r.getInt("Zombies"));
    }
  size(1600, 800);
  
  
}

void draw(){
  if(gameRunning){
    if(currentHP <= 0){
      gameRunning = false;
      print("game over");
    }
    tint(170);
    image(img, 400, -170);
    tint(220);
    data.update();
    shelter.runShelter();
    runPlayer();
    runMissiles();
    
    showFramerate();
    z.display();
    //ellipse(500, 400, 30, 30);
    crosshead.display();
  }
  
}



void showFramerate(){
  fill(150);
  textSize(12);
  text(frameRate, 0, 10);
  
}

void runZombie(){
    for(int i = 0; i < zombieList.size(); i++){
      Zombie currentZombie = zombieList.get(i);
      currentZombie.display();
      if(currentZombie.zombieHP <= 0){
        zombieList.remove(currentZombie);
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
  if(up){
    player.displayRun();
  } else if(left){
    player.displayRunBack();
  } else if( right | down){
    player.displayRun();
  }
  else{
    player.displayIdle();
  }
    player.update(left, right, up, down);
  }









//creates missile
void mousePressed(){
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