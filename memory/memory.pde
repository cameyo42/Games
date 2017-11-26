// **************************************************
// * memory.pde
// * by cameyo 2013-2014
// *
// * Memory card game.
// *
// * Image courtesy of Hiroshi Yoshii.
// * 
// * code written for Processing 1.5.1 & 2.1
// * MIT license
// **************************************************
//
//  [N] key: start new game
//  [F] key: change type of cards
//  [1..5] key: change back of cards
//  [S] key: save window
//  [D] key: save diagram
//  [I] key: show/hide info

import java.util.Calendar;

// ********************
// VARIABLE DECLARATION
// ********************
String TITLE = "memory cards";

// window info toggle
boolean showInfo;

// card dimension
int cardH=80;
int cardV=80;

// matrix
int numColumns=8;
int numRows=5;

// number of pieces 
int numCards=40;

// number of squares 
int numSquares=40;

// array of cards and their positions
int[][][] pos = new int[numRows][numColumns][4];
// piece[i][j]
// pos[i][j][0] -> x coord
// pos[i][j][1] -> y coord
// pos[i][j][2] -> 0=close, 1=open, -1=visual
// pos[i][j][3] -> image number (IDX of figure array)

// array of numbers (1..numCards)
int[] num = new int[numCards];

// array of figures (images)
// first deck
PImage[] figure = new PImage[20];
// second deck
PImage[] figure2 = new PImage[20];
// toggle cards
boolean FF=true;
// back of cards
PImage[] backCard = new PImage[5];
PImage backCardIMG;

// font for piece
PFont infoFont;
// font for game
PFont gameFont;

// output filename
String filename;

// background color
color backC;

// board image
PImage boardIMG;

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
int snap=38;

//selected piece values
int cardA=-1, cardB=-1;
//selected piece index
int cardA_i=-1;
int cardA_j=-1;
int cardB_i=-1;
int cardB_j=-1;

// mouse clicked variables
boolean firstClick=true;
boolean secondClick=false;

// number of solved pairs
int solved = 0;

// number of turn
int turn=0;

// game time elapsed
int gametime=0;

// game over ?
boolean gameover=true;

// game started ?
boolean gamestart=false;

// counter
int i, j, k;

// base coordinates of board
int baseX=40+40;
int baseY=120;

// time to visualize turn (delay time)
boolean startDelay=false;
int startFrame;
int delayFC=60;

