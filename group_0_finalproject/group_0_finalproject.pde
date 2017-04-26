Base base = new Base();
Player player = new Player();
boolean up, down, left, right;
String s;
ArrayList<Missile> missileList = new ArrayList<Missile>();

void setup(){
  size(1200, 800);
  player.xPos = 300;
  player.yPos = 375;
}

void draw(){
  background(0);
  runMissiles();
  player.display();
  player.update(up, down, left, right);
  base.display();
  fill(150);
  textSize(12);
  text(frameRate, 0, 10);
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
  if(key == 'w'){
    up = true;
  }
  if(key == 'a'){
    left = true;
  }
  if(key == 's'){
    down = true;
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
  if(key == 'w'){
    up = false;
  }
  if(key == 's'){
    down = false;
  }
}