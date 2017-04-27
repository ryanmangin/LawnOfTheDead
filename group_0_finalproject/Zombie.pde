class Zombie{
  ArrayList<Zombie> zombieList = new ArrayList<Zombie>();
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
  
  void zombieList(){
    Wave_Info wave = new Wave_Info();
    wave.update();
    for(int i = 0; i < wave.zombie_num; i++){
      Zombie newZombie = new Zombie(3, 4, 1, 1);
      zombieList.add(newZombie);
    }
  }
  
  void runZombie(){
    zombieList();
    Wave_Info wave = new Wave_Info();
    wave.update();
    int s = second();
    for(int i = 0; i < wave.zombie_num; i++){
      Zombie currentZombie = zombieList.get(i);
      currentZombie.display();      
    }
  }
}