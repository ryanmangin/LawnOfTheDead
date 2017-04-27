class Wave_Info{
  int wave;
  int money;
  int zombie_num;
  int i = 0;
  boolean new_wave = true;
  Zombie zombie = new Zombie(3, 4, 1, 1);
  
  void wave_num(){
    wave = wave_list.get(i);
  }
  
  void money(){
    money = money_list.get(i);
  }
    
  void zombie_num(){
    zombie_num = zombie_list.get(i);
  }
  
  void update(){    
    money();
    zombie_num();
    wave_num();
  }
}