class Missile{
  
  float xPos, yPos, xSpeed, ySpeed, mWidth, mHeight, m, angle;
  boolean inBounds = true;

  Missile(float x, float y, float mx, float my){
    PVector playerPosition = new PVector(x, y);
    PVector mousePosition = new PVector(mx, my);
    mousePosition.sub(playerPosition);
    mousePosition.normalize();
    mousePosition.mult(20);
    xPos = x;
    yPos = y;
    xSpeed = mousePosition.x;
    ySpeed = mousePosition.y;
    mWidth = 10;
    mHeight = 10;
    // calculating angle
    m = (y - my)/(x - mx);
    angle = atan(m);

  }
  boolean inBounds(){
    if(xPos > 400 && xPos < 1610 && yPos > -10 && yPos < 800){
      return true;
    }else{
      return false;
    }
  }
  void display(){
    noStroke();    
    fill(255, 246, 0);
    pushMatrix();
    translate(xPos + 10, yPos);
    rotate(angle);
    ellipse(0, 0, 30, 20);
    fill(255);
    ellipse(0, 0, 15, 10);    
    popMatrix();
  }
  void update(){
    xPos += xSpeed;
    yPos += ySpeed;
  }
}