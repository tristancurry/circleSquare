int sides = 25;
int r = 200;

void setup() {
  size(500, 500);
  smooth();
}

void draw() {
  background(200);
  


  float[][] vertices = new float[sides][2];
  float a = TWO_PI/sides;
  float perim = sides*2*r*sin(a/2);

  for (int i = 0; i < sides; i++) {
    if (i<= sides/2) {
      vertices[i][0] = r*cos(i*a);
      vertices[i][1] = r*sin(i*a);
    } else {
      vertices[i][0] = vertices[sides - i][0];
      vertices[i][1] = -1*vertices[sides - i][1];
    }
  }

  pushMatrix();
  rectMode(CENTER);
  translate(width/2, height/2);
  fill(255,50, 60);
  stroke(80, 0, 0);
  strokeWeight(1);

  beginShape();
  for (int i = 0; i < sides; i++) {
    vertex(vertices[i][0], vertices[i][1]);
  }
  endShape(CLOSE);
  
  textAlign(CENTER,CENTER);
  fill(255);
  textSize(0.15*r);
  text("radius = " + r + " units", 0, -0.15*r);
  text("number of sides = " + sides,0,0);
  text("perimeter = " + round(perim) + " units",0,0.15*r);
  popMatrix();
}
