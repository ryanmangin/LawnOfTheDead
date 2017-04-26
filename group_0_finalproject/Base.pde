class Base{
  
  void display(int current, int max){
    int currentHP = current;
    int maxHP = max;
    fill(255);
    rect(0, 0, 200, 800);
    fill(0);
    String hpStr = str(maxHP) + " / " + str(maxHP);
    text(hpStr, 50, 50);
    
  }
}