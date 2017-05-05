class Lightning{
  
  float xPos, yPos, zX, zY;
  boolean inBounds = true;
  PVector lightningPos = new PVector();

  Lightning(float x, float y){
    xPos = x;
    yPos = y;
  }
  
  void display(float xPos, float yPos){
    tint(255);
    float rand = random(-8, 8);
    imageMode(CENTER);
    if(left){
      lightningPos.x = xPos - 27;
      lightningPos.y = yPos - 20;
      image(lightningImg, xPos - 27, yPos - 20, 40 + rand, 40 + rand);
    } else{
      lightningPos.x = xPos + 60;
      lightningPos.y = yPos - 20;
      image(lightningImg, xPos + 60, yPos - 20, 40 + rand, 40 + rand);
    }
    for(int i = 0; i < zombieList.size(); i++){
      Zombie currentZombie = zombieList.get(i);
      if(currentZombie.zombiePos.dist(lightningPos) <= 200){
        stroke(7, 102, 255);
        strokeWeight(3);
        fill(7, 102, 255);
        line(lightningPos.x, lightningPos.y, currentZombie.zombiePos.x, currentZombie.zombiePos.y);
        strokeWeight(1);
      }
    }
    imageMode(CORNER);
    tint(220);
  }
}