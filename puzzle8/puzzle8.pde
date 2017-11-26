// ******************************************************
// * puzzle8.pde
// * by cameyo 2014
// * idea and some code from a sketch of Nicole Strang
// *
// * The game of puzzle 8.
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
String TITLE = "puzzle 8";

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
  size(350,350);
// set window title
  frame.setTitle(TITLE);
  // set window icon image
  changeAppIcon();
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
  backIMG = loadImage("back.png");
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
    image(solvedIMG,250,250);
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
  if ((mouseX > 14) && (mouseX < 35) && (mouseY > 14) && (mouseY < 35))
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
  if ((mouseX > 14) && (mouseX < 35) && (mouseY > 14) && (mouseY < 35))
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
  
  icon.line(4, 0, 4, 12);
  icon.line(8, 0, 8, 12);  
  
  icon.line(0, 4, 12, 4);
  icon.line(0, 8, 12, 8);  
  
  icon.stroke(255,169,64);
  icon.fill(255,169,64);
  icon.rect(9,9,2,2);

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



