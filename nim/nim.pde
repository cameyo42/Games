// **************************************************
// * nim.pde
// * by cameyo 2013
// *
// * The Nim game (aka Marienbad)
// *
// * code written for Processing 1.5.1 & 2.1
// * MIT license
// **************************************************
//
//  [N] key: new game
//  [C] key: new game against computer
//  [S] key: save window
//  [D] key: save diagram
//  [I] key: show/hide info

// The traditional Nim-game (aka Marienbad-game) consists of
// four rows of 1, 3, 5 and 7 matchsticks.
// Two players take any number of matchsticks from one row
// alternately. 
// The one, who takes the last matchstick wins (or loses).

// The winning strategy is:
// You must always take as many matchsticks as possible so that
// the “Nim sum” of the rows remains ZERO.

// The starting configuration 1, 3, 5, 7 is a losing one for the player
// who starts the game. Furthermore, the player who starts the game first will
// obviously lose if his opponent takes care to keep during the whole game play a
// zero “Nim sum” configuration. 
// In conclusion, it is ALWAYS disadvantageous to start the game first!

// To 'Nim-add' use 'xor'
// 1 xor 3 xor 5 xor 7 = 0

// Computer plays as player "A" and move first (you can win!).

import java.util.Calendar;

// ********************
// VARIABLE DECLARATION
// ********************
String TITLE = "nim";

// window info toggle
boolean showInfo;

// background image
PImage backIMG;

// image of match (fiammifero)
PImage stickIMG;
PImage burnedIMG;

// gameover image
PImage gameoverIMG;

// player images
PImage computerIMG;
PImage humanIMG;

// font
PFont infoFont;
PFont gameFont;

// number of points
int numPoints = 16;

// number of active points 
int curPoints = 16;

// array of points
int[][] punti = new int[numPoints][3];
// n-esimo point
// punti[n][0] -> x
// punti[n][1] -> y
// punti[n][2] -> 0 (empty), 1 (fill), -1 (possible or temporary captured)

// number of rows
int numRows = 4;

// array of rows
int[] righe = new int[4];

// number of capture
int numCaptured = 0;

// array of captured
int[] captured = new int[numPoints];

// index
int i,j,k;

// draw marque ?
boolean drawMarquee=false;

// must capture points ?
boolean mustCapture=false;

// marquee coords 
int bX=0, bY=0; //first point
int eX=0, eY=0; //second point

// value of position
int posValue=-999;

// start coords
int baseX=200;
int baseY=85;
int distH=40;
int distV=90;

// game over ?
boolean gameover=false;

// current player
String player="A";

// computer player
boolean computer=false;
boolean computerTurn=false;

// time to visualize turn (delay time)
boolean startDelay=false;
int startFrame;
int delayFC=100;

// computer move
int rowComputer=-1;
int stickComputer=-1;

//******************
// SETUP
//******************
void setup() 
{
  //******************************  
  size(400,450);
  //******************************
  
  // set window title
  frame.setTitle(TITLE);
  // set window icon image
  changeAppIcon();
  
  // smooth drawing
  smooth();
  // screen update
  frameRate(30);

  // set modes
  rectMode(CORNERS);
  textAlign(CENTER);
  imageMode(CENTER);  

  // load and set font
  infoFont = loadFont("CourierNewPSMT-12.vlw");
  //gameFont = loadFont("SansSerif.plain-16.vlw");  

  // load background image
  backIMG = loadImage("background.jpg");
  
  // load stich image
  stickIMG = loadImage("stick.png");
  burnedIMG = loadImage("burned.png");  
  gameoverIMG = loadImage("gameover.jpg");    
  
  //load player images
  computerIMG = loadImage("computer.png");
  humanIMG = loadImage("human.png");    
  
  // load data for of points
  loadPoints();
  
  // test eval function
  //int val= 0^1^3^5^7;
  //println("start value: "+val);
  
}

