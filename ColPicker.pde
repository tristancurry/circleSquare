//circleSquare                                                                              //
//A toy for exploring polygons of fixed long radius                                         //
//based on Conrad Wolfram's applet seen in https://www.youtube.com/watch?v=60OVlfAUPJg      //
//(ColPicker.pde)                                                                           //
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


class ColPicker {

  float posX;
  float posY;

  float pWidth;
  float pHeight;

  PImage pickerImage;
  
  float selX;
  float selY;
  
  boolean selector;
  boolean dragging;

  //////Constructor//////
  ColPicker(float posX_, float posY_, float pWidth_, float pHeight_, PImage pickerImage_) {
    posX = posX_;
    posY = posY_;
    pWidth = pWidth_;
    pHeight = pHeight_;

    pickerImage = pickerImage_;
    selector = false;
    dragging = false;
  }
  
  ////////////////////////
  boolean contains(int x, int y){
    if(x >= this.posX - this.pWidth/2 &&
    x <= this.posX + this.pWidth/2 &&
    y >= this.posY - this.pHeight/2 &&
    y <= this.posY + this.pHeight/2){
      return true;
    } else {
      return false;
    } 
  }
  
  ////////////////////////
  void display() {
    imageMode(CENTER);
    image(pickerImage, posX, posY, pWidth, pHeight);
    if(selector) drawSelector();
  }
  
  ////////////////////////
  void drawSelector(){
   ellipseMode(CENTER);
   strokeWeight(3);
   noFill();
   pushMatrix();
   translate(selX + 1,selY + 1);
   stroke(50);
   ellipse(0,0,0.12*pHeight,0.12*pHeight);
   translate(-1,-1);
   stroke(255);
   ellipse(0,0,0.12*pHeight,0.12*pHeight);
   popMatrix();
  }
  
}

