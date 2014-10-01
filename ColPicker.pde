class ColPicker {

  float posX;
  float posY;

  float pWidth;
  float pHeight;

  PImage pickerImage;
  
  float selX;
  float selY;
  
  boolean selector;
  boolean dragging;


  ColPicker(float posX_, float posY_, float pWidth_, float pHeight_, PImage pickerImage_) {
    posX = posX_;
    posY = posY_;
    pWidth = pWidth_;
    pHeight = pHeight_;

    pickerImage = pickerImage_;
    selector = false;
    dragging = false;
  }

  void display() {
    imageMode(CENTER);
    image(pickerImage, posX, posY, pWidth, pHeight);
    if(selector) drawSelector();
  }
  
  void drawSelector(){
   ellipseMode(CENTER);
   strokeWeight(3);
   noFill();
   pushMatrix();
   translate(selX + 1,selY + 1);
   stroke(50);
   ellipse(0,0,0.12*pHeight,0.12*pHeight);
   translate(-1,-1);
   stroke(255);
   ellipse(0,0,0.12*pHeight,0.12*pHeight);
   popMatrix();
  }
  
  
  boolean contains(int x, int y){
    
    if(x >= this.posX - this.pWidth/2 &&
    x <= this.posX + this.pWidth/2 &&
    y >= this.posY - this.pHeight/2 &&
    y <= this.posY + this.pHeight/2){
      return true;
    } else {
      return false;
    }
    
  }
}

