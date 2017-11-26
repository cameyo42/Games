// **************************************************
// * rsp.pde
// * by cameyo 2013
// *
// * Rock Paper Scissors.
// *
// * code writtsen for Processing 1.5.1 & 2.1
//
// * images from Wipipedia
// **************************************************
//
//  Press [1] to select Rock
//  Press [2] to select Paper
//  Press [3] to select Scissors
//  [N] key: start new game
//  [S] key: save window
//  [I] key: show/hide info

import java.util.Calendar;

// ********************
// VARIABLE DECLARATION
// ********************
String TITLE = "rock paper scissors";

// window info toggle
boolean showInfo;

// base coordinates of board
int baseX=100;
int baseY=100;

// number of pieces
int numPieces=6;

// array of images (rock paper scissors)
PImage[] imgH = new PImage[3];
PImage[] imgC = new PImage[3];
PImage[] imgHG = new PImage[3];
PImage[] imgCG = new PImage[3];

// plus images
PImage hPlus, cPlus;

// font for info
PFont infoFont;

// font for score
PFont scoreFont;

// font for score
PFont turnFont;

// output filename
String filename;

// background color
color backC;

// background image
PImage backIMG;

// info image
PImage infoIMG;

// picked piece
boolean pick=false;

// snap for select
int snap=20;

// selected computer figure (random A.I.)
int computerIDX=-1;

// selected player figure
int humanIDX=-1;

// turn number
int turn=0;

// score
int scoreH;
int scoreC;

// player start turn
boolean go=false;

// winner of turn
int winner=-1;

// counter
int i, j, k;

// time to visualize turn (delay time)
int startFrame;
int delayFC=60;

// ********************
// SETUP FUNCTION
// ********************
void setup()
{
  //******************************
  size(550, 445);
  //******************************
  // set window title
  frame.setTitle(TITLE);
  // set window icon image
  changeAppIcon();

  // smooth drawing
  smooth();

  // screen update
  frameRate(30);

  // set background color
  backC = color(60);
  background(backC);

  // set image mode
  imageMode(CENTER);

  // set rect mode
  rectMode(CENTER);

  // load images
  backIMG = loadImage("background.jpg");
  infoIMG = loadImage("infoButton.jpg");

  //load piece images (static)
  imgH[0] = loadImage("HumanRock.png");
  imgH[1] = loadImage("HumanPaper.png");
  imgH[2] = loadImage("HumanScissors.png");
  imgC[0] = loadImage("ComputerRock.png");
  imgC[1] = loadImage("ComputerPaper.png");
  imgC[2] = loadImage("ComputerScissors.png");

  //load piece images (dinamic)
  imgHG[0] = loadImage("goHumanRock.png");
  imgHG[1] = loadImage("goHumanPaper.png");
  imgHG[2] = loadImage("goHumanScissors.png");
  imgCG[0] = loadImage("goComputerRock.png");
  imgCG[1] = loadImage("goComputerPaper.png");
  imgCG[2] = loadImage("goComputerScissors.png");
  
  // plus images
  hPlus = loadImage("HumanPlus.png");
  cPlus = loadImage("ComputerPlus.png");  

  // load and set font
  infoFont = loadFont("CourierNewPSMT-12.vlw");
  turnFont = loadFont("Arial-BoldMT-48.vlw");
  scoreFont = loadFont("Arial-BoldMT-36.vlw");
  textAlign(CENTER);
}

