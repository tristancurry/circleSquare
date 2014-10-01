int sides;
int r;
float perim;
color col;
PImage picker;
ColPicker pickNChoose;
Slider sideSlider;


void setup() {
  size(540, 960);
  smooth();
  cursor(HAND);
  picker = loadImage("spectrum.jpg");
  pickNChoose = new ColPicker(width/2, 0, 0, 0, picker);
  sideSlider = new Slider(width/2, 0, 10, 3, 100, 4);
}

void draw() {
  background(50, 40, 100);
  sides = sideSlider.value; //this will become subject to slider value
  r = int(round(0.45*width));




  //update and draw slider
  sideSlider.hover(mouseX, mouseY);
  if (sideSlider.dragging) sideSlider.drag();
  rectMode(CENTER);
  imageMode(CENTER);

  sideSlider.posY = int(round(0.3*r));
  sideSlider.sWidth = int(round(0.85*width));
  sideSlider.display();


  //draw colour picker
  pushMatrix();
  stroke(255);
  strokeWeight(2);
  noFill();
  pickNChoose.posX = 0.5*width;
  pickNChoose.posY = 0.9*r;
  pickNChoose.pWidth = 0.85*width;
  pickNChoose.pHeight = 0.6*r;
  pickNChoose.display();
  if (pickNChoose.contains(mouseX, mouseY)) {
    noCursor();
    pickNChoose.selX = mouseX;
    pickNChoose.selY = mouseY;
    pickNChoose.drawSelector();
    if (pickNChoose.dragging) {
      loadPixels();
      col = pixels[mouseY*width + mouseX];
    }
  } else {
    cursor(HAND);
  }
  translate(pickNChoose.posX, pickNChoose.posY);
  rect(0, 0, pickNChoose.pWidth + 2, pickNChoose.pHeight+ 2);
  popMatrix();


  //draw polygon

  drawPolygon();

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
} 

void drawText() {
  textSize(0.15*r);
  text("radius = " + r + " units", 0, -0.15*r);
  text("number of sides = " + sides, 0, 0);
  text("perimeter = " + round(perim) + " units", 0, 0.15*r);
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

  //draw the polygon
  pushMatrix();
  rectMode(CENTER);
  translate(width/2, height - width/2);
  fill(col);
  stroke(255, 255, 255);
  strokeWeight(2);

  beginShape();
  for (int i = 0; i < sides; i++) {
    vertex(vertices[i][0], vertices[i][1]);
  }
  endShape(CLOSE);
}

void mousePressed() {
  sideSlider.clicked(mouseX, mouseY);

  if (pickNChoose.contains(mouseX, mouseY)) pickNChoose.dragging = true;
}

void mouseReleased() {
  sideSlider.dragging = false;
  pickNChoose.dragging = false;
}

