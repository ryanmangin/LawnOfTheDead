class Zombie{
  float health, speed, attackDamage, attackSpeed, timer;
  float yPos = 700;
  float xPos = 1600;
  float zHeight = 100;
  float zWidth = 50;
  
  Zombie(float hp, float s, float ad, float as){
    health = hp;
    speed = s;
    attackDamage = ad;
    attackSpeed = as;
  }
  
  void health(){
    health = 100;
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
    if (health > 0){
      rect(xPos, yPos, zWidth, zHeight);
      runZombie();
      collision();
    }  
  }
  
  void collision(){
    for(int i = 0; i < missileList.size(); i++){   
      Missile currentMissile = missileList.get(i);
      if(currentMissile.xPos > xPos-20 && currentMissile.xPos < xPos-5+zWidth){
        if(currentMissile.yPos > yPos-10 && currentMissile.yPos < yPos-10+zHeight){
          health -= player.damage;
          missileList.remove(currentMissile);
          print(health);
          //sound effect here
        }
      }
    }
  }
}