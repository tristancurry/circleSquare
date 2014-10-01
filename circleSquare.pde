//circleSquare                                                                              //
//A toy for exploring polygons of fixed long radius                                         //
//based on Conrad Wolfram's applet seen in https://www.youtube.com/watch?v=60OVlfAUPJg      //
//(circleSquare.pde)                                                                        //
//////////////////////////////////////////////////////////////////////////////////////////////
//by Tristan Miller, 2014                                                                   //
//Please send any feedback and suggestions to tristan.miller@asms.sa.edu.au                 //
//Full source repository is at https://github.com/tristanmiller/circleSquare                //
//                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////
//This file is part of circleSquare.                                                        //
//                                                                                          //
//  circleSquare is free software: you can redistribute it and/or modify                    //
//  it under the terms of the GNU General Public License as published by                    //
//  the Free Software Foundation, either version 3 of the License, or                       //
//  (at your option) any later version.                                                     //
//                                                                                          //
//  circleSquare is distributed in the hope that it will be useful,                         //
//  but WITHOUT ANY WARRANTY; without even the implied warranty of                          //
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                           //
//  GNU General Public License for more details.                                            //
//                                                                                          //
// You should have received a copy of the GNU General Public License                        //
//  along with circleSquare.  If not, see <http://www.gnu.org/licenses/>.                   //
//////////////////////////////////////////////////////////////////////////////////////////////


int sides;
int r;
float perim;
float polyCentre;
float mouseAngle;
float tempAngle;
float polyAngle;
color col;
PImage picker;
boolean rotCursor;
boolean rotDragging;
PImage rotWhite;
PImage rotBlack;

int helpCounterThreshold = 15;
int sliderHelpCounter;
int pickerHelpCounter;
int polyHelpCounter;

int clickTimerThreshold = 900;
int clickTimer = 0;

ColPicker yourPicker;
Slider sideSlider;

//////Setup: runs once at program start//////
void setup() {
  
  size(540, 960);
  
  if (frame != null) {
    frame.setResizable(true);  //needed for resizeable window
  }
  
  smooth();

  picker = loadImage("spectrum.jpg");
  rotWhite = loadImage("rotWhite.png");
  rotBlack = loadImage("rotBlack.png");

  yourPicker = new ColPicker(width/2, 0, 0, 0, picker);
  sideSlider = new Slider(width/2, 0, 10, 3, 100, 4, 2);

  sliderHelpCounter = helpCounterThreshold;
  pickerHelpCounter = helpCounterThreshold;
  polyHelpCounter = helpCounterThreshold;

  rectMode(CENTER);
  imageMode(CENTER);
  
  rotCursor = false;
  cursor(HAND);
}


//////Draw: loops continuously unless told not to//////
void draw() {
  background(50, 40, 100);
  sides = sideSlider.value; //attach number of sides to slider value
  r = int(round(0.23*height));
  if (r > width/2) r = width/2;
  polyCentre = height - 1.2*r;


  //change cursor depending on mouse position
  if (!rotDragging && !sideSlider.dragging) { //if anything apart from the colour picker is being dragged, don't change the cursor!
    if (yourPicker.contains(mouseX, mouseY)) {
      noCursor();
      yourPicker.selX = mouseX;
      yourPicker.selY = mouseY;
      yourPicker.selector = true;
    } else if (sq(mouseX - width/2) + sq(mouseY - (polyCentre))< sq(1.2*r)) {
      noCursor();
      rotCursor = true;
    } else {
      yourPicker.selector = false;
      rotCursor = false;
      cursor(HAND);
    }
  }

  //update and draw slider
  sideSlider.hover(mouseX, mouseY);
  if (sideSlider.dragging) sideSlider.drag();
  sideSlider.posX = width/2;  
  sideSlider.posY = int(round(0.4*r));
  sideSlider.sWidth = int(round(0.85*width));
  sideSlider.display();

  //update and draw colour picker
  yourPicker.posX = 0.5*width;  //the size and shape have to be set every frame if the screen is resizeable. Otherwise it would be done once in setup.
  yourPicker.posY = 1.3*r;
  yourPicker.pWidth = 0.85*width;
  yourPicker.pHeight = 0.6*r;          
  yourPicker.display();
  if (yourPicker.dragging && yourPicker.contains(mouseX, mouseY)) {
    loadPixels();
    col = pixels[mouseY*width + mouseX];
  }

  //draw a border around the colour picker
  pushMatrix();
  stroke(255);
  strokeWeight(2);
  noFill();
  translate(yourPicker.posX, yourPicker.posY);
  rect(0, 0, yourPicker.pWidth + 2, yourPicker.pHeight+ 2);
  popMatrix();

  //draw polygon
  if (rotDragging) updatePolyAngle();
  drawPolygon();

  //draw the special rotation cursor if need be
  if (rotCursor) drawRotCursor();

  //overlay text labels
  drawLabelText();
  drawHelpText(); 
  drawCreditText();
} 





////////////////////////
void drawPolygon() {
  float[][] vertices = new float[sides][2];
  float a = TWO_PI/sides;      //keeping things in radians
  perim = sides*2*r*sin(a/2);  //using trigonometry to determine side length


  //Find the coordinates of the vertices of the polygon
  for (int i = 0; i < sides; i++) {
    if (i<= sides/2) {
      vertices[i][0] = r*cos(i*a);
      vertices[i][1] = r*sin(i*a);
    } else {
      vertices[i][0] = vertices[sides - i][0];      //exploit symmetry to find further vertices
      vertices[i][1] = -1*vertices[sides - i][1];
    }
  }

  //draw the polygon itself
  pushMatrix();
  rectMode(CENTER);
  translate(width/2, polyCentre);
  rotate(polyAngle);
  fill(col);
  stroke(255, 255, 255);
  strokeWeight(2);

  beginShape();
  for (int i = 0; i < sides; i++) {
    vertex(vertices[i][0], vertices[i][1]);
  }
  endShape(CLOSE);

  popMatrix();
}


////////////////////////
void updatePolyAngle() {
  float dAngle = mouseAngle - tempAngle;
  polyAngle = polyAngle + dAngle;
}

