class Crosshead{
  void display(){
    stroke(110, 5, 5);
    fill(255, 0, 0);
    ellipse(mouseX, mouseY, 20, 20);
    fill(0);
    ellipse(mouseX, mouseY, 16, 16);
    rectMode(CENTER);
    fill(255, 0, 0);
    rect(mouseX, mouseY, 2, 24);
    rect(mouseX, mouseY, 24, 2);
    rectMode(CORNER);
  }
}