// ********************
// DRAW FUNCTION
// ********************
void draw()
{
  // set background color
  background(backC);

  // set background image
  image(backIMG, width/2, height/2);

  // draw info button
  //drawInfoButton();

  // draw computer image (rock, paper, scissors)
  image(imgC[0], baseX, baseY);
  image(imgC[1], baseX+100, baseY);
  image(imgC[2], baseX+200, baseY);

  // draw computer image button (rock, paper, scissors)
  image(imgH[0], baseX, baseY+250);
  image(imgH[1], baseX+100, baseY+250);
  image(imgH[2], baseX+200, baseY+250);

  // check if player start turn
  if (go)
  {
    startFrame=frameCount;
    // computer choice figure
    computerIDX=int(random(0, 3));
    //    println(computerIDX);
    go=false;
    winner=-1;
    // see who is the winner
    String res="";
    res = str(computerIDX)+str(humanIDX);
    //println(res);
    // DRAW
    if ( (res.equals("00")) || (res.equals("11")) || (res.equals("22")) )
    {
      //println("draw");
      winner=2;
    }
    // HUMAN WIN
    if ( (res.equals("01")) || (res.equals("12")) || (res.equals("20")) )
    {
      //println("human win");
      winner=0;
      scoreH++;
    }
    // COMPUTER WIN
    if ( (res.equals("02")) || (res.equals("10")) || (res.equals("21")) )
    {
      //println("computer win");
      scoreC++;
      winner=1;
    }
  }

// draw computer selected images (for 2 sec)
// TEST CODE
//  if (frameCount%60==0)
//  {
//    println(frameCount+" - "+startFrame);
//    if (frameCount>startFrame+100)
//    {
//      println("stop VIEW");
//      computerIDX=-1;
//      humanIDX=-1;
//    }
//  }

// draw computer selected images (for delayFC frame)
  if (frameCount>startFrame+delayFC)
  {
    //println("stop VIEW");
    computerIDX=-1;
    humanIDX=-1;
    winner=-1;
   }

  noFill();
  stroke(81,14,6);
  strokeWeight(1);
  textFont(turnFont);
  if (computerIDX == 0)
  {
    image(imgCG[computerIDX], baseX, baseY+85);
    if (winner == 1)
    {
      rect(baseX, baseY+85,62,62);
      noFill();
      image(cPlus,375,100);
    }
  }
  if (computerIDX == 1)
  {
    image(imgCG[computerIDX], baseX+100, baseY+85);
    if (winner == 1)
    {
      rect(baseX+100, baseY+85,62,62);
      noFill();
      image(cPlus,375,100);      
    }
  }
  if (computerIDX == 2)
  {
    image(imgCG[computerIDX], baseX + 200, baseY+85);
    if (winner == 1)
    {
      rect(baseX + 200, baseY+85,62,62);
      noFill();
      image(cPlus,375,100);      
    }
  }

// draw human selected images (for delayFC frame)
  if (humanIDX == 0)
  {
    image(imgHG[humanIDX], baseX, baseY+165);
    if (winner == 0)
    {
      rect(baseX, baseY+164,62,62);
      noFill();
      image(hPlus,375,350);      
    }
  }
  if (humanIDX == 1)
  {
    image(imgHG[humanIDX], baseX+100, baseY+165);
    if (winner == 0)
    {
      rect(baseX+100, baseY+164,62,62);
      noFill();
      image(hPlus,375,350);            
    }
  }
  if (humanIDX == 2)
  {
    image(imgHG[humanIDX], baseX+200, baseY+165);
    if (winner == 0)
    {
      rect(baseX+200, baseY+164,62,62);
      noFill();
      image(hPlus,375,350);            
    }
  }

  // draw complete score
  stroke(0);
  strokeWeight(1);
  stroke(0,0,0);
  textFont(scoreFont);
  textAlign(CENTER);
  // computer score
  fill(60,185,70);
  rect(baseX+330,100,68,40);
  fill(0);
  text(scoreC, baseX+330,100+14);

  // turn
  textFont(turnFont);
  noFill();
  fill(0,150);
  rect(baseX+330,225,100,55);
  fill(255);
  text(turn,baseX+330,225+18);
  // draw red rect around turn when draw
  if (winner==2)
  {
    noFill();
    stroke(255,0,0);
    rect(baseX+330,225,100,55);
    stroke(0,0,0);
  }

  // human score
  textFont(scoreFont);
  fill(210,180,165);
  rect(baseX+330,350,68,40);
  fill(0);
  text(scoreH, baseX+330,350+14);
  noFill();

  // draw info window
  if (showInfo)
  {
    fill(0, 210);
    rectMode(CENTER);
    textAlign(CENTER);
    noStroke();
    rect(width/2, height/2, 300, 200);
    fill(240);
    textFont(infoFont);
    text("ROCK PAPER SCISSORS by cameyo", width/2, height/2-80);
    text("Rock-paper-scissors game.", width/2, height/2-58);
    textAlign(LEFT);
    text("Use mouse to select figure OR", width/2-100, height/2-34);
//    text("Press [1] to select Rock", width/2-100, height/2-32);
    text(" press [1] for Rock", width/2-100, height/2-18);
    text(" press [2] for Paper", width/2-100, height/2-4);
    text(" press [3] for Scissors", width/2-100, height/2+8);
    text("[N] key: start new game", width/2-110, height/2+32);
    text("[S] key: save window", width/2-110, height/2+52);
    text("[I] key: show/hide info", width/2-110, height/2+72);
    text("________________________________________", width/2-141, height/2+92);
  }
}

