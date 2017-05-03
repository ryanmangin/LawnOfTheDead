class Player{
  int xSpeed, ySpeed, damage;
  PVector playerPos = new PVector(450, 450);
  
  void displayRun(){
    characterSpriteRun.display(playerPos.x, playerPos.y, 100, 120);
  }
  void displayRunBack(){
    characterSpriteRunBack.display(playerPos.x, playerPos.y, 100, 120);
  }
  void displayIdle(){
    characterSpriteIdle.display(playerPos.x, playerPos.y, 70, 120);
  }
  
  void update(boolean left, boolean right, boolean up, boolean down){
      if(left && playerPos.x > 400){
        xSpeed = -3;
      }else if(right && playerPos.x < 1570){
        xSpeed = 3;
      }else{
        xSpeed = 0;
      }
      if(up && playerPos.y > 0){
        ySpeed = -3;
      }else if(down && playerPos.y < 700){
        ySpeed = 3;
      }else{
        ySpeed = 0;
      }
    playerPos.x += xSpeed;
    playerPos.y += ySpeed;
    gPlayerPos.x = playerPos.x;
    gPlayerPos.y = playerPos.y;
  }
  
  
}
    