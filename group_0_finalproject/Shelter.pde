class Shelter {

  void display(float current, float max) {
    float currentHP = current;
    float maxHP = max;
    String fCurrent = new Float(currentHP).toString().replaceAll("\\.?0*$", "");
    String fMax = new Float(maxHP).toString().replaceAll("\\.?0*$", "");
    String health = "HP: " + fCurrent  + "/" + fMax;
    fill(255);
    rect(0, 0, 400, 800);
    healthBar();
    fill(0);
    text(health, 150, 403);
    
  }
  
  void healthBar(){
    float displayHP = currentHP/maxHP;
    fill(255,0,0);
    rect(50, 390, 300, 20);
    fill(0,255,0);
    rect(50, 390, 300*displayHP, 20);
   
  }
  
  void runShelter(){
    shelter.display(currentHP , maxHP);
  }
}