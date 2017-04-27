class Shelter {

  void display(int current, int max) {
    int currentHP = current;
    int maxHP = max;
    String health = "HP: " + str(currentHP) + "/" + str(maxHP);
    fill(255);
    rect(0, 500, 500, 300);
    fill(170);
    text(health, 200, 650);
  }
}