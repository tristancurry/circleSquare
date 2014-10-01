//circleSquare                                                                              //
//A toy for exploring polygons of fixed long radius                                         //
//based on Conrad Wolfram's applet seen in https://www.youtube.com/watch?v=60OVlfAUPJg      //
//(interfaceFunctions.pde)                                                                  //
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

////////////////////////
void drawRotCursor() { 
  int cursorSize = 53;
  float dx = mouseX - width/2;
  float dy = mouseY - polyCentre;
  float scale = 1.0*cursorSize/rotWhite.width;
  tempAngle = mouseAngle;
  mouseAngle = HALF_PI + atan(dy/dx);
  if (dx < 0) {
    mouseAngle = mouseAngle + PI; //corrects for atan ambiguity
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

////////////////////////
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

////////////////////////
void mouseReleased() {
  sideSlider.dragging = false;
  yourPicker.dragging = false;
  rotDragging = false;
  clickTimer = frameCount;
}

