// **************************************************
// * chessboard.pde
// * by cameyo 2013
// *
// * Chessboard
// *
// * code written for Processing 1.5.1 & 2.1
// * MIT license
// **************************************************

//  Click to select a piece and...
//  ...click to release (and capture too).
//
//  [W] key: start new game (white)
//  [B] key: start new game (black)
//  [F] key: change type of figures
//  [S] key: save window
//  [D] key: save diagram
//  [I] key: show/hide info

import java.util.Calendar;

// ********************
// VARIABLE DECLARATION
// ********************
String TITLE = "chess";

// window info toggle
boolean showInfo;

// base coordinates of board
int baseX=68;
int baseY=68;

// array of center of squares
int[][] center = new int[64][2];
// offset of text placement from center of square
int offset=11;

// array of pieces and their positions
int[][] pos = new int[32][3];
// piece N
// pos[N][0] -> x coord
// pos[N][1] -> y coord
// pos[N][2] -> figure index

String[] figure = new String[13];
//  figure[0] = "";  //empty
// WHITE
//  figure[1] = "K"; //king
//  figure[2] = "Q"; //queen
//  figure[3] = "R"; //rook
//  figure[4] = "L"; //bishop
//  figure[5] = "N"; //knight
//  figure[6] = "P"; //pawn
// BLACK
//  figure[7] = "k"; //king
//  figure[8] = "q"; //queen
//  figure[9] = "r"; //rook
//  figure[10] = "l"; //bishop
//  figure[11] = "n"; //knight
//  figure[12] = "p"; //pawn

// font for chess
PFont chessFont1, chessFont2, infoFont;
boolean FF=true;

// output filename
String filename;

// background color
color backC;

// board image
PImage boardWhiteIMG, boardBlackIMG;

// background image
PImage backIMG;

// info image
PImage infoIMG;

// picked piece
boolean pick=false;

// selected and captured piece index
int sel=-1;
int cap=-1;

// snap for select
int snap=30;

//selected piece values
int pieceIDX,figureIDX;

// WHITE or BLACK side
String side;

// counter
int i,j,k;

// ********************
// SETUP FUNCTION
// ********************
void setup()
{
  //******************************
  size(668,668);
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

  // load center coords of squares
  loadCenter();

  // load board images
  boardWhiteIMG = loadImage("boardWhite.jpg");
  boardBlackIMG = loadImage("boardBlack.jpg");
  backIMG = loadImage("background.jpg");
  infoIMG = loadImage("infoButton.jpg");  

  // load and set font
  chessFont1 = loadFont("DiagramTTUSCF-48.vlw");
  chessFont2 = loadFont("DiagramTTOldstyle-48.vlw");
  infoFont = loadFont("CourierNewPSMT-12.vlw");
  textFont(chessFont1);
  textAlign(CENTER);

  // initialize chess figures
  figure[0] = "";  //empty
  // WHITE pieces
  figure[1] = "K"; //king
  figure[2] = "Q"; //queen
  figure[3] = "R"; //rook
  figure[4] = "L"; //bishop
  figure[5] = "N"; //knight
  figure[6] = "P"; //pawn
  // BLACK pieces
  figure[7]  = "k"; //king
  figure[8]  = "q"; //queen
  figure[9]  = "r"; //rook
  figure[10] = "l"; //bishop
  figure[11] = "n"; //knight
  figure[12] = "p"; //pawn

  // front side color
  side = "WHITE";

  // draw board
  drawBoard();

  // draw chess start position
  startPositionWhite();
}


// ********************
// DRAW FUNCTION
// ********************
void draw()
{
  // set background color
  background(backC);

  // set background image
  image(backIMG,0,0,width,height);

  // draw board
  drawBoard();

  // draw info button
  //drawInfoButton();

  // ********************
  // draw all pieces
  // ********************
  //set text color
  fill(0);
  // draw pieces
  for(i=0;i<32;i++)
  {
    text(figure[pos[i][2]],pos[i][0],pos[i][1]);
    //println(i + " - " + pos[i][0] + " - " + pos[i][1]);
  }

  // if picked piece then draw it
  if (pick)
  {
    text(figure[pos[pieceIDX][2]],mouseX,mouseY);
  }

//  DEBUGGING CODE
//  textFont(infoFont);
//  for (i=0;i<64;i++)
//  {
//    fill(255,0,0);
//    ellipse(center[i][0],center[i][1],3,3);
//    text(center[i][0]+"-"+center[i][1],center[i][0],center[i][1]);
//
//  }
//  textFont(chessFont1);

  // draw info window
  if (showInfo)
  {
    fill(0,210);
    rectMode(CENTER);
    textAlign(CENTER);
    noStroke();
    rect(width/2,height/2,300,200);
    fill(240);
    textFont(infoFont);
    text("CHESS by cameyo",width/2,height/2-80);
    textAlign(LEFT);
    text("Click to select a piece and...",width/2-130,height/2-56);
    text("...click to release (and capture too).",width/2-130,height/2-40);
    text("[W][B] key: new game (white/black)",width/2-132,height/2-18);
    text("[Q] key: promote picked pawn",width/2-110,height/2+2);
    text("[F] key: change type of figures",width/2-110,height/2+22);
    text("[S] key: save window",width/2-110,height/2+42);
    text("[D] key: save diagram",width/2-110,height/2+62);
    text("[I] key: show/hide info",width/2-110,height/2+82);
    text("________________________________________",width/2-141,height/2+92);

    if (FF) { textFont(chessFont1); }
    else { textFont(chessFont2); }
    fill(0);
    textAlign(CENTER);
  }
}


