// ******************************************************
// * puzzle15.pde
// * by cameyo 2014
// * idea and some code from a sketch of Nicole Strang
// *
// * The game of puzzle 15.
// *
// * code written for Processing 1.5.1 & 2.1
// * MIT license
// ******************************************************
//
//  [N] key: start new game
//  [S] key: save window

import java.util.Calendar;

// ********************
// VARIABLE DECLARATION
// ********************
String TITLE = "puzzle 15";

// window info toggle
boolean showInfo;

// game font
PFont gameFont;
// font for info
PFont infoFont;

// board window
Board newBoard;

// game variable
Play game;

// background image
PImage backIMG;

// solved image
PImage solvedIMG;

// ***************************
//  SETUP
// ***************************
void setup()
{
  size(425,425);
// set window title
println("color...");
  //frame.setTitle(TITLE);
  // set window icon image
  //changeAppIcon();
  //set background
  background(255);
  // set framerate  
  frameRate(30);  
  //set modes
  imageMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER);
  //load font
  infoFont = loadFont("CourierNewPSMT-12.vlw");
  gameFont = loadFont("SansSerif.bold-28.vlw");    
  textFont(gameFont);
  // load back image
  backIMG = loadImage("back15.png");
  // solved image
  solvedIMG = loadImage("solved.png");
  // create a board window
  newBoard = new Board();
}


// ***************************
//  DRAW
// ***************************
void draw()
{ 
  // start game
  newBoard.showGame();
  // stop game
  if (game.checkSolved() == true)
  {
    image(solvedIMG,325,325);
    //println("solved");
    noLoop();
  }  
}

// ***************************
// KEYBOARD INTERACTION
// ***************************
void keyPressed()
{
  
  // save image window
  if (key=='s' || key=='S')
  {
    saveFrame("s" + timestamp() + ".png");
  }
  
  // new game
  if (key=='n' || key=='N')
  {
    loop();
    game.shuffle();
  }

  // intercept ESC key
  if (keyCode==ESC)
  {
    key=0;
    //println("ESC");
  }   
}


// ***************************
// MOUSE INTERACTION
// ***************************

// ***************************
// mousePressed
// ***************************
void mousePressed()
{
  //  println("mouse: " + mouseX + " - " + mouseY);
  // check if press new game button
  if ((mouseX > 10) && (mouseX < 29) && (mouseY > 10) && (mouseY < 29))
  {
      loop();
      game.shuffle();
  }  
}

// ***************************
// mouseMoved
// ***************************
void mouseMoved()
{
  //set cursor
  // check if mouse is over new game button
  if ((mouseX > 10) && (mouseX < 29) && (mouseY > 10) && (mouseY < 29))
  {
    cursor(HAND);
  }
  else
  { 
    cursor(ARROW);
  }        
}


// **********************
// changeAppIcon FUNCTION
// **********************
void changeAppIcon()
{
  // create icon for application
  PGraphics icon = createGraphics(16, 16, JAVA2D);
  // draw icon
  icon.beginDraw();
  
  icon.stroke(0);
  icon.noFill();
  
  icon.rect(0, 0, 12, 12);
  
  icon.line(3, 0, 3, 12);
  icon.line(6, 0, 6, 12);  
  icon.line(9, 0, 9, 12);    
  
  icon.line(0, 3, 12, 3);
  icon.line(0, 6, 12, 6);  
  icon.line(0, 9, 12, 9);    
  
  icon.stroke(255,169,64);
  icon.fill(255,169,64);
  icon.rect(10,10,1,1);

  icon.endDraw();
  // set icon
  frame.setIconImage(icon.image);
}


// **********************
// timestamp FUNCTION
// **********************
String timestamp()
{
  Calendar now = Calendar.getInstance();
  return String.format("20%1$ty-%1$tm-%1$td_%1$tH.%1$tM.%1$tS", now);
}