class Missile{
  float xPos, yPos, xSpeed, ySpeed;
  boolean inBounds = true;
  Missile(float x, float y, float mx, float my){
    PVector playerPosition = new PVector(x, y);
    PVector mousePosition = new PVector(mx, my);
    mousePosition.sub(playerPosition);
    mousePosition.normalize();
    mousePosition.mult(5);
    xPos = x;
    yPos = y;
    xSpeed = mousePosition.x;
    ySpeed = mousePosition.y;
  }
  boolean inBounds(){
    if(xPos > 0 && xPos < 1610 && yPos > -10 && yPos < 800){
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