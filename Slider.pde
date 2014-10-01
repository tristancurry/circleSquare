//Adapted from Slider class by Chris Heddles (github cheddles)
//(from FractionVisualiser)

class Slider {

  int sMax;  // maximum value
  int sMin;  // minimum value
  int value;  // current value
  
  int posX;
  int posY;
  int sWidth;
  
  int ballPosX;
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
  }

  void display() {
    stroke(0);
    strokeWeight(int(height/100));
    xmin=int(round(posX - 0.5*sWidth));
    xmax=int(round(posX + 0.5*sWidth));
    ballDiameter = int(min(height/12, width/20));
    ballPosX = max(int(float(value-sMin)/float(sMax-sMin)*(xmax-xmin)+xmin), xmin);
    line(xmin, posY, xmax, posY);
    fill(0);
    if (mouseOver) fill(255);
    ellipse(ballPosX, posY, ballDiameter, ballDiameter);
    drawArrow();
    println("xmin, xmax " + xmin + ", " + xmax);
    println("ball X = " + ballPosX);
    println("slider dragging = " + dragging);
  }

  void clicked(int mx, int my) {
    float d = pow(pow(mx-ballPosX, 2)+pow(my-posY, 2), 0.5);
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
    if ((newloc-ballPosX)>(xmax-xmin)/(2*(sMax-sMin))) value++;
    if ((ballPosX-newloc)>(xmax-xmin)/(2*(sMax-sMin))) value--;
  }

  void hover(int mx, int my) {
    float d = pow(pow(mx-ballPosX, 2)+pow(my-posY, 2), 0.5);
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
    line(ballPosX-ballDiameter, posY, ballPosX+ballDiameter, posY);
    line(ballPosX+ballDiameter, posY, ballPosX+ballDiameter*0.7, (posY-ballDiameter*0.5));
    line(ballPosX-ballDiameter, posY, ballPosX-ballDiameter*0.7, (posY-ballDiameter*0.5));
    line(ballPosX+ballDiameter, posY, ballPosX+ballDiameter*0.7, (posY+ballDiameter*0.5));
    line(ballPosX-ballDiameter, posY, ballPosX-ballDiameter*0.7, (posY+ballDiameter*0.5));

    fill(0, 0, 0, 100);
    strokeWeight(0);
    ellipse(ballPosX, posY, ballDiameter, ballDiameter);
    strokeWeight(5);
  }
}

