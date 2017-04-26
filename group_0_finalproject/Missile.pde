class Missile{
  int xPos, yPos, xSpeed, ySpeed;
  boolean inBounds = true;
  Missile(int x, int y, int mx, int my){
    xPos = x;
    yPos = y;
    //xSpeed = mx;
    //ySpeed = my;
    xSpeed = 10;
    ySpeed = 0;
  }
  boolean inBounds(){
    if(xPos > 0 && xPos < 1210 && yPos > -10 && yPos < 800){
      return true;
    }else{
      return false;
    }
  }
  void display(){
    fill(255);
    rect(xPos+10, yPos, 10, 10);
  }
  void update(){
    xPos += xSpeed;
    yPos += ySpeed;
  }
  
}