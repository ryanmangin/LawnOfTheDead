class Zombie{
  PVector zombiePos = new PVector();
  float zombieMaxHP, zombieHP, speed, attackDamage, attackSpeed, timer, displayHP, spawnTime, spawnRate = 1, zombie_num;
  
  float zHeight = 100;
  float zWidth = 50;
  
  Zombie(float hp, float s, float ad, float as){
    zombieMaxHP = hp;
    zombieHP = hp;
    speed = s;
    attackDamage = ad;
    attackSpeed = as;
    if(int(random(4)) > 1){
      zombiePos.y = int(random(800));
      zombiePos.x = 1600;
    }else if(int(random(1)) == 0){
      zombiePos.x = 1400 + random(200);
      zombiePos.y = 0;
    }else{
      zombiePos.x = 1400 + random(200);
      zombiePos.y = 800;
    }
    
  }
  
  void healthBar(){
    displayHP = zombieHP/zombieMaxHP;
    fill(255,0,0);
    rect(zombiePos.x, zombiePos.y-10, 50, 5);
    fill(0,255,0);
    rect(zombiePos.x, zombiePos.y-10, 50*displayHP, 5);
  }
  
  void moveZombie(){
    
    PVector attraction = new PVector(400, 400).sub(zombiePos);
    PVector playerPos = new PVector(gPlayerPos.x, gPlayerPos.y).sub(zombiePos);
    if(zombiePos.x < 402){
      zombiePos.x = 400;
      attackBase();
    }else{
    //if(zombiePos.x < 510 && zombiePos.x > 400){
    //    zombiePos.x -= speed + 1;
    //}else{
    //  if(playerPos.mag() < attraction.mag()){
    //    if(zombiePos.x > 405){
    //      playerPos.normalize();
    //      zombiePos.x += playerPos.x*speed;
    //      zombiePos.y += playerPos.y*speed;
    //    }
    //  }
    //}
      attraction.normalize();
      //attraction.mult(1);
      zombiePos.add(attraction);
      zombiePos.x -= 2;
    }
    
  }
  
  void attackBase(){
    if(millis() - timer > attackSpeed*1000){
      currentHP -= attackDamage;
      timer = millis();
    }
  }
  void display(){
    if (zombieHP > 0){
      zombieSprite.display(zombiePos.x, zombiePos.y, zWidth, zHeight);
      healthBar();
      moveZombie();
      collision();
    }
  }
  
  void collision(){
    for(int i = 0; i < missileList.size(); i++){   
      Missile currentMissile = missileList.get(i);
      if(currentMissile.xPos > zombiePos.x-currentMissile.mWidth && currentMissile.xPos < zombiePos.x-5+zWidth){
        if(currentMissile.yPos > zombiePos.y-currentMissile.mHeight && currentMissile.yPos < zombiePos.y-10+zHeight){
          zombieHP -= player.damage;
          missileList.remove(currentMissile);
          //sound effect here
        }
      }
    }
  }
  
  
  
  
  
 
}