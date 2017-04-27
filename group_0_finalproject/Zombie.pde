class Zombie{
  float zombieMaxHP, zombieHP, speed, attackDamage, attackSpeed, timer, displayHP;
  float yPos = 700;
  float xPos = 1600;
  float zHeight = 100;
  float zWidth = 50;
  
  Zombie(float hp, float s, float ad, float as){
    zombieMaxHP = hp;
    zombieHP = hp;
    speed = s;
    attackDamage = ad;
    attackSpeed = as;
  }
  
  void healthBar(){
    displayHP = zombieHP/zombieMaxHP;
    fill(255,0,0);
    rect(xPos, yPos-10, 50, 5);
    fill(0,255,0);
    rect(xPos, yPos-10, 50*displayHP, 5);
  }
  
  void runZombie(){
    if(xPos > 500){
      xPos -= speed;
    }else{
      attack();
    }
  }
  void attack(){
    if(millis() - timer > attackSpeed*1000){
      currentHP -= attackDamage;
      timer = millis();
    }
  }
  void display(){
    if (zombieHP > 0){
      rect(xPos, yPos, zWidth, zHeight);
      healthBar();
      runZombie();
      collision();
    }  
  }
  
  void collision(){
    for(int i = 0; i < missileList.size(); i++){   
      Missile currentMissile = missileList.get(i);
      if(currentMissile.xPos > xPos-20 && currentMissile.xPos < xPos-5+zWidth){
        if(currentMissile.yPos > yPos-10 && currentMissile.yPos < yPos-10+zHeight){
          zombieHP -= player.damage;
          missileList.remove(currentMissile);
          print(zombieHP);
          //sound effect here
        }
      }
    }
  }
}