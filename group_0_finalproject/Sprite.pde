class Sprite{
  PImage[] objectSprite;
  int imgCount, frame, animationTimer = 0, animationTimerValue = 100, deadTimerValue = 200;

  
  void sprite(String imgName, int count){
    imgCount = count;
    objectSprite = new PImage[imgCount];
    for(int i = 0; i < imgCount; i++){
      String filename = imgName + nf(i + 1, 2) + ".png";
      objectSprite[i] = loadImage(filename);
    }
  }
  void display(float xpos, float ypos, float obj_width, float obj_height){
    image(objectSprite[frame], xpos, ypos, obj_width, obj_height);
    if((millis() - animationTimer) >= animationTimerValue){
      frame = (frame + 1) % imgCount;
      animationTimer = millis();
    }
  }
  void dead(float xpos, float ypos, float obj_width, float obj_height){
    image(objectSprite[frame], xpos, ypos, objectSprite[frame].width * obj_width, objectSprite[frame].height * obj_height);
    if((millis() - animationTimer) >= deadTimerValue){
      frame = (frame + 1) % imgCount;
      animationTimer = millis();
    }
  }
}