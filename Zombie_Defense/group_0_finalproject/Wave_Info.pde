class Wave_Info{
  int wave;
  int money;
  int zombie_num;
  int i = 0;
  void wave_num(){
    wave = wave_list.get(i);
    if(zombie_num == 0){
      i += 1;
    }
  }
  void money(){
    money = money_list.get(i);
  }
  void zombie_num(){
    zombie_num = zombie_list.get(i);
  }
  void update(){
    wave_num();
    money();
    zombie_num();
  }
}