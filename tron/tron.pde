
// Tron by cameyo
// **************************************************
// * tron.pde
// * by cameyo 2013
// *
// * The game of Tron.
// *
// * code written for Processing 1.5.1 & 2.1
// * MIT license
// **************************************************
//
//  [N] key: start new game
//  [cursor arrow] key: up, right, down, left
//  [W,D,S,A] key: up, right, down, left
//  [R] key: reset score
//  [P] key: save window


import java.util.Calendar;

// ********************
// VARIABLE DECLARATION
// ********************
String TITLE = "tron";

// image title
PImage panelIMG;  

// font
PFont tronFont;
PFont infoFont;

// human start and previous coords 
int x,y;
int px,py;

// pixel size of moto
int moto = 3;

// computer start and previous coords
int compx,compy;
int pcompx,pcompy;

// initial direction
String compdir="SINISTRA";
String dir="DESTRA";

// computer movements
int movements;

// gameover variables
boolean gameover=false;
String winner="";
PImage crashIMG;
int crashX, crashY;

// score
int scoreH=0;
int scoreC=0;

// colors of moto
color hCol, hCol2, hHeadCol;
color cCol, cCol2, cHeadCol;

// board color
color boardCol;

// velocity (from -3 to +6)
int vel=0;

// pause game
boolean pause=true;

//*********************************
// INITVARS
//*********************************
void initVars()
{
  // set drawing modes
  imageMode(CENTER);
  rectMode(CENTER);  
  
  // set font  
  textFont(tronFont);
  
  // set board color
  boardCol = color(12,20,31);
  
  // set moto colors
  hCol = color(223,116,12);
  hCol2 = color(255,230,77);
  hHeadCol = color(255);
  cCol = color(111, 195, 223);
  cCol2 = color(230,255,255);  
  cHeadCol = color(255);  
    
  // set start coords base (HUMAN)
  x=width/2-151;
  y=height/2+50;
  px=width/2-151;
  py=height/2+50;
  
  // set start coords base (COMPUTER)
  compx=width/2+149;
  compy=height/2+50;
  pcompx=width/2+149;
  pcompy=height/2+50;
  
  // add random Y start
  y = y + 3*int(random(-20,21));
  py = y;
  compy = compy + 3*int(random(-20,21));
  pcompy = compy;
//  println(x+"-"+y);
//  println(compx+"-"+compy);

  // start directions
  compdir="SINISTRA";
  dir="DESTRA";
 
  // random movements: CLOCKWISE or ANTICLOCKWISE
  if (int(random(0,2)) == 0)
  { movements = 0; } //clockwise
  else
  { movements = 1; } // anticlockwise

  // game is on
  gameover=false;
  
  // pause is on
  pause=true;
}  


//*********************************
// SETUP
//*********************************
void setup()
{
//***************
  size(600, 600);
//***************  

  // set window title
  frame.setTitle(TITLE);
  // set window icon image
  changeAppIcon();  
  
  //set background color
  boardCol = color(12,20,31);  
  background(boardCol);

  // set framerate (used to control game velocity)
  frameRate(60+10*vel);
  //println("vel("+vel+") = "+(60+10*vel));
  
  // load fonts
  tronFont = loadFont("TRN-36.vlw");
  infoFont = loadFont("CourierNewPSMT-12.vlw");
  //load images  
  crashIMG = loadImage("crash.png");
  panelIMG = loadImage("panel.png");  

  
  // init variables
  initVars();
  
  // draw board
  drawBoard();
  
  // updateScore
  updateScore();

  // draw
  loop(); 
}

//*********************************
// DRAW
//*********************************
void draw()
{
  if (pause==false)
    {
    if (gameover==true)
    {
      noLoop();
    }
    else
    {
      compMove();
      if (gameover==true)    
       {
         noLoop();    
       }
      else  
      {
        humanMove();
      }  
      if (gameover==true)    
       {
         noLoop();    
       }  
    }
  }
}

//  [cursor arrow] key: up, right, down, left
//  [W,D,S,A] key: up, right, down, left
//  [R] key: reset score
//  [P] key: save window

