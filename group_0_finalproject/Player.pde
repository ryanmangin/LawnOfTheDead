class Player{
  int xPos, yPos, xSpeed, damage;
  
  void display(){
    fill(255);
    rect(xPos, yPos, 30, 80);
  }
  
  void update(boolean left, boolean right){
      if(left && xPos > 0){
        xSpeed = -3;
      }else if(right && xPos < 470){
        xSpeed = 3;
      }else{
        xSpeed = 0;
      }
    xPos += xSpeed;    
  }
  
  void runPlayer(){
    player.display();
    player.update(left, right);
  }
}
    