class Zombie{
  ArrayList<Zombie> zombieList = new ArrayList<Zombie>();
  float zombieMaxHP, zombieHP, speed, attackDamage, attackSpeed, timer, displayHP, spawnTime, spawnRate = 1, zombie_num;
  int zombieCount;
  float yPos = 700;
  float xPos = 1600;
  float zHeight = 100;
  float zWidth = 50;
  boolean allDead;
  
  
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
  
  void moveZombie(){
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
      fill(0);
      rect(xPos, yPos, zWidth, zHeight);
      healthBar();
      moveZombie();
      collision();
    }
  }
  
  void collision(){
    for(int i = 0; i < missile.missileList.size(); i++){   
      Missile currentMissile = missile.missileList.get(i);
      if(currentMissile.xPos > xPos-20 && currentMissile.xPos < xPos-5+zWidth){
        if(currentMissile.yPos > yPos-10 && currentMissile.yPos < yPos-10+zHeight){
          zombieHP -= player.damage;
          missile.missileList.remove(currentMissile);
          //sound effect here
        }
      }
    }
  }
  
  void zombieList(float zombie_num){
    if(millis() - spawnTime > spawnRate * 1000 & zombieCount < zombie_num){
      Zombie newZombie = new Zombie(3, 4, 1, 1);
      zombieList.add(newZombie);
      zombieCount += 1; 
      spawnTime = millis();
    }
  }
  
  void runZombie(float zombie_num){
    zombieList(zombie_num);
    for(int i = 0; i < zombieList.size(); i++){
      Zombie currentZombie = zombieList.get(i);
      currentZombie.display();
      if(currentZombie.zombieHP <= 0){
        zombieList.remove(currentZombie);
      }
    }
  }
  
  void allDead(){
    if(zombieList.size() == 0){
      allDead = true;
    } else{
        allDead = false;
    }
  }
}