class Player{
  int xSpeed, ySpeed, damage;
  PVector playerPos = new PVector(450, 450);
  
  void display(){
    fill(255);
    rect(playerPos.x, playerPos.y, 30, 80);
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
    