// ***************************
// KEYBOARD INTERACTION
// ***************************
void keyPressed()
{
  // start new game (WHITE)
  if (key=='w' || key=='W')
  {
    pick=false;
    side="WHITE";
    startPositionWhite();
  }

  // start new game (BLACK)
  if (key=='b' || key=='B')
  {
    pick=false;
    side="BLACK";
    startPositionBlack();
  }

  // change type of figures
  if (key=='f' || key=='F')
  {
    FF = !(FF);
    if (FF) { textFont(chessFont1); }
    else { textFont(chessFont2); }
  }

  // promote (QUEEN) current picked pawn (toggle)
  if (key=='q' || key=='Q')
  {
    if (pick)
    {
      if (pieceIDX<16) //white piece to DAMA
      {
        if (pos[pieceIDX][2]==6)
        {
         pos[pieceIDX][2]=2;
         figureIDX=2;
        }
        else if (pos[pieceIDX][2]==2)
        {
         pos[pieceIDX][2]=6;
         figureIDX=6;
        }        
      }  
      else // black piece to DAMA
      {
        if (pos[pieceIDX][2]==12)
        {
          pos[pieceIDX][2]=8;
          figureIDX=8;
        }  
        else if (pos[pieceIDX][2]==8)
        {
          pos[pieceIDX][2]=12;
          figureIDX=12;
        }
      }      
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
    outIMG = get(baseX, baseY, 532, 532);
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
  sel=-1;
  cap=-1;

  if (pick) // Second pick -> place piece
  {
//    pos[pieceIDX][0] = mouseX;
//    pos[pieceIDX][1] = mouseY;
//    pos[pieceIDX][2] = figureIDX;
    centerPiece();
    pick=false;
    // check if captured piece
    checkCapture();
  }
  else
  {
    //check if clicked on a piece
    for(i=0;i<32;i++)
    {
      if ((mouseX > pos[i][0]-snap) && (mouseX < pos[i][0]+snap) && (mouseY > pos[i][1]-snap-offset) && (mouseY < pos[i][1]+snap-offset))
      {
        // piece selected
        //println("selected");
        sel=1;
        pieceIDX = i;
        figureIDX = pos[pieceIDX][2];
        // reset X and Y coord (move outside window)
        pos[pieceIDX][0] = -100;
        pos[pieceIDX][1] = -100;
        pick = true;
        break;
      }
    }
  }

  if ((sel==-1) && (cap==-1)) { pick=false; }
  // println(pick);

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

 // check if piece is selected
 if (pick) { cursor(HAND); }

 // check if mouse over pieces
 for(i=0;i<32;i++)
 {
   if ((mouseX > pos[i][0]-snap) && (mouseX < pos[i][0]+snap) && (mouseY > pos[i][1]-snap-offset) && (mouseY < pos[i][1]+snap-offset))
   {
     //println("pointer hand");
     cursor(HAND);
     break;
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
  image(infoIMG,651,1);
}


// **********************
// drawBoard FUNCTION
// **********************
void drawBoard()
{
  if (side == "WHITE")
  {
    image(boardWhiteIMG, baseX,baseY);
  }
  else
  {
    image(boardBlackIMG, baseX,baseY);
  }
}

// **********************
// centerPiece FUNCTION
// **********************
void centerPiece()
{
  float dd;
  float minDist = 9999.0;

  // place piece within chessboard
  if ((mouseX > 86) && (mouseX < 582) && (mouseY > 86) && (mouseY < 582))
  {
     for(i=0;i<64;i++)
     {
       // search the nearest square (crosspoint)
       dd = dist(mouseX, mouseY+offset, center[i][0], center[i][1]);
       if (dd < minDist)
       {
         minDist=dd;
         pos[pieceIDX][0] = center[i][0];
         pos[pieceIDX][1] = center[i][1];
         pos[pieceIDX][2] = figureIDX;
       }
     }
  }
  // place piece outside chessboard
  else
  {
    pos[pieceIDX][0] = mouseX;
    pos[pieceIDX][1] = mouseY;
    pos[pieceIDX][2] = figureIDX;
  }
}


// **********************
// checkCapture FUNCTION
// **********************
void checkCapture()
{
    cap=-1;
    //check if clicked on a piece (capture it !!)
    for(i=0;i<32;i++)
    {
      if (((mouseX > pos[i][0]-snap) && (mouseX < pos[i][0]+snap) && (mouseY > pos[i][1]-snap-offset) && (mouseY < pos[i][1]+snap-offset)) &&
      (i!=pieceIDX)) // not the piece selected !!
      {
        // piece captured
        //println("captured");
        cap=1;
        pieceIDX = i;
        figureIDX = pos[pieceIDX][2];
        // reset X and Y coord (move outside window)
        pos[pieceIDX][0] = -100;
        pos[pieceIDX][1] = -100;
        pick = true;
        break;
      }
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
  icon.noStroke();
  icon.fill(0);
  icon.rect(3, 3, 10, 10);
  icon.fill(255);
  icon.rect(3,3,5,5);
  icon.rect(8, 8, 5, 5);
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

