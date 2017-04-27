class Shelter {

  void display(float current, float max) {
    float currentHP = current;
    float maxHP = max;
    String fCurrent = new Float(currentHP).toString().replaceAll("\\.?0*$", "");
    String fMax = new Float(maxHP).toString().replaceAll("\\.?0*$", "");
    String health = "HP: " + fCurrent  + "/" + fMax;
    fill(255);
    rect(0, 500, 500, 300);
    healthBar();
    fill(0);
    text(health, 210, 650);
    
  }
  
  void healthBar(){
    float displayHP = currentHP/maxHP;
    print(displayHP, currentHP, maxHP, "\n");
    fill(255,0,0);
    rect(100, 635, 300, 20);
    fill(0,255,0);
    rect(100, 635, 300*displayHP, 20);
   
  }
}