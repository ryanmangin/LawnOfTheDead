class Player{
  int xPos, yPos, xSpeed, ySpeed;
  
  
  void display(){
    fill(255);
    rect(xPos, yPos, 20, 50);
  }
  void update(boolean up, boolean down, boolean left, boolean right){
      if(up && yPos > 0){
        ySpeed = -3;
      }else if(down && yPos < 750){
        ySpeed = 3;
      }else{
        ySpeed = 0;
      }
      if(left && xPos > 200){
        xSpeed = -3;
      }else if(right && xPos < 400){
        xSpeed = 3;
      }else{
        xSpeed = 0;
      }
    xPos += xSpeed;
    yPos += ySpeed;
  }
}
    