Shelter shelter = new Shelter();
Wave_Info data = new Wave_Info();
Player player = new Player();
Missile missile = new Missile(player.xPos, player.yPos, mouseX, mouseY);
Zombie zombie = new Zombie(0, 0, 0, 0);
boolean gameRunning, left, right;
IntList wave_list;
IntList money_list;
IntList zombie_list;
float currentHP, maxHP, zombie_num;
boolean new_wave;



void setup(){
  currentHP = 2000;
  maxHP = 2000;
  player.damage = 1;
  gameRunning = true;
  wave_list = new IntList();
  money_list = new IntList();
  zombie_list = new IntList();
  Table table = loadTable("Waves.csv", "header");
  for (TableRow r : table.rows()) {
      wave_list.append(r.getInt("Wave"));
      money_list.append(r.getInt("Money"));
      zombie_list.append(r.getInt("Zombies"));
    }
  size(1600, 800);
  
  
  //adding
  player.xPos = 450;
  player.yPos = 420;
  
  
}

void draw(){
  if(gameRunning){
    if(currentHP <= 0){
      gameRunning = false;
      print("game over");
    }
    background(200);
    data.update();
    runShelter();
    player.runPlayer();
    missile.runMissiles();
    zombie_num = data.zombie_num;
    zombie.runZombie(zombie_num);
    showFramerate();
    zombie.allDead();
    if(millis() > 1000 & zombie.allDead){
      print('x');
      data.i += 1;
      zombie.zombieCount = 0;
    }
  }
}

void runShelter(){
  shelter.display(currentHP, maxHP);
}

void showFramerate(){
  fill(150);
  textSize(12);
  text(frameRate, 0, 10);
  
}

//creates missile
void mousePressed(){
  Missile newMissile = new Missile(player.xPos, player.yPos, mouseX, mouseY);
  missile.missileList.add(newMissile);
}

//moves character
void keyPressed(){
  if(key == 'a'){
    left = true;
  }
  if(key == 'd'){
    right = true;
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
}