class Player{
  int xPos, yPos, xSpeed, ySpeed;
  
  
  void display(){
    rect(xPos, yPos, 20, 50);
  }
  void update(){
    xPos += xSpeed;
    yPos += ySpeed;
  }
    
}