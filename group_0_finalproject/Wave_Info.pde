class Wave_Info{
  int wave;
  int money;
  int zombie_num;
  int i = 0;
  
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