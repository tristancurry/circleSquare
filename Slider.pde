//Adapted from Slider class by Chris Heddles (github cheddles)
//(from FractionVisualiser)

class Slider {

  int sMax;  // maximum value
  int sMin;  // minimum value
  int value;  // current value
  
  int posX; //x-position of slider
  int posY; //y-position of slider
  int sWidth; //slider width  (pixels)
  float sPower; //set to change slider behaviour (linear = 1, quadratic = 2 etc)
  
  int ballPosX;
  int ballPosY;
  int ballDiameter;
  boolean dragging=false;
  boolean mouseOver=true;
  int dragOffset;  //horizontal offset of the mouse from the ball centre when dragging
  int xmin;
  int xmax;

  Slider(int posX_, int posY_, int sliderWidth, int minValue, int maxValue, int startValue) {
    sMax = maxValue;  //to make available to methods
    sMin = minValue;
    posX = posX_;
    posY = posY_;
    sWidth = sliderWidth;
    value = startValue;
    sPower = 1.0;
  }
  
    Slider(int posX_, int posY_, int sliderWidth, int minValue, int maxValue, int startValue, float sPower_) {
    sMax = maxValue;  //to make available to methods
    sMin = minValue;
    posX = posX_;
    posY = posY_;
    sWidth = sliderWidth;
    value = startValue;
    sPower = sPower_;
  }

  void display() {
    stroke(0);
    strokeWeight(int(height/100));
    xmin=int(round(posX - 0.5*sWidth));
    xmax=int(round(posX + 0.5*sWidth));
    ballDiameter = int(min(height/12, width/20));
    ballPosX = max(int(round(pow(float(value-sMin)/float(sMax-sMin),1/sPower)*(xmax-xmin)+xmin)), xmin);
    ballPosY = posY;
    line(xmin, posY, xmax, posY);
    fill(0);
    if (mouseOver) fill(255);
    ellipse(ballPosX, ballPosY, ballDiameter, ballDiameter);
    drawArrow();
  }

  void clicked(int mx, int my) {
    float d = pow(pow(mx-ballPosX, 2)+pow(my-ballPosY, 2), 0.5);
    if (d < ballDiameter) {
      dragging = true;

      dragOffset = ballPosX-mx;
    }
  }

  void drag() {
    int newloc = mouseX + dragOffset;
    //stop out of range dragging
    if (newloc>xmax) newloc=xmax;
    if (newloc<xmin) newloc=xmin;

    //check to see if moved far enough for integer change
    if ((pow(float(newloc -xmin), sPower) - pow(float(ballPosX - xmin), sPower))>pow(float(xmax-xmin),sPower)/(2.0*(sMax-sMin))) value++;
    if ((pow(float(ballPosX - xmin),sPower)- pow(float(newloc - xmin), sPower))>pow(float(xmax-xmin), sPower)/(2*(sMax-sMin))) value--;
  }

  void hover(int mx, int my) {
    float d = pow(pow(mx-ballPosX, 2)+pow(my-ballPosY, 2), 0.5);
    if (d < ballDiameter) {
      mouseOver = true;
    } else {
      mouseOver = false;
    }
  }

  void drawArrow() {
    // draw a red arrow indicating slider motion
    stroke(255, 0, 0);
    strokeWeight(10);
    strokeCap(ROUND);
    line(ballPosX-ballDiameter, ballPosY, ballPosX+ballDiameter, ballPosY);
    line(ballPosX+ballDiameter, ballPosY, ballPosX+ballDiameter*0.7, (ballPosY-ballDiameter*0.5));
    line(ballPosX-ballDiameter, ballPosY, ballPosX-ballDiameter*0.7, (ballPosY-ballDiameter*0.5));
    line(ballPosX+ballDiameter, ballPosY, ballPosX+ballDiameter*0.7, (ballPosY+ballDiameter*0.5));
    line(ballPosX-ballDiameter, ballPosY, ballPosX-ballDiameter*0.7, (ballPosY+ballDiameter*0.5));

    fill(0, 0, 0, 100);
    strokeWeight(0);
    ellipse(ballPosX, ballPosY, ballDiameter, ballDiameter);
    strokeWeight(5);
  }
}