// ********************
// SETUP FUNCTION
// ********************
void setup()
{
  //******************************
  size(763, 545);
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

  // set modes
  imageMode(CENTER);  
  rectMode(CENTER);

  // load board image
  backIMG = loadImage("background.jpg");

  //load cards images
  loadCards();
  // set backcard
  backCardIMG = backCard[0];    

  // load and set font
  infoFont = loadFont("CourierNewPSMT-12.vlw");
  gameFont = loadFont("Arial-BoldMT-24.vlw");  
  textFont(gameFont);
  textAlign(CENTER);

  // load start position of cards
  startPosition();
  
  // shuffle cards  
  shuffle();
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
  
  // draw turn
  textAlign(CENTER);
  textFont(gameFont);
  fill(0,128);
  text(nf(turn,3),681,58);

  // ********************
  // draw all pieces
  // ********************
  for (i=0;i<numRows;i++)
  {
    for (j=0;j<numColumns;j++)
    {
      if (pos[i][j][2] == 0) // draw back of card
      {
        image(backCardIMG,pos[i][j][0],pos[i][j][1]);
        //noStroke();
        //noFill();
        //rect(pos[i][j][0],pos[i][j][1],cardH,cardV);
      }
      if (pos[i][j][2] == 1) // draw card
      {
        image(figure[pos[i][j][3]],pos[i][j][0],pos[i][j][1]);        
        //noStroke();
        //noFill();        
        //rect(pos[i][j][0],pos[i][j][1],cardH,cardV);
      }
      if (pos[i][j][2] == -1) // draw card (temporary)
      {
        image(figure[pos[i][j][3]],pos[i][j][0],pos[i][j][1]);                
        stroke(255,0,0);
        noFill();
        rect(pos[i][j][0],pos[i][j][1],cardH,cardV);
      }      
    }
  }

//  DEBUGGING CODE
//  textFont(infoFont);
//  fill(255);
//  for(i=0;i<numRows;i++)
//  {
//    for(j=0;j<numColumns;j++)    
//    {
//      text(pos[i][j][3],pos[i][j][0],pos[i][j][1]-12);
//      text(pos[i][j][0]+"-"+pos[i][j][1],pos[i][j][0],pos[i][j][1]+26);            
//      text(pos[i][j][2],pos[i][j][0],pos[i][j][1]+12);
//      stroke(0,255,255);
//      ellipse(pos[i][j][0],pos[i][j][1],5,5);            
//    }
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
    text("MEMORY by cameyo", width/2, height/2-80);
    text("The game of memory cards.", width/2, height/2-58);        
    text("Image courtesy of Hiroshi Yoshii.", width/2, height/2-40);    
    textAlign(LEFT);
    text("Click to select the cards...", width/2-100, height/2-18);
    text("[N] key: start new game", width/2-110, height/2+2);
    text("[F] key: change type of figures", width/2-110, height/2+20);
    text("[1..5] key: change back of cards",width/2-110, height/2+38);
    text("[S] key: save window", width/2-110, height/2+56);
    text("[I] key: show/hide info", width/2-110, height/2+74);
    text("________________________________________", width/2-141, height/2+88);
  }

  // delay statements  
  if (startDelay==true)
  {
    if (frameCount > startFrame+delayFC)
    {
      // reset the card with -1 value
      pos[cardA_i][cardA_j][2] = 0;
      pos[cardB_i][cardB_j][2] = 0;
      startDelay=false;
    }
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
  // check if press info button
  if ((mouseX > 11) && (mouseX < 28) && (mouseY > 11) && (mouseY < 28))
  {
    showInfo = !(showInfo);
  }  
  
  if (secondClick) // Second pick -> show second card and control
  {
    //println("second click...");
    //check if clicked on a card
    for (i=0;i<numRows;i++)
    {
      for (j=0;j<numColumns;j++)
      {
        if ((mouseX > pos[i][j][0]-snap) && (mouseX < pos[i][j][0]+snap) && (mouseY > pos[i][j][1]-snap) && (mouseY < pos[i][j][1]+snap))
        {
          // piece selected
          //println("selected second");
          // if clicked on same card
          if ((cardA_i == i) && (cardA_j == j))
          {
            // unselect selected card
            pos[i][j][2]=0;
            //println("second click: OK (same card)");            
            firstClick = true;
            secondClick=false;            
            //println("A = " + cardA + " - " + "B = " + cardB); 
            cardA=-1;
            cardB=-1;
            // turn OK !!!
            turn++;
          }            
            
          // if card is free (not solved) and if not clicked on same card
          if ( (pos[i][j][2] == 0)  && ((cardA_i != i) || (cardA_j != j)) )
          {          
            sel=1;
            cardB_i=i;
            cardB_j=j;
            cardB = pos[i][j][3];
            if (cardA == cardB)
            { // same card value -> SOLVED
              pos[cardA_i][cardA_j][2] = 1;
              pos[cardB_i][cardB_j][2] = 1;
              solved++;
            }
            else
            { // different card values -> UNSOLVED
              // start delay
              startDelay=true;
              startFrame=frameCount;
              pos[cardA_i][cardA_j][2] = -1;
              pos[i][j][2] = -1;
            }  
            firstClick = true;
            secondClick=false;
            //println("second click: OK");
            //println("A = " + cardA);          
            //println(cardB_i + " - " + cardB_j);
            //println("A = " + cardA + " - " + "B = " + cardB); 
            cardA=-1;
            cardB=-1;
            // turn OK
            turn++;
            break;
          }
        }
      }
    }    
  }
  else //(first click)
  {
    println("first click...");    
    //check if clicked on a card
    if (startDelay== false)
    {
      for (i=0;i<numRows;i++)
      {
        for (j=0;j<numColumns;j++)
        {
          if ((mouseX > pos[i][j][0]-snap) && (mouseX < pos[i][j][0]+snap) && (mouseY > pos[i][j][1]-snap) && (mouseY < pos[i][j][1]+snap))
          {
            // piece selected
            //println("selected");
            if (pos[i][j][2] == 0) // check if card is free (not solved)
            {
              sel=1;
              cardA_i = i;
              cardA_j = j;
              cardA = pos[cardA_i][cardA_j][3];
              pos[cardA_i][cardA_j][2]=-1;
              pick = true;
              firstClick=false;
              secondClick=true;
              println("first click: OK");
              println("A = " + cardA);
              println(cardB_i + " - " + cardB_j);          
              break;
            }  
          }
        }
      }
    }
  }
}

// ***************************
// mouseMoved
// ***************************
void mouseMoved()
{
  //set cursor
  cursor(ARROW);
  // check if mouse over pieces
  for (i=0;i<numRows;i++)
  {
    for (j=0;j<numColumns;j++)
    {
      if ((mouseX > pos[i][j][0]-snap) && (mouseX < pos[i][j][0]+snap) && (mouseY > pos[i][j][1]-snap) && (mouseY < pos[i][j][1]+snap))
      {
        cursor(HAND);
        break;
      }
    }
  }    
  // check mouse over info button
  if ((mouseX > 11) && (mouseX < 28) && (mouseY > 11) && (mouseY < 28))
  {
    cursor(HAND);
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
    firstClick=true;
    secondClick=false;
    gameover=true;
    gamestart=false;    
    startDelay=false;    
    turn=0;
    startPosition();    
    shuffle();
  }

  // change type of figures
  if (key=='f' || key=='F')
  {
    changeCards();
  }

  // backcard 01
  if (key=='1')
  {
    backCardIMG=backCard[0];
  }
  
  // backcard 02
  if (key=='2')
  {
    backCardIMG=backCard[1];
  }

  // backcard 03
  if (key=='3')
  {
    backCardIMG=backCard[2];
  }

  // backcard 04
  if (key=='4')
  {
    backCardIMG=backCard[3];
  }

  // backcard 05
  if (key=='5')
  {
    backCardIMG=backCard[4];
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


// **********************
// drawBoard FUNCTION
// **********************
void drawBoard()
{
  image(boardIMG, width/2, height/2);
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
//  icon.rect(0, 0, 15, 15);

  
  icon.noStroke();
  icon.fill(255,0,0);
  icon.rect(2,2,5,5);
  
  icon.fill(0,0,255);
  icon.rect(9,2,5,5);
  icon.rect(2,9,5,5);

  icon.fill(255,0,0);
  icon.rect(9,9,5,5);  
  

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

