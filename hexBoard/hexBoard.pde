// **************************************************
// * hexBoard.pde
// * by cameyo 2013
// *
// * A board for the game of HEX (14x14).
// *
// * code written for Processing 1.5.1 & 2.1
// * MIT license
// **************************************************
//
//  [N] key: start new game
//  [F] key: change type of figures
//  [S] key: save window
//  [D] key: save diagram
//  [I] key: show/hide info

import java.util.Calendar;

// ********************
// VARIABLE DECLARATION
// ********************
String TITLE = "HEX";

// window info toggle
boolean showInfo;

// base coordinates of board
int baseX=0;
int baseY=0;

// number of pieces 
int numPieces=196;

// number of squares
int numSquares=196;

// array of pieces and their positions
int[][] pos = new int[numPieces][3];
// piece N
// pos[N][0] -> x coord
// pos[N][1] -> y coord
// pos[N][2] -> 0=white, 1=black

// array of center of crosspoints
int[][] center = new int[numSquares][2];

// array of figures (images)
PImage[] figure = new PImage[2];

// font for piece
PFont infoFont;
boolean FF=true;

// output filename
String filename;

// background color
color backC;

// board image
PImage boardIMG;

// mask image
PImage maskIMG;

// background image
PImage backIMG;

// info image
PImage infoIMG;

// image of pieces
PImage wIMGa, bIMGa, wIMGb, bIMGb;

// picked piece
boolean pick=false;

// selected and captured piece index
int sel=-1;
int cap=-1;

// last move coords
int lastMoveX=-100;
int lastMoveY=-100;

// snap for select
int snap=12;

//selected piece values
int pieceIDX, figureIDX;

// counter
int i, j, k;

// ********************
// SETUP FUNCTION
// ********************
void setup()
{
  //******************************
  size(789, 646);
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
  backC = color(60);
  background(backC);

  // set image mode
  imageMode(CENTER);  

  // load center coords of squares
  loadCenter();

  // load board images
  boardIMG = loadImage("board.jpg");

  // load background
  backIMG = loadImage("background.jpg");

  // load mask image
  maskIMG = loadImage("maskBoard.jpg");
  
  // load info button image
  infoIMG = loadImage("infoButton.jpg");

  //load piece images
  wIMGa = loadImage("whiteA.png");
  bIMGa = loadImage("blackA.png");  
  wIMGb = loadImage("whiteB.png");
  bIMGb = loadImage("blackB.png");  

  // load and set font
  infoFont = loadFont("CourierNewPSMT-12.vlw");
  textAlign(CENTER);

  // initialize figures
  // WHITE figure
  figure[0] = wIMGa;
  // BLACK figure    
  figure[1] = bIMGa;  

  // draw board
  drawBoard();

  // load nine start position
  startPosition();
}


