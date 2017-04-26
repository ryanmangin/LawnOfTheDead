Base base = new Base();
Player player = new Player();
void setup(){
  size(1200, 800);
  player.xPos = 400;
  player.yPos = 400;
}

void draw(){
  background(0);
  player.display();
  player.update();
  base.display();
}

void keyPressed(){
  if(key == 'w'){
    player.ySpeed = -3;
  }
  if(key == 'a'){
    player.xSpeed = -3;
  }
  if(key == 's'){
    player.ySpeed = 3;
  }
  if(key == 'd'){
    player.xSpeed = 3;
  }
}

void keyReleased(){
  player.xSpeed = 0;
  player.ySpeed = 0;
}