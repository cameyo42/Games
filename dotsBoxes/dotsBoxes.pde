// **************************************************
// * dotsboxes.pde
// * by cameyo 2013
// *
// * A board for Dots & Boxes.
// *
// * code written for Processing 1.5.1 & 2.1
// * MIT license
// **************************************************
//
//  [N] key: start new game
//  [U] key: undo last move
//  [S] key: save window
//  [D] key: save diagram
//  [I] key: show/hide info

import java.util.Calendar;

// ********************
// VARIABLE DECLARATION
// ********************
String TITLE = "dots&boxes";

// window info toggle
boolean showInfo;

// base coordinates of board
int baseX=100;
int baseY=100;

// current player
// 3->BLUE; 2->RED;
int player=3;

// changed position?
boolean changed=false;

// line found?
boolean lineFoundH=false;
boolean lineFoundV=false;

// new quad?
boolean makeQuad = false;

// number of Points
int numPoints=25;

// array of points positions
int[][][] pox = new int[5][5][3];
// points
// pox[x][y][0] -> x coord
// pox[x][y][1] -> y coord
// pox[x][y][2] -> 3=BLUE, 4=RED

// number of lines 
int numLines=0;
int numLinesRED=0;
int numLinesBLU=0;

// array of horizontal lines positions (centers)
int[][][] lixH = new int[5][4][3];
// lines horizontal
// lix[x][y][0] -> x coord
// lix[x][y][1] -> y coord
// lix[x][y][2] -> 0=EMPTY, 3=BLUE, 4=RED

// array of vertical lines positions (centers)
int[][][] lixV = new int[4][5][3];
// lines vertical
// lix[x][y][0] -> x coord
// lix[x][y][1] -> y coord
// lix[x][y][2] -> 0=EMPTY, 3=BLUE, 4=RED

// number of quads 
int numQuads=0;
int numQuadsRED=0;
int numQuadsBLU=0;

// array of quads positions (centers)
int[][][] qux = new int[4][4][3];
// lines
// qux[x][y][0] -> x coord
// qux[x][y][1] -> y coord
// qux[x][y][2] -> 0=EMPTY, 3=BLUE, 4=RED

// UNDO array of horizontal lines positions (centers)
int[][][] UlixH = new int[5][4][3];

// UNDO array of vertical lines positions (centers)
int[][][] UlixV = new int[4][5][3];

// UNDO array of quads positions (centers)
int[][][] Uqux = new int[4][4][3];

// index of current line (H & V)
int iHL, jHL;
int iVL, jVL;

// font for info
PFont infoFont;

// font for score
PFont scoreFont;

// output filename
String filename;

// background color
color backC;

// background image
PImage backIMG;

// info image
PImage infoIMG;

// selected and captured piece index
int sel=-1;
int cap=-1;

// snap for draw line
int snap=22;

// counter
int i, j, k;