//******************
// DRAW
//******************
void draw() 
{
  background(255);
  strokeWeight(1);  
  noStroke();
  fill(255,60,60);
  
  // draw background
  image(backIMG, width/2, height/2);

  // computer player ?  
  if (computer==true)
  {
//    fill(255,128);
//    textFont(gameFont);
//    text("CPU",46,88);
//    text("BRAIN",352,88);    
    image(computerIMG,48,48);
    image(humanIMG,352,48);
//    text("computer",70,67);
  }  
  
  // highlight current player
  noFill();  
  stroke(255);
  rectMode(CORNERS);
  if (player.equals("A"))
  {
    rect(28,28,67,67);
    rect(29,29,66,66);    
  }
  else
  {
    rect(332,28,371,67);
    rect(333,29,370,66);    
  }
  noStroke();
  rectMode(CENTER);  
  
  //draw points (stick images)
  for (i=0;i<numPoints;i++)
  { 
    if (punti[i][2]==0) // empty
    { 
      fill(0);
      ellipse(punti[i][0],punti[i][1],5,5);      
    } 
    else // 1 or -1 
    {
      image(stickIMG,punti[i][0],punti[i][1]);    
    }  
    
    if ((punti[i][2]==-1) && (computer==true)) // computer temporary selected
    {
      // draw rect around selected sticks
      fill(0,0,0,40);    
      stroke(0);
      strokeWeight(1);
      //ellipse(punti[i][0],punti[i][1],15,15);
      //rect(punti[i][0],punti[i][1],15,15);
      rect(punti[i][0],punti[i][1]+1,21,82);      
      strokeWeight(1);
      noStroke();
      noFill();
    }  
      
  } 
  rectMode(CORNERS);  

// DEBUG CODE    
//  for (i=0;i<numPoints;i++)
//  { 
//    if (punti[i][2]==0)
//    { fill(0); }
//    else 
//    { fill(255); }
//    ellipse(punti[i][0],punti[i][1],7,7);
////    image(stickIMG,punti[i][0],punti[i][1]);    
//    text(punti[i][2],punti[i][0]+8,punti[i][1]-6);
//    text(i,punti[i][0]-10,punti[i][1]+22);    
//  }  
  
  // draw marquee ?
  if (drawMarquee)
  {
    strokeWeight(1);  
    stroke(0);
    fill(0,0,0,40);    
    //rect(bX,bY,mouseX,(mouseX-bX)+bY); //quad marquee
    rect(bX,bY,mouseX,mouseY);           //rect marquee
  }
  
  // capture piece ?
  if (mustCapture==true)
  {
    capture();
  }  
  
  // check if game over
  if (curPoints==0)
  {
//    println(player + " WIN");
    if (startDelay==false)
    {
     
      // show winner/loser images
      if (player.equals("A"))
      {
        image(stickIMG,48,130);     
        image(burnedIMG,352,130);        
      }
      else
      {
        image(burnedIMG,48,130);    
        image(stickIMG,352,130);  
      }  
      gameover=true;
      image(gameoverIMG,200,50);
    }  
  }  
  
  // draw info window
  if (showInfo)
  {
    int m = 56;
    fill(0, 210);
    rectMode(CENTER);
    textAlign(CENTER);
    noStroke();
    rect(width/2, height/2, 360, 242);
    fill(240);
    textFont(infoFont);
    text("NIM by cameyo", width/2, 70+m);
    textAlign(LEFT);
    text("The Nim game (aka Mariembad) consists of",38,94+m);
    text("four rows of 1, 3, 5 and 7 matchsticks.",38,110+m);    
    text("Two players take any number of matchsticks",38,126+m);    
    text("from one row alternately.",38,142+m);
    text("The one, who takes the last matchstick wins.",38,158+m);    
    text("Click and drag to select matchsticks.", 68, 190+m);
    text("[N] key: new game", 68, 212+m);
    text("[C] key: new game vs computer", 68, 228+m);
    text("[S] key: save window", 68, 244+m);
    text("[I] key: show/hide info", 68, 260+m);
    text("_______________________________________________", 35, 276+m);
    textAlign(CENTER);
  }

  // computer move
  if ((computer == true) && (gameover == false) && (computerTurn == true) && (startDelay==false) )
  {
    computerMove();
    // update status
    curPoints = curPoints - stickComputer;
    righe[rowComputer]=righe[rowComputer]-stickComputer;
    //print("(c)RIGHE ");
    //for(i=0;i<numRows;i++)
    //{
      //print(righe[i]+" - ");
    //}  
    //println("");
    //println("(c)POINTS: " + curPoints);
    startFrame = frameCount;
    startDelay=true;
//    computerTurn=false;
  }  
  
  // delay statements  (time to visualize computer move)
  if (startDelay==true)
  { 
    // check if time is over
    if (frameCount > startFrame+delayFC)
    {
      // reset the selected sticks (computer) with 0 value
      for (i=0;i<numPoints;i++)
      { 
        if (punti[i][2]==-1) { punti[i][2]=0; }  
      }
      // stop delay
      startDelay=false;
      //switch player
      computerTurn=false;      
      switchPlayer("computer");
    }  
  }

//    if ((curPoints==0) && (gameover==true) && (startDelay==false) && (numCaptured==0) && (mustCapture==false))
//    { 
//      // stop loop (save CPU and laptop battery)
//      noLoop();
//    } 
  
}

         

