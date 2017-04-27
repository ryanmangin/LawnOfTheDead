class Zombie{
  float health;
  float xpos = 1600;
  float speed = 2;
  float attack;
  
  void health(){
    health = 100;
  }
  void walk(){
    if(xpos > 500){
      xpos -= speed;
    }
  }
  //void attack(){
  //  if(xpos == 300){
  //    shelter.currentHP -= attack;
  //  }
  //}
  void display(){
    rect(xpos, 700, 50, 100);
    walk();
  }
}