// ********************
// SETUP FUNCTION
// ********************
void setup()
{
  //******************************
  size(440, 440);
  //******************************
  // set window title
  frame.setTitle(TITLE);
  // set window icon image
  changeAppIcon();

  // smooth drawing
  smooth();
  // screen update
  frameRate(60);

  // set background color
  backC = color(255);
  background(backC);

  // set image mode
  imageMode(CENTER);  

  // load background images
  backIMG = loadImage("background.jpg");
  infoIMG = loadImage("infoButton.jpg");  

  // load and set font
  infoFont = loadFont("CourierNewPSMT-12.vlw");
  scoreFont = loadFont("Arial-BoldMT-16.vlw");  
  textAlign(CENTER);
  
  // set starting values
  setStartValues();
  
  // draw board
  drawPoints();
  drawLinesH();
  drawLinesV();
  drawQuads();
  
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

  // draw board
  drawPoints();
  drawLinesH();
  drawLinesV();  
  drawQuads();

  // draw current player color
  stroke(200);
  if (player==3) { fill(0,0,255); }
  else { fill(255,0,0); }
  rect(width/2, 390, 20,20);
  
  // calculate numbers of quads for both players (score)
  numQuadsRED=0;
  numQuadsBLU=0;  
  for(i=0;i<4;i++)
  { 
    for(j=0;j<4;j++)    
    {
      if (qux[i][j][2]==3) { numQuadsBLU++; }
      if (qux[i][j][2]==4) { numQuadsRED++; }      
    }
  }  
  // draw score
  stroke(0);
  rectMode(CENTER);  
  textAlign(CENTER);
  textFont(scoreFont);
  fill(255,0,0,200);
  rect(50,390,30,30);
  fill(255);
  text(numQuadsRED,50,390+6);
  fill(0,0,255,200);
  rect(390,390,30,30);         
  fill(255);
  text(numQuadsBLU,390,390+6);           

  // draw info button
  //drawInfoButton();

// BEGIN DEBUG CODE
// -----------------
// lines horizontal (lixH)
//  int sX,sY;
//  sX = baseX+30;
//  sY = baseY;  
//  for(i=0;i<5;i++)
//  {
//    for(j=0;j<4;j++)
//    {
//      fill(255);
//      //ellipse(lixH[i][j][0],lixH[i][j][1],5,5);
//      //text(lixH[i][j][0]+"-"+lixH[i][j][1],lixH[i][j][0],lixH[i][j][1]);
//      text(i+","+j,lixH[i][j][0],lixH[i][j][1]);
//    }  
//  }  
  
// lines vertical (lixV)
//  sX = baseX;
//  sY = baseY+30;  
//  for(i=0;i<4;i++)
//  {
//    for(j=0;j<5;j++)
//    {
//      fill(255,255,0);
//      //ellipse(lixV[i][j][0],lixV[i][j][1],5,5);
//      //text(lixV[i][j][0]+"-"+lixV[i][j][1],lixV[i][j][0],lixV[i][j][1]);
//      text(i+","+j,lixV[i][j][0],lixV[i][j][1]);
//      
//    }
//  }    

// draw quads
//  sX = baseX+30;
//  sY = baseY+30;  
//  fill(255,0,0);
//  rectMode(CENTER);
//  noStroke();
//  for(i=0;i<4;i++)
//  {
//    for(j=0;j<4;j++)
//    {
//      //rect(qux[i][j][0],qux[i][j][1],44,44);
//      //text(qux[i][j][0]+"-"+qux[i][j][1],qux[i][j][0],qux[i][j][1]);
//      text(i+","+j,qux[i][j][0],qux[i][j][1]);      
//    }
//  } 
// END DEBUG CODE
// -----------------
 
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
    text("DOTS & BOXES by cameyo", width/2, height/2-80);
    text("The game of Dots&Boxes.", width/2, height/2-58);        
    textAlign(LEFT);
    text("Click between two points...", width/2-110, height/2-36);
    text("...to draw a line (autocenter).", width/2-110, height/2-22);
    text("[N] key: start new game", width/2-110, height/2+2);
    text("[U] key: undo last move", width/2-110, height/2+22);
    text("[S] key: save window", width/2-110, height/2+42);
    text("[D] key: save diagram", width/2-110, height/2+62);
    text("[I] key: show/hide info", width/2-110, height/2+82);
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
    player=3;
    setStartValues();
  }
  
  // undo last move
  if (key=='u' || key=='U')
  {
    if (changed==true) 
    {
      restorePosition();
      if (!makeQuad)
      { 
        if (player==3) { player = 4; }
        else { player = 3; } 
      }   
      changed=false;      
    }  
    
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

  // save board image (only)
  if (key=='d' || key=='D')
  {
    PImage outIMG;
    outIMG = get(baseX-10, baseY-10, 250+10, 250+10);
    outIMG.save("d" + timestamp() + ".png");
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
  
  if ((mouseX > 90) && (mouseX < 350) && (mouseY > 90) && (mouseY < 350))
  {
    // search line to draw
    searchLine();

    if ((lineFoundV==true) || (lineFoundH==true))// if line found (draw) then switch player
    {
      if (!makeQuad) // if make a new quad then don't change player
      {
        if (player==3) { player = 4; }
        else { player = 3;}
      }  
    }  
    
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
 // check if mouse over horizontal lines
  for (i=0;i<5;i++)
  {
    for (j=0;j<4;j++)
    {
      if ((mouseX > lixH[i][j][0]-snap) && (mouseX < lixH[i][j][0]+snap) && (mouseY > lixH[i][j][1]-snap) && (mouseY < lixH[i][j][1]+snap))
      {
        cursor(HAND);
        break;
      }
    }
  }    
 // check if mouse over vertical lines
  for (i=0;i<4;i++)
  {
    for (j=0;j<5;j++)
    {
      if ((mouseX > lixV[i][j][0]-snap) && (mouseX < lixV[i][j][0]+snap) && (mouseY > lixV[i][j][1]-snap) && (mouseY < lixV[i][j][1]+snap))
      {
        cursor(HAND);
        break;
      }
    }
  }      
  
  // check mouse over info button
  if ((mouseX > width-18) && (mouseX < width) && (mouseY > 0) && (mouseY < 18))
  {
    cursor(HAND);
  }
}


// ************************
// drawInfoButton FUNCTION
// ************************
void drawInfoButton()
{
  image(infoIMG,429,9);
}


// **********************
// searchLine FUNCTION
// **********************
void searchLine()
{
  float dd;
  float minDist = 9999.0;
  
  lineFoundH=false;  
  lineFoundV=false;    

  // search along the horizontal lines
  iVL=-1; jVL=-1;
  iHL=-1; jHL=-1;
  for (i=0;i<5;i++)
  {
    for (j=0;j<4;j++)
    {
      dd =dist(mouseX, mouseY, lixH[i][j][0], lixH[i][j][1]);
      if (dd < minDist)
      {
        minDist=dd;
        iHL = i;
        jHL = j;
      }
    }
  }
  // search along the vertical lines  
  for (i=0;i<4;i++)
  {
    for (j=0;j<5;j++)
    {
      dd =dist(mouseX, mouseY, lixV[i][j][0], lixV[i][j][1]);
      if (dd < minDist)
      {
        minDist=dd;
        iVL = i; 
        jVL = j;
        // reset index of horizontal lines
        iHL = -1;
        jHL = -1;
      }
    }
  }
    
  if ((iVL != -1) && (lixV[iVL][jVL][2] == 0))
  {
    println("backup...");
    changed = true;
    backupPosition();
    
    lixV[iVL][jVL][2]=player;
    lineFoundV=true;    
    println("found free V");
    updateQuads();
  }  
  
  if ((iHL != -1) && (lixH[iHL][jHL][2] == 0))
  {
    println("backup...");
    changed = true;
    backupPosition();    
    
    lixH[iHL][jHL][2]=player;
    lineFoundH=true;    
    println("found free H");
    updateQuads();    
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
  icon.rect(0,0,15,15);
  icon.rect(2,2,1,1);
  icon.rect(12,2,1,1);  
  icon.rect(12,12,1,1);  
  icon.rect(2,12,1,1);
  
  icon.stroke(0,0,255);
  icon.rect(5,2,5,1);
  icon.rect(5,12,5,1); 
  
  icon.stroke(255,0,0);
  icon.rect(2,5,1,5);
  icon.rect(12,5,1,5);
  
  icon.noStroke();
  icon.fill(100,100,255);
  icon.rect(5,5,6,6);
  
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

