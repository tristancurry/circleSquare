//circleSquare                                                                              //
//A toy for exploring polygons of fixed long radius                                         //
//based on Conrad Wolfram's applet seen in https://www.youtube.com/watch?v=60OVlfAUPJg      //
//(textFunctions.pde)                                                                       //
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

////////////////////////
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

////////////////////////
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

////////////////////////
void drawPolyText() {
  textSize(0.20*r);
  text(sides + " sides", 0, -0.18*r);
  textSize(0.08*r);
  text(r + " units from centre to corner", 0, 0);
  text(nf(floor(100*perim)/100.0,4,2) + " units in perimeter", 0, 0.13*r);
}



