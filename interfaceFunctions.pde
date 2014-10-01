void mousePressed() {

  sliderHelpCounter++;
  pickerHelpCounter++;
  polyHelpCounter++;


  sideSlider.clicked(mouseX, mouseY);
  if (sideSlider.dragging) {
    sliderHelpCounter = 0;
  }
  if (yourPicker.contains(mouseX, mouseY)) {
    yourPicker.dragging = true;
    pickerHelpCounter = 0;
  }
  if (rotCursor) {
    rotDragging = true;
    polyHelpCounter = 0;
  }
}
void mouseReleased() {
  sideSlider.dragging = false;
  yourPicker.dragging = false;
  rotDragging = false;
  clickTimer = frameCount;
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