// ********************
// DRAW FUNCTION
// ********************
void draw()
{
  // set background color
  background(backC);

  // set background image
  //  image(backIMG, width/2, height/2);

  // draw board
  drawBoard();

  // draw info button
  // drawInfoButton();

  // ********************
  // draw all pieces
  // ********************
  for (i=0;i<numPieces;i++)
  {
    image(figure[pos[i][2]], pos[i][0], pos[i][1]);
    //text(figure[pos[i][2]],pos[i][0],pos[i][1]);
    //println(i + " - " + pos[i][0] + " - " + pos[i][1]);
  }

  // draw chestbow
  strokeWeight(7);
  noFill();
  stroke(94, 93, 213);
  stroke(116, 118, 219);  
  ellipseMode(CENTER);
  ellipse(510, 582, 28, 28);
  stroke(236, 104, 79);  
  //  stroke(241,121,94);    
  ellipse(88, 362, 28, 28);  
  strokeWeight(1);  

  // if picked piece then draw it
  if (pick)
  {
    image(figure[pos[pieceIDX][2]], mouseX, mouseY);
    //text(figure[pos[pieceIDX][2]],mouseX,mouseY);
  }
  
  // last move highlight (red quads)
  noFill();
  stroke(255);
  rectMode(CENTER);
  rect(lastMoveX,lastMoveY, 8, 8);  

  //  DEBUGGING CODE
  //    textFont(infoFont);
  //  for (i=0;i<361;i++)
  //  {
  //    fill(255, 0, 0);
  //    ellipse(center[i][0], center[i][1], 2, 2);
  //    text(i,center[i][0], center[i][1]);
  //  }

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
    text("HEX by cameyo", width/2, height/2-80);
    text("The game of HEX.", width/2, height/2-58);        
    textAlign(LEFT);
    text("Click to select a piece and...", width/2-110, height/2-36);
    text("...click to release (autocenter).", width/2-110, height/2-22);
    text("[N] key: start new game", width/2-110, height/2+2);
    text("[F] key: change type of figures", width/2-110, height/2+22);
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
    pick=false;
    lastMoveX = -100;
    lastMoveY = -100;        
    startPosition();
  }

  // change type of figures
  if (key=='f' || key=='F')
  {
    FF = !(FF);
    if (FF) 
    { 
      figure[0] = wIMGa;
      figure[1] = bIMGa;
    }
    else 
    { 
      figure[0] = wIMGb;
      figure[1] = bIMGb;
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
    PImage outIMG, diaIMG;
    outIMG = get(0, 0, width, height);
    outIMG.mask(maskIMG);
    diaIMG = outIMG.get(10, 80, 770, 490);
    diaIMG.save("d" + timestamp() + ".png");
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
    //checkCapture();
  }
  else
  {
    //check if clicked on a piece
    for (i=0;i<numPieces;i++)
    {
      if ((mouseX > pos[i][0]-snap) && (mouseX < pos[i][0]+snap) && (mouseY > pos[i][1]-snap) && (mouseY < pos[i][1]+snap))
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

  if ((sel==-1) && (cap==-1)) { 
    pick=false;
  }
  // println(pick);

  // check if press info button
  if ((mouseX > width-16) && (mouseX < width) && (mouseY > 0) && (mouseY < 16))
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
  // check if piece is selected
  if (pick) 
  { 
    cursor(CROSS);
  }
  else
  { 
    if (!pick) 
    { 
      cursor(ARROW);
      // check if mouse over pieces
      for (i=0;i<numPieces;i++)
      {
        if ((mouseX > pos[i][0]-snap) && (mouseX < pos[i][0]+snap) && (mouseY > pos[i][1]-snap) && (mouseY < pos[i][1]+snap))
        {
          cursor(HAND);
          break;
        }
      }
    }    
    // check mouse over info button
    if ((mouseX > width-16) && (mouseX < width) && (mouseY > 0) && (mouseY < 16))
    {
      cursor(HAND);
    }
  }
}


// ************************
// drawInfoButton FUNCTION
// ************************
void drawInfoButton()
{
  image(infoIMG,781,8);
}



// **********************
// drawBoard FUNCTION
// **********************
void drawBoard()
{
  image(boardIMG, width/2, height/2);
}

// **********************
// centerPiece FUNCTION
// **********************
void centerPiece()
{
  float dd;
  float minDist = 9999.0;

  // place piece within chessboard
  if (point_in_convex_quad(61.0, 127.0, 506.0, 127.0, 727.0, 516.0, 278.0, 516.0, mouseX, mouseY)==true)

    //  if ((mouseX > baseX) && (mouseX < baseX+532) && (mouseY > baseY) && (mouseY < baseY+532))
  {
    println("board");
    // search the nearest square (crosspoint)
    for (i=0;i<numSquares;i++)
    {
      dd =dist(mouseX, mouseY, center[i][0], center[i][1]);
      if (dd < minDist)
      {
        boolean libero=true;
        for(k=0;k<numPieces;k++)
        { 
          if ((center[i][0]==pos[k][0]) && (center[i][1]==pos[k][1]))
          {
            libero=false;
          }
        }
        if (libero==true)  
        { 
          minDist=dd;
          pos[pieceIDX][0] = center[i][0];
          pos[pieceIDX][1] = center[i][1];
          pos[pieceIDX][2] = figureIDX;
          // last move coords
          lastMoveX=center[i][0];
          lastMoveY=center[i][1];          
        }
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
  for (i=0;i<numPieces;i++)
  {
    if (((mouseX > pos[i][0]-snap) && (mouseX < pos[i][0]+snap) && (mouseY > pos[i][1]-snap) && (mouseY < pos[i][1]+snap)) &&
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
  icon.stroke(0);
  icon.line(7, 0, 14, 4);
  icon.line(14, 4, 14, 11);
  icon.line(14, 11, 7, 15); 
  icon.line(7, 15, 0, 11);   
  icon.line(0, 11, 0, 4);     
  icon.line(0, 4, 7, 0);  
  icon.noStroke();
  icon.fill(255,0,0);
  icon.rect(4,4,7,8);
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

