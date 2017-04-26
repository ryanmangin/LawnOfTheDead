Base base = new Base();
Player player = new Player();
boolean up, down, left, right;
String s;
ArrayList<Missle> missleList = new ArrayList<Missle>();

void setup(){
  size(1200, 800);
  player.xPos = 300;
  player.yPos = 375;
}

void draw(){
  background(0);
  runMissles();
  player.display();
  player.update(up, down, left, right);
  base.display();
  fill(150);
  textSize(12);
  text(frameRate, 0, 10);
}






//displays missles if on screen
void runMissles(){
  for(int i = 0; i < missleList.size(); i++){
    Missle currentMissle = missleList.get(i);
    if(currentMissle.inBounds()){
      currentMissle.display();
      currentMissle.update();
    }else{
      missleList.remove(currentMissle);
    }
  }
}

//creates missle
void mousePressed(){
  Missle newMissle = new Missle(player.xPos, player.yPos, mouseX, mouseY);
  missleList.add(newMissle);
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