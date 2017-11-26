// http://www.openprocessing.org/sketch/11828
// ******************************************************
// * flowers.pde
// * by cameyo 2014
// *
// * FlowerSweeper
// * The game of minesweeper...with flowers.
// *
// * code written for Processing 1.5.1 & 2.1
// * MIT license
// ******************************************************
//
//  [N] key: start new game
//  [+] key: add flower
//  [-] key: remove flower
//  [S] key: save window
//  [I] key: show/hide info

import java.util.Calendar;

// ********************
// VARIABLE DECLARATION
// ********************
String TITLE = "flowersweeper";

// window info toggle
boolean showInfo;

// game font
PFont gameFont;
// font for info
PFont infoFont;

// bottom image
PImage bottomIMG;
// info window image
PImage infowinIMG;

// flower image
//PImage fioreIMG;
PImage[] fioreIMG = new PImage[8];
PImage zfioreIMG;

// number of total caselle
int numCaselle = 10 * 10;

// dimension of matrix
int dim = floor(sqrt(numCaselle));

// index 
int i, j, k, x, y;

// lenght of side of board
int boardSide = 550;

// lenght of side of casella
int caSize = boardSide / dim;

// number of flowers
int numFlowers = 2;

// number of flowers
int numFlagged = 0;

// identifier
int id = 0;

// color clickable case (light)
color colC = color(114,216,72);
// color unclickable case (dark)
color colU = color(73,149,36);

// first click 
boolean putFlowers = true;

// board matrix
Casella[][] board;

// win and lose
boolean lose=false;
boolean win=false;


//******************
// SETUP
//******************
void setup()
{
  size(551,620);
  // set window title
  frame.setTitle(TITLE);
  // set window icon image
  changeAppIcon();
  
  // smooth drawing
  smooth();
  
  // screen update (go slow...)
  frameRate(10);
  
  // set background color  
  background(220);

  // set modes
  textAlign(CENTER);
  imageMode(CORNER);  

  // load and set font
  infoFont = loadFont("CourierNewPSMT-12.vlw");
  gameFont = loadFont("Calibri-Bold-24.vlw");  
  textFont(gameFont);

  // load bottom image
  bottomIMG = loadImage("bottom.jpg");  
  // load info window image
  infowinIMG = loadImage("infowin.jpg");  
  
  // load flower images
  fioreIMG[0] = loadImage("fiore00.png");
  fioreIMG[1] = loadImage("fiore01.png");
  fioreIMG[2] = loadImage("fiore02.png");
  fioreIMG[3] = loadImage("fiore03.png");
  fioreIMG[4] = loadImage("fiore04.png");
  fioreIMG[5] = loadImage("fiore05.png");
  fioreIMG[6] = loadImage("fiore06.png");
  fioreIMG[7] = loadImage("fiore07.png");  
  zfioreIMG = loadImage("fioreZ.png");  
  
  // set colors
  stroke(0);
  fill(colC);
  
  // set number of Flowers
  numFlowers=numFlowers+2;
  if (numFlowers > 20)
  {
    numFlowers=20;
  }  
  if (numFlowers < 4)
  {
    numFlowers=4;
  }    
  
  // numbers of flagged case
  numFlagged = 0;
  
  // win or lose
  lose=false;
  win=false;  
  
  //create matrix board 
  board = new Casella[dim][dim];
  
  // assign caselle to matrix board
  id = 0;  
  for(y = 0; y < dim; y++)
  {
    for(x = 0; x < dim; x++)
    {
      Casella casa = new Casella(id, x*caSize, y*caSize, caSize);
      board[y][x] = casa;
      id = id + 1;
    }
  }

  // put random flowers on board  
  putFlowers();

}

//******************
// DRAW
//******************
void draw() 
{
  if (showInfo)
  {
    image(infowinIMG,2,551);
  }  
  else
  {  
    updateBottom();
    if (win)  { win();  }
    if (lose) { lose(); }    
  }  
  
}

//******************
// UPDATE BOTTOM
//******************
void updateBottom()
{
//  stroke(255,0,0);
//  fill(255);
//  rect(0,551,550,68);
  fill(40);
  image(bottomIMG,2,551);
//  text("Left:",52,576);
  text(numFlowers-numFlagged,52,604);
//  text("Total:",494,576);  
  text(numFlowers,499,604);
}  
  
//******************
// PUT FLOWERS
//******************  
void putFlowers()
{
  // put flowers on board
  int fx, fy;
  for(i = 0; i < numFlowers; i++)
  {
    fx = floor(random(dim));
    fy = floor(random(dim));
    if(board[fy][fx].flower == 0)            
    {
      board[fy][fx].aFlower();
    }  
    else 
    {
      i--;
    }  
  }
}

//******************
// NEW GAME
//******************
void newGame()
{
  // set background color 
  background(220);
  // set modes
  textAlign(CENTER);
  imageMode(CORNER);  
  // set colors
  stroke(0);
  fill(colC);
  // set number of Flowers
  numFlowers=numFlowers+2;
  if (numFlowers > 20)  { numFlowers=20; }  
  if (numFlowers < 4)   { numFlowers=4;  }    
  // numbers of flagged case
  numFlagged = 0;
  // win or lose
  lose=false;
  win=false;  
  //create matrix board 
  board = new Casella[dim][dim];
  // assign caselle to matrix board
  id = 0;  
  for(y = 0; y < dim; y++)
  {
    for(x = 0; x < dim; x++)
    {
      Casella casa = new Casella(id, x*caSize, y*caSize, caSize);
      board[y][x] = casa;
      id = id + 1;
    }
  }
  // put random flowers on board  
  putFlowers();
}

