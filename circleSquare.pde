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

ColPicker pickNChoose;
Slider sideSlider;


void setup() {
  size(540, 960);
  if (frame != null) {
    frame.setResizable(true);
  }
  smooth();
  rotCursor = false;
  cursor(HAND);
  picker = loadImage("spectrum.jpg");
  rotWhite = loadImage("rotWhite.png");
  rotBlack = loadImage("rotBlack.png");


  pickNChoose = new ColPicker(width/2, 0, 0, 0, picker);
  sideSlider = new Slider(width/2, 0, 10, 3, 100, 4, 2);
  rectMode(CENTER);
  imageMode(CENTER);
}



void draw() {
  background(50, 40, 100);
  sides = sideSlider.value; //this will become subject to slider value
  r = int(round(0.23*height));
  if(r > width/2) r = width/2;
  polyCentre = height - 1.2*r;


//change cursor depending on mouse position
if(!rotDragging && !sideSlider.dragging){ //if anything apart from the colour picker is being dragged, don't change the cursor!

    if (pickNChoose.contains(mouseX, mouseY)) {
    noCursor();
    pickNChoose.selX = mouseX;
    pickNChoose.selY = mouseY;
    pickNChoose.selector = true;
  } else if (sq(mouseX - width/2) + sq(mouseY - (polyCentre))< sq(1.2*r)) {
    noCursor();
    rotCursor = true;
  } else {
    pickNChoose.selector = false;
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
  pickNChoose.posX = 0.5*width;  //the size and shape have to be set every frame if the screen is resizeable. Otherwise it would be done once in setup.
  pickNChoose.posY = 1.3*r;
  pickNChoose.pWidth = 0.85*width;
  pickNChoose.pHeight = 0.6*r;          
  pickNChoose.display();
  if (pickNChoose.dragging && pickNChoose.contains(mouseX, mouseY)) {
    loadPixels();
    col = pixels[mouseY*width + mouseX];
  }


  //draw a border around the colour picker
  pushMatrix();
  stroke(255);
  strokeWeight(2);
  noFill();
  translate(pickNChoose.posX, pickNChoose.posY);
  rect(0, 0, pickNChoose.pWidth + 2, pickNChoose.pHeight+ 2);
  popMatrix();


  //draw polygon
  if(rotDragging) updatePolyAngle();
  drawPolygon();

  //draw the special rotation cursor if need be
  if (rotCursor) drawRotCursor();

  //overlay text labels
  pushMatrix();
  translate(width/2, polyCentre);
  textAlign(CENTER, CENTER);
  fill(0.4*(255-brightness(col)));
  translate(0.01*r, 0.01*r);
  drawText();
  colorMode(HSB);
  fill((hue(col)+70)%255, 1.0*saturation(col), 255);
  colorMode(RGB);
  translate(-0.01*r, -0.01*r);
  drawText();
  popMatrix();
  
  pushMatrix();
  translate(width/2,0);
  translate(0,pickNChoose.posY - 0.5*pickNChoose.pHeight - 0.13*r);
  textSize(0.13*r);
  fill(122);
  text("Click or drag to choose a colour!",0,0);
  popMatrix();
  
  pushMatrix();
  translate(width/2,0);
  translate(0,sideSlider.posY - 0.5*sideSlider.ballDiameter - 0.13*r);
  textSize(0.13*r);
  fill(122);
  text("Drag to change number of sides!",0,0);
  popMatrix();
  
  pushMatrix();
  translate(width/2,0);
  translate(0,polyCentre - 1.13*r);
  textSize(0.13*r);
  fill(122);
  text("Drag to rotate the polygon!",0,0);
  popMatrix();
  
} 




void drawText() {
  textSize(0.20*r);
  text(sides + " sides", 0, -0.18*r);
  textSize(0.08*r);
  text(r + " units from centre to corner", 0, 0);
  text(round(perim) + " units in perimeter", 0, 0.13*r);
}

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

void mousePressed() {
  sideSlider.clicked(mouseX, mouseY);
  if (pickNChoose.contains(mouseX, mouseY)) pickNChoose.dragging = true;
  if (rotCursor) rotDragging = true;
}

void mouseReleased() {
  sideSlider.dragging = false;
  pickNChoose.dragging = false;
  rotDragging = false;
}


void drawRotCursor() {
  int cursorSize = 53;
  float dx = mouseX - width/2;
  float dy = mouseY - polyCentre;
  float scale = 1.0*cursorSize/rotWhite.width;
  tempAngle = mouseAngle;
  mouseAngle = HALF_PI + atan(dy/dx);
  if (dx < 0) {
    mouseAngle = mouseAngle + PI;
  }

  pushMatrix();
  translate(mouseX, mouseY);
  translate(2, 2);
  scale(scale);
  rotate(mouseAngle);
  image(rotBlack, 0, 0);
  popMatrix();
  pushMatrix();
  translate(mouseX, mouseY);
  scale(scale);
  rotate(mouseAngle);
  image(rotWhite, 0, 0);
  popMatrix();
}

void updatePolyAngle() {
  float dAngle = mouseAngle - tempAngle;
  polyAngle = polyAngle + dAngle;
}

