class Robot {
  float xPos, yPos, roboWidth = 50, roboHeight = 50;

  Robot(float x, float y, float mx, float my) {
    PVector playerPosition = new PVector(x, y);
    PVector mousePosition = new PVector(mx, my);
    xPos = x - 30;
    yPos = y;
  }

  void display() {
    ellipse(xPos, yPos, roboWidth, roboHeight);
    image(muzzle_flash, xPos - 25, yPos - 45);
  }
}