// ***************************
// mousePressed
// ***************************
void mousePressed()
{
  if (mouseY < 420)
  { 
    if (drawMarquee) // second click: deactivate marquee
    {
      mustCapture=false;
      // second point coords (LR)
      eX = mouseX;
      eY = mouseY;    
      //println(bX+","+bY+","+eX+","+eY);
      drawMarquee = false;
      // sort marquee coords
      int ulX,ulY,lrX,lrY;    
      
      if (bX < eX)
      {
        if (bY < eY)
        { 
          ulX=bX; ulY=bY;
          lrX=eX; lrY=eY;
        }  
        else
        {
          ulX = bX; ulY = eY;
          lrX = eX; lrY = bY;
        }
      }  
      else // bX > eX
      {
        if (bY > eY)
        { 
          ulX=eX; ulY=eY;
          lrX=bX; lrY=bY;
        }  
        else 
        {
          ulX=eX; ulY=bY;
          lrX=bX; lrY=eY;
        }      
      }
      
      bX=ulX; bY=ulY;
      eX=lrX; eY=lrY;
      
      //println(bX+","+bY+","+eX+","+eY);
      
      if ((bX==eX) || (bY==eY))
      {
        //println("no marquee!");
      }
      else
      {
        mustCapture=true;
      }  
  //    fill(255,0,0);
  //    ellipse(bX,bY,5,5);    
  //    fill(255,255,0);    
  //    ellipse(eX,eY,5,5);    
  //    noLoop();
    }
    
    else // first click: activate marquee
    { 
      if (computerTurn==false)
      {
        drawMarquee = true;
        //first point coords (UL)
        bX = mouseX;
        bY = mouseY;
        //println(bX+","+bY);
      } 
    }
  } // end if (mouseY < 420)
  
  // check if press info button
  if ((mouseX > 10) && (mouseX < 27) && (mouseY > 422) && (mouseY < 439))
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
  // check mouse over info button
  if ((mouseX > 10) && (mouseX < 27) && (mouseY > 422) && (mouseY < 439))
  {
    cursor(HAND);
  }
  else
  { 
    cursor(ARROW); 
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
    gameover=false;
    numCaptured=0;
    player="A";
    computer=false;
    curPoints=16;
    loadPoints();
    //loop();    
  }
  
  // play against computer
  if (key=='c' || key=='C')
  {
    gameover=false;
    numCaptured=0;
    player="A";
    computer=true;
    computerTurn=true;    
    curPoints=16;
    loadPoints();
    //loop();
  }  

  // show eval function values
  if (key=='e' || key=='E')
  {
    evalMove();
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
    drawMarquee=false;
    //println("ESC");
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
  icon.rect(0, 0, 15, 15);
  icon.noStroke();
  icon.fill(255,0,0);
  icon.rect(3,3,2,2);
  icon.fill(211,169,102);  
  icon.rect(3,5,2,8);
  
  icon.fill(255,0,0);
  icon.rect(7,3,2,2);
  icon.fill(211,169,102);  
  icon.rect(7,5,2,8);
  
  icon.fill(255,0,0);
  icon.rect(11,3,2,2);
  icon.fill(211,169,102);  
  icon.rect(11,5,2,8);
  
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


