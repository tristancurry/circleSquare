void drawPolyText() {
  textSize(0.20*r);
  text(sides + " sides", 0, -0.18*r);
  textSize(0.08*r);
  text(r + " units from centre to corner", 0, 0);
  text(round(perim) + " units in perimeter", 0, 0.13*r);
}


void drawHelpText() {
  if (sliderHelpCounter >= helpCounterThreshold) {
    pushMatrix();
    translate(width/2, 0);
    translate(0, sideSlider.posY - 0.5*sideSlider.ballDiameter - 0.13*r);
    textSize(0.13*r);
    fill(122);
    text("Drag to change number of sides.", 0, 0);
    popMatrix();
  }

  if (pickerHelpCounter >= helpCounterThreshold) {
    pushMatrix();
    translate(width/2, 0);
    translate(0, yourPicker.posY - 0.5*yourPicker.pHeight - 0.13*r);
    textSize(0.13*r);
    fill(122);
    text("Click or drag to choose a colour.", 0, 0);
    popMatrix();
  }

  if (polyHelpCounter >= helpCounterThreshold) {
    pushMatrix();
    translate(width/2, 0);
    translate(0, polyCentre - 1.13*r);
    textSize(0.13*r);
    fill(122);
    text("Drag to rotate the polygon.", 0, 0);
    popMatrix();
  }

  if (frameCount - clickTimer > clickTimerThreshold) {
    sliderHelpCounter = helpCounterThreshold;
    pickerHelpCounter = helpCounterThreshold;
    polyHelpCounter = helpCounterThreshold;
  }
}

void drawLabelText() {
  pushMatrix();
  translate(width/2, polyCentre);
  textAlign(CENTER, CENTER);
  fill(0.4*(255-brightness(col)));
  translate(0.01*r, 0.01*r);
  drawPolyText();
  colorMode(HSB);
  fill((hue(col)+70)%255, 1.0*saturation(col), 255);
  colorMode(RGB);
  translate(-0.01*r, -0.01*r);
  drawPolyText();
  popMatrix();
}

void drawCreditText() {
  pushMatrix();
  translate(width-0.04*r, 0);
  translate(0, height/2);
  rotate(HALF_PI);
  textSize(0.09*r);
  fill(165, 255, 0, abs(150*sin(radians(frameCount/50))));
  text("Tristan Miller 2014. Suggestions, comments to tristan.miller@asms.sa.edu.au", 0, 0);
  popMatrix();
}