// ***************************
// KEYBOARD INTERACTION
// ***************************
void keyPressed()
{
  // start new game
  if (key=='n' || key=='N')
  {
    computerIDX=-1;
    humanIDX=-1;
    scoreC=0;
    scoreH=0;
    turn=0;
  }

  // player choice: ROCK
  if (key=='1')
  {
    humanIDX = 0;
    go=true;
    turn++;
  }

  // player choice: PAPER
  if (key=='2')
  {
    humanIDX = 1;
    go=true;
    turn++;
  }

  // player choice: SCISSORS
  if (key=='3')
  {
    humanIDX = 2;
    go=true;
    turn++;
  }


  // show info window
  if (key=='i' || key=='I')
  {
    showInfo = !(showInfo);
  }

  // save image window
  if (key=='s' || key=='S')
  {
    saveFrame("s" + timestamp() + ".png");
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
  //println("mouse: " + mouseX + " - " + mouseY);

  // check if clicked on a figure
  // rock
  if ((mouseX >65) && (mouseX < 134) && (mouseY > 315) && (mouseY < 384))
  {
    humanIDX = 0;
    go=true;
    turn++;
  }
  // paper
  if ((mouseX > 165) && (mouseX < 234) && (mouseY > 315) && (mouseY < 384))
  {
    humanIDX = 1;
    go=true;
    turn++;
  }
  // scissors
  if ((mouseX > 265) && (mouseX < 334) && (mouseY > 315) && (mouseY < 384))
  {
    humanIDX = 2;
    go=true;
    turn++;
  }

  // check if press info button
  if ((mouseX > width-18) && (mouseX < width) && (mouseY > 0) && (mouseY < 18))
  {
    showInfo = !(showInfo);
  }
}

// ***************************
// mouseMoved
// ***************************
void mouseMoved()
{
  //set cursor
  cursor(ARROW);
  // check mouse over info button
  if ((mouseX > width-18) && (mouseX < width) && (mouseY > 0) && (mouseY < 18))
  {
    cursor(HAND);
  }

  // check mouse over figures
  // rock
  if ((mouseX >65) && (mouseX < 134) && (mouseY > 315) && (mouseY < 384))
  {
    cursor(HAND);
  }
  // paper
  if ((mouseX > 165) && (mouseX < 234) && (mouseY > 315) && (mouseY < 384))
  {
    cursor(HAND);
  }
  // scissors
  if ((mouseX > 265) && (mouseX < 334) && (mouseY > 315) && (mouseY < 384))
  {
    cursor(HAND);
  }
}

// ************************
// drawInfoButton FUNCTION
// ************************
void drawInfoButton()
{
  image(infoIMG, 400, 9);
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
  icon.rect(0, 0, 15, 15);

  icon.line(2,7,2,8);
  icon.line(3,7,3,8);
  icon.line(5,4,5,11);
  icon.line(7,4,7,11);
  icon.line(9,4,9,11);
  icon.line(11,4,11,8);
  icon.line(12,7,12,11);
  icon.line(13,4,13,8);

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

    // TEST RANDOM FUNCTION
    //    int[] cc = new int[3];
    //    for(i=0; i<1000000;i++)
    //    {
    //      computerIDX=int(random(0,3));
    //      cc[computerIDX]++;
    //    }
    //    println(cc[0]+"-"+cc[1]+"-"+cc[2]);
