Base base = new Base();
Player player = new Player();
boolean up, down, left, right;
String s;
void setup(){
  size(1200, 800);
  player.xPos = 300;
  player.yPos = 375;
}

void draw(){
  background(0);
  
  
  player.display();
  player.update(up, down, left, right);
  base.display();
  fill(150);
  textSize(12);
  text(frameRate, 0, 10);
}












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