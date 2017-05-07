class Lightning{
  
  float xPos, yPos, dx, dy, x1, x2, x3, x4, y1, y2, y3, y4, r = 200, timer, timerValue;
  boolean inBounds = true;
  PVector lightningPos = new PVector();
  PVector newZombiePos = new PVector();
  PShape e;
  
  void display(float xPos, float yPos){
    tint(255);
    float rand = random(-8, 8);
    imageMode(CENTER);
    if(left){
      lightningPos.x = xPos - 27;
      lightningPos.y = yPos - 20;
      image(lightningImg, xPos - 27, yPos - 20, 60 + rand, 60 + rand);
    } else{
      lightningPos.x = xPos + 60;
      lightningPos.y = yPos - 20;
      image(lightningImg, xPos + 60, yPos - 20, 60 + rand, 60 + rand);
    }
    for(int i = 0; i < zombieList.size(); i++){
      Zombie currentZombie = zombieList.get(i);
      newZombiePos.x = currentZombie.zombiePos.x + 25;
      newZombiePos.y = currentZombie.zombiePos.y + 50;
      if(newZombiePos.dist(lightningPos) <= r){
        if((millis() - timer) >= timerValue){
          dx = (lightningPos.x - newZombiePos.x) / 4;
          dy = (lightningPos.y - newZombiePos.y) / 4;
          x1 = lightningPos.x - dx + random(-20, 20);
          x2 = lightningPos.x - dx * 2 + random(-20, 20);
          x3 = lightningPos.x - dx * 3 + random(-20, 20);
          x4 = lightningPos.x - dx * 4 + random(-20, 20);
          y1 = lightningPos.y - dy + random(-20, 20);
          y2 = lightningPos.y - dy * 2 + random(-20, 20);
          y3 = lightningPos.y - dy * 3 + random(-20, 20);
          y4 = lightningPos.y - dy * 4 + random(-20, 20);
          timer = millis();
        }
        noFill();
        stroke(61, 203, 255);
        strokeWeight(4);
        beginShape();
        vertex(lightningPos.x, lightningPos.y);
        vertex(x1, y1);
        vertex(x2, y2);
        vertex(x3, y3);
        vertex(x4, y4);
        vertex(newZombiePos.x, newZombiePos.y);
        endShape();
  
        beginShape();
        stroke(255);
        strokeWeight(2);
        vertex(lightningPos.x, lightningPos.y);
        vertex(x1, y1);
        vertex(x2, y2);
        vertex(x3, y3);
        vertex(x4, y4);
        vertex(newZombiePos.x, newZombiePos.y);
        endShape();
        strokeWeight(1);
      }
    } 
    imageMode(CORNER);
    tint(220);
  }
}