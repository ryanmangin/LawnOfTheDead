Shelter shelter = new Shelter();
Wave_Info data = new Wave_Info();
Player player = new Player();
boolean gameRunning, left, right;
ArrayList<Missile> missileList = new ArrayList<Missile>();
IntList wave_list;
IntList money_list;
IntList zombie_list;
float currentHP, maxHP;

Zombie a = new Zombie(3, 4, 200, 1);

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
    runShelter();
    data.update();
    a.display();
    runPlayer();
    runMissiles();
    showFramerate();
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

void runPlayer(){
  player.display();
  player.update(left, right);
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

//creates missile
void mousePressed(){
  Missile newMissile = new Missile(player.xPos, player.yPos, mouseX, mouseY);
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