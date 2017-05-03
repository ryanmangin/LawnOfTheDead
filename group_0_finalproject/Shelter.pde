class Shelter {

  void display(float current, float max) {
    float currentHP = current;
    float maxHP = max;
    String fCurrent = new Float(currentHP).toString().replaceAll("\\.?0*$", "");
    String fMax = new Float(maxHP).toString().replaceAll("\\.?0*$", "");
    String health = "HP: " + fCurrent  + "/" + fMax;
    image(hazard, 0, 0);
    stroke(0);
    fill(175, 172, 172);
    rect(350, 0, 50, 800);
    fill(0);
    image(wire, 350, 0);  
    image(wire, 350, 20);
    image(wire, 350, 242);
    image(wire, 350, 262);
    image(wire, 350, 484);
    image(wire, 350, 504);
    image(wire, 350, 726);
    image(wire, 350, 746);
    healthBar();
    fill(0);
    text(health, 110, 403);
    
  }
  
  void healthBar(){
    float displayHP = currentHP/maxHP;
    fill(104, 14, 0);
    rect(10, 390, 300, 20);
    fill(255, 0, 0);
    rect(10, 390, 300*displayHP, 20);
   
  }
  
  void runShelter(){
    shelter.display(currentHP , maxHP);
  }
}