//******************
// CLICKABLE CASE
//******************
int clickableCase()
{
  int i,j;
  int total = 0;

  for(i = 0; i < dim; i++)
  {
    for(j = 0; j < dim; j++)
    {
      if(!board[i][j].clicked) { total++; }  
    }
  }
  return total;
}

//******************
// FLAGGED CASE
//******************
int flaggedCase()
{
  int i,j;
  int total = 0;

  for(i = 0; i < dim; i++)
  {
    for(j = 0; j < dim; j++)
    {
      if(board[i][j].flagged) { total++; }  
    }
  }
  return total;
}

//******************
// WIN
//******************
void win()
{
  textAlign(CENTER);
  rectMode(CENTER);
  stroke(168,111,53);
  strokeWeight(3);
  fill(0,200);
  rect(width/2,height/2,200,80);
  fill(220);
  text("BRAVO !!!", width/2, height/2-2);
  textSize(14);
  text("Press 'N' to start new game", width/2, height/2+28);  
  textSize(24);
  rectMode(CORNER); 
  strokeWeight(1);  
  updateBottom();
  noLoop();
}

//******************
// LOSE
//******************
void lose()
{
  textAlign(CENTER);
  rectMode(CENTER);
  stroke(168,111,53);
  strokeWeight(3);  
  fill(0,200);
  rect(width/2,height/2,200,80);
  fill(220);
  text("try again...", width/2, height/2-2);
  textSize(14);
  text("Press 'N' to start new game", width/2, height/2+28);  
  textSize(24);
  rectMode(CORNER); 
  strokeWeight(1);  
  updateBottom();
  noLoop();
}


//******************
// KEY PRESSED
//******************
void keyPressed()
{
  if (key=='n' || key =='N')
  {
    background(220);
    board = null;
    newGame();
    loop();            
  }
  
// DEBUG CODE
//  if (key=='p' || key =='P')
//  {
//    String SS;
//    textSize(12);
//    for(y = 0; y < dim; y++)
//    {
//      for(x = 0; x < dim; x++)
//      {
//        int CC=0;
//        if (board[y][x].clicked) { CC=1;}
//        text(CC, x*caSize + caSize / 2 + 1, y*caSize + caSize/2 + 18);        
//
//        int FF=0;
//        if (board[y][x].flagged) { FF=1;}
//        text(FF, x*caSize + caSize / 2 + 1, y*caSize + caSize/2 -16);               
//        //println(x +","+y+" -> C="+CC+"+  "+"F= "+FF);
//      }
//    }
//    println("clickable = "+clickableCase());
//    println("flagged = "+flaggedCase());    
//  }  

  // save image window
  if (key=='+')
  {
    if (lose || win)
    {
      loop();      
      numFlowers++;
      updateBottom();
    }
  }
  
  if (key=='-')
  {
    if (lose || win)
    {
      loop();      
      numFlowers--;
      updateBottom();
    }  
  }  
  
  if (key=='r' || key=='R')
  {
    if (lose || win)
    {
      loop();
      numFlowers=2;
      updateBottom();
    }  
  }    

  // save image window
  if (key=='s' || key=='S')
  {
    saveFrame("s" + timestamp() + ".png");
  }

  // show info window
  if (key=='i' || key=='I')
  {
    showInfo = !(showInfo);
  }  
  
  // intercept ESC key
  if (keyCode==ESC)
  {
    key=0;
    //println("ESC");
  }    
 
}

//******************
// MOUSE PRESSED
//******************
void mousePressed()
{ 
  int i,j;

  //  println("mouse: " + mouseX + " - " + mouseY);  
  
  // check if press info button
  if ((mouseX > 2) && (mouseX < 19) && (mouseY > 600) && (mouseY < 617))
  {
    showInfo = !(showInfo);
  }    
  
  if (!showInfo)
  {
    if(mouseButton == LEFT)
    {
      for(y = 0; y < dim; y++)
      {
        for(x = 0; x < dim; x++)
        {
          if ((mouseX >= x*caSize + 3) && (mouseX <= x*caSize + caSize - 3) &&
              (mouseY >= y*caSize + 3) && (mouseY <= y*caSize + caSize - 3))
          {
            // if not flagged find flowers around
            if(!board[y][x].flagged) 
            {
              board[y][x].countFlowers();
            }  
            
          }
        }
      }
    }
    else if (mouseButton == RIGHT)
    {
      // put OR remove flag of flower (water) on clicked casa
      for(y = 0; y < dim; y++)
      {
        for(x = 0; x < dim; x++)
        {
          if ((mouseX >= x*caSize + 3) && (mouseX <= x*caSize + caSize - 3) &&
              (mouseY >= y*caSize + 3) && (mouseY <= y*caSize + caSize - 3))
          {
            if(!board[y][x].clicked)
            {
              board[y][x].switchFlag();
            }
          }
        }
      }
    }
    
    // check if win
    if (lose==false)
    {
      if ((numFlowers == clickableCase()) && (numFlowers == flaggedCase()))
      {
         win=true;      
      }  
    }
  } // if (!showinfo);  
 
}


// ***************************
// mouseMoved
// ***************************
void mouseMoved()
{
  //set cursor
  // check if mouse is over bottom
  if (mouseY < 550) { cursor(CROSS); }
  
  // check mouse over info button
  else if ((mouseX > 2) && (mouseX < 19) && (mouseY > 600) && (mouseY < 617))
  {
    cursor(HAND);
  }
  else
  { cursor(ARROW); }

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
  icon.rect(0, 0, 14, 14);
  icon.stroke(114,216,72);
  icon.line(7,2,7,12);
  icon.stroke(71,105,209);
  icon.line(2,7,12,7);
  icon.stroke(255,206,87);
  icon.line(3,3,11,11);
  icon.stroke(254,87,22);
  icon.line(11,3,3,11);  
  
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