//*********************************
// KEYPRESSED
//*********************************
void keyPressed()
{
  if ((keyCode==LEFT) || (key=='a'))
  {
    dir="SINISTRA"; pause=false;
  }
  else if ((keyCode==RIGHT) || (key=='d'))
  {
    dir="DESTRA"; pause=false;
  }
  else if ((keyCode==UP) || (key=='w'))
  {
    dir="SOPRA"; pause=false;
  }
  else if ((keyCode==DOWN) || (key=='s'))
  {
    dir="SOTTO"; pause=false;
  }
  
  if ((key=='n') || (key=='N'))
  {
    initVars();
    drawBoard();   
    updateScore();
    if ((scoreH-scoreC) > 1)
    {
      vel++;
      if (vel > 6) { vel = 6; }
    }  
    if ((scoreC-scoreH) > 1)
    {
      vel--;
      if (vel < -3) { vel = -3; }
    }      
    // println("vel = " + vel);
    loop();//setup();
  }  

  // reset score and velocity
  if (key=='r' || key=='R')
  {
    scoreH = 0;
    scoreC = 0;
    vel = 1;
    loop();
    updateScore();
  }

  // save image window
  if (key=='p' || key=='P')
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

//*********************************
// HUMAN MOVE
//*********************************
void humanMove()
{
  // check human collision
  if (get(x, y) != boardCol)
  {
    // gameover
    gameover=true;
    // computer win
    winner="computer";
    crashX = x;
    crashY = y;
    scoreC++;    
    if (scoreC > 999) { scoreC = 0; scoreH = 0; }
    updateScore();
    image(crashIMG,crashX,crashY);    
    stroke(128);
    fill(0,200);
    rectMode(CENTER);
    rect(width/2, height/2, 310, 50);
    fill(cCol);    
    textAlign(CENTER);
    text("computer WIN",width/2, height/2+13);
    // endgame
    endGame();
  }
  else // make a human move
  {
    // draw current point
    fill(hCol2);
    stroke(hCol);
    rect(x, y, moto-1, moto-1);
    // change previous point color
    fill(hCol2);
    stroke(hCol);    
    rect(px, py, moto-1, moto-1);    
    // copy coords
    px=x;
    py=y;
    
    if (dir=="DESTRA")
    {
      x=x+moto;
    }
    else if (dir=="SINISTRA")
    {
      x=x-moto;
    }
    else if (dir=="SOPRA")
    {
      y=y-moto;
    }
    else if (dir=="SOTTO")
    {
      y=y+moto;
    }
  }
}

//*********************************
// COMPUTER MOVE
//*********************************
void compMove()
{
  // check computer collision
  if (get(compx, compy) !=boardCol)
  {
    // game over
    gameover=true;
    // human win
    winner="human";
    crashX = compx;
    crashY = compy;
    scoreH++;  
    if (scoreH > 999) { scoreH = 0; scoreC = 0; }    
    updateScore();
    image(crashIMG,crashX,crashY);        
    stroke(128);
    fill(0,200);
    rectMode(CENTER);
    rect(width/2, height/2, 230, 50);
    fill(hCol);    
    textAlign(CENTER);
    text("human WIN",width/2 + 2, height/2+13);
    // endgame
    endGame();    
  }
  else 
  {
    // draw current point
    fill(cCol2);
    stroke(cCol);
    rect(compx, compy, moto-1, moto-1);
    // change previous point color
    fill(cCol2);
    stroke(cCol);    
    rect(pcompx, pcompy, moto-1, moto-1);    
    // copy coords
    pcompx=compx;
    pcompy=compy;    
    
    if (movements==0)
    { clockwise();}
    else
    { anticlockwise();}
  }
}

// **********************
// draw board FUNCTION
// **********************
void drawBoard()
{
  // draw board borders (yellow)
  int ax,bx,cx,dx;
  int ay,by,cy,dy;  
  
  //set background color
  boardCol = color(12,20,31);  
  background(boardCol);  

//  ax=14; ay=35;
//  bx=584; by=35;
//  cx=584; cy=584;
//  dx=14; dy=584;

  ax=14; ay=41;
  bx=584; by=41;
  cx=584; cy=584;
  dx=14; dy=584;

  noFill();
  stroke(255,255,0);
  stroke(0,86,255,200);
  // internal border
  line(ax,ay,bx,by);
  line(bx,by,cx,cy);  
  line(cx,cy,dx,dy);
  line(dx,dy,ax,ay);
  
  // external border
  rectMode(CORNER);
  rect(ax-2,ay-2,574,547);
  rectMode(CENTER);  
}

// **********************
// update score FUNCTION
// **********************
void updateScore()
{
  // draw to panel
  imageMode(CORNER);
  image(panelIMG,12,0);
  imageMode(CENTER);
  // print human score
  textAlign(CENTER);
  fill(hCol);
  text(scoreH,61,32);
  // print computer score
  fill(cCol);
  text(scoreC,538,32);  
}  

// **********************
// endGame FUNCTION
// **********************
void endGame()
{
    stroke(255);
    fill(0,200);
//    rectMode(CENTER);
    rect(432,450,280,110);
    fill(255);
    textFont(infoFont);
    textAlign(LEFT);    
    text("Press 'N' to start new game",width/2, height/2+114);
    text("Press 'R' to reset score and velocity",width/2, height/2+130);
    text("Movements: [up arrow] or [W]: UP",width/2, height/2+146);    
    text("           [right arrow] or [D]: RIGHT",width/2, height/2+162);        
    text("           [down arrow] or [S]: DOWN",width/2, height/2+178);        
    text("           [left arrow] or [A]: LEFT",width/2, height/2+194);            
    textFont(tronFont);    
    textAlign(CENTER);
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
 
  icon.stroke(223,116,12);
  icon.line(4,13,2,13);  
  icon.line(2,13,2,8);
  icon.line(2,8,5,8);
  icon.line(5,8,5,2);
  icon.line(5,2,8,2);
  
  icon.stroke(111, 195, 223);
  icon.line(8,13,13,13);
  icon.line(13,13,13,10);
  icon.line(13,10,9,10);
  icon.line(9,10,9,6);
  icon.line(9,6,13,6);
  icon.line(13,6,13,2);

  icon.endDraw();
  // set icon
  //setIconImage(icon.image);
}


// **********************
// timestamp FUNCTION
// **********************
String timestamp()
{
  Calendar now = Calendar.getInstance();
  return String.format("20%1$ty-%1$tm-%1$td_%1$tH.%1$tM.%1$tS", now);
}