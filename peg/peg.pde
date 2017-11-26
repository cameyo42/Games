// **************************************************
// * peg.pde
// * by cameyo 2013
// *
// * English Peg solitaire.
// *
// * code written for Processing 1.5.1 & 2.1
// * MIT license
// **************************************************
//
//  [N] key: start new game
//  [0]..[9] key: variation X
//  [U] key: undo last move
//  [M] key: show legal move
//  [F] key: change figures
//  [S] key: save window
//  [I] key: show/hide info

import java.util.Calendar;

// ********************
// VARIABLE DECLARATION
// ********************
String TITLE = "peg solitaire";

// window info toggle
boolean showInfo;

// base coordinates of board
int baseX=0;
int baseY=0;

// number of pieces
int numPieces=32;

// number of squares
int numSquares=33;

// number of rows/columns
int dim=11;

// array of square (positions and status)
int[][][] casella = new int[dim][dim][4];
// piece[i][j][0] -> x coord
// piece[i][j][1] -> y coord
// piece[i][j][2] -> -1(outboard), 0(empty), 1(piece)
// piece[i][j][3] -> -1(piece blocked), 1(piece free)

// backup array
// max number of backup
int maxBack=50;
// current backup number
int back=0;
// backup level
int backLevel=0;
// array of backup positions
int[][][][] backup = new int[maxBack][dim][dim][4];

// font for piece
PFont infoFont;
boolean FF=true;

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

// image of piece
PImage pieceA_IMG, pieceB_IMG, curIMG;

// picked piece
boolean pick=false;

// selected and captured piece index
int sel=-1;
int cap=-1;

// snap for select
int snap=21;

//selected piece/square index values
int i_idx, j_idx;

//selected piece/square coords values
int x_idx=-1, y_idx=-1;


// show legal move
boolean showMove=false;

// last move coords
int lastMoveX=-100;
int lastMoveY=-100;

// counter
int i, j, k;

// ********************
// SETUP FUNCTION
// ********************
void setup()
{
  //******************************
//  size(491, 491);
  size(668, 668);
  //size(1000, 1000);
  //******************************
  // set window title
  frame.setTitle(TITLE);
  // set window icon image
  changeAppIcon();

  // smooth drawing
  smooth();
  // screen update
//  frameRate(60);

  // set background color
  backC = color(60);
  background(backC);

  // set image mode
  imageMode(CENTER);

  // load board images
  boardIMG = loadImage("board.jpg");
  backIMG = loadImage("background.jpg");
  infoIMG = loadImage("infoButton.jpg");

  //load piece images
  pieceA_IMG = loadImage("figureA.png");
  pieceB_IMG = loadImage("figureB.png");

  // load and set font
  infoFont = loadFont("CourierNewPSMT-12.vlw");
  textAlign(CENTER);

  // initialize piece
  curIMG = pieceA_IMG;

  // draw board
  drawBoard();

  // load start position
  startPosition();

  // cretate list of move
  makeMoveList();
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
  drawBoard();

  // draw info button
  //drawInfoButton();

  // ********************
  // draw all pieces
  // ********************
  noStroke();
  fill(250,250,250,150);
  for (i=0;i<dim;i++)
  {
    for (j=0;j<dim;j++)
    {
      if ( (casella[i][j][2] != -1) && (casella[i][j][2] != 0) )
      {
//        image(curIMG, casella[i][j][0], casella[i][j][1]);
        if ((showMove) && (casella[i][j][3] == 1))
        {
          ellipse(casella[i][j][0], casella[i][j][1],49,49);
        }
        image(curIMG, casella[i][j][0], casella[i][j][1]);

      }
    }
  }

  // if picked piece then draw it
  if (pick)
  {
    image(curIMG, mouseX, mouseY);
    //text(figure[pos[pieceIDX][2]],mouseX,mouseY);
  }

  // last move highlight (red quads)
//  noFill();
//  stroke(255,0,0);
//  rectMode(CENTER);
//  rect(lastMoveX,lastMoveY, 10,10);

//  DEBUGGING CODE
//  textFont(infoFont);
//  for (i=0;i<dim;i++)
//  {
//    for (j=0;j<dim;j++)
//    {
//      if (casella[i][j][2] != -1)
//      {
//        fill(255,0,0);
//        text(casella[i][j][2]+" / "+casella[i][j][3],casella[i][j][0],casella[i][j][1]-2);
//        fill(0);
//        text(casella[i][j][0]+"-"+casella[i][j][1],casella[i][j][0],casella[i][j][1]+24);
//        text(i+"-"+j,casella[i][j][0],casella[i][j][1]-16);
////        fill(0,0,255);
//        stroke(255,255,0);
//        rectMode(CORNER);
////        rect(casella[i][j][0],casella[i][j][1],1,1);
//        noStroke();
//        fill(0,0,0);
//        ellipse(casella[i][j][0],casella[i][j][1],1,1);
//      }
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
    text("PEG SOLITAIRE by cameyo", width/2, height/2-80);
    text("The english peg solitaire.", width/2, height/2-60);
    textAlign(LEFT);
    text("Click to select a piece and...", width/2-110, height/2-40);
    text("...click to release (autocenter).", width/2-110, height/2-26);
    text("[N] key: start new game", width/2-110, height/2-7);
    text("[0..9] key: variation game", width/2-110, height/2+8);
    text("[U] key: undo last move", width/2-110, height/2+23);
    text("[M] key: show legal moves", width/2-110, height/2+38);
    text("[F] key: change type of figures", width/2-110, height/2+53);
    text("[S] key: save window", width/2-110, height/2+68);
    text("[I] key: show/hide info", width/2-110, height/2+83);
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
    back=0;
    startPosition();
    makeMoveList();
  }

  // change type of figures
  if (key=='f' || key=='F')
  {
    FF = !(FF);
    if (FF) { curIMG=pieceA_IMG; }
    else    { curIMG=pieceB_IMG; }
  }

  // show info window
  if (key=='i' || key=='I')
  {
    showInfo = !(showInfo);
  }

  // show legal move
  if (key=='m' || key=='M')
  {
    showMove = !(showMove);
  }

  // save image window
  if (key=='s' || key=='S')
  {
    saveFrame("s" + timestamp() + ".png");
  }

  // undo move
  if (key=='u' || key=='U')
  {
    if (!pick)
    {
      doUndo();
    }
  }

  if (key=='0')
  {
    pick=false;
    back=0;
    startPosition();
    classic00();
    makeMoveList();
  }

  if (key=='1')
  {
    pick=false;
    back=0;
    startPosition();
    classic01();
    makeMoveList();
  }

  if (key=='2')
  {
    pick=false;
    back=0;
    startPosition();
    classic02();
    makeMoveList();
  }

  if (key=='3')
  {
    pick=false;
    back=0;
    startPosition();
    classic03();
    makeMoveList();
  }

  if (key=='4')
  {
    pick=false;
    back=0;
    startPosition();
    classic04();
    makeMoveList();
  }

  if (key=='5')
  {
    pick=false;
    back=0;
    startPosition();
    classic05();
    makeMoveList();
  }
  if (key=='6')
  {
    pick=false;
    back=0;
    startPosition();
    classic06();
    makeMoveList();
  }
  if (key=='7')
  {
    pick=false;
    back=0;
    startPosition();
    classic07();
    makeMoveList();
  }
  if (key=='8')
  {
    pick=false;
    back=0;
    startPosition();
    classic08();
    makeMoveList();
  }
  if (key=='9')
  {
    pick=false;
    back=0;
    startPosition();
    classic09();
    makeMoveList();
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
    centerPiece();
    pick=false;
    // create move list
    makeMoveList();
  }
  else // first pick -> search pieces
  {
    // backup position
    doBackup();
    //check if clicked on a free piece
    for (i=0;i<dim;i++)
    {
      for (j=0;j<dim;j++)
      {
        if (casella[i][j][3]==1) //casella con un pezzo che si puo muovere
        {
          if ((mouseX > casella[i][j][0]-snap) && (mouseX < casella[i][j][0]+snap) && (mouseY > casella[i][j][1]-snap) && (mouseY < casella[i][j][1]+snap))
          {
            // piece selected
            //println("selected");

            sel=1;
            i_idx=i;
            j_idx=j;
            x_idx=casella[i][j][0];
            y_idx=casella[i][j][1];
            // reset X and Y coords (move piece coords outside window)
//            casella[i][j][0] = -100;
//            casella[i][j][1] = -100;
            // reset selected casella
            casella[i][j][2] = 0; // casella vuota;
            pick = true;
            //println(i+"-"+j+"-"+x_idx+"-"+y_idx+"-"+casella[i][j][2]);
            break;
          }
        }
      }
    }
    if (pick==false) { back--; }
  }

  if (sel==-1)  { pick=false; }
  // println(pick);

  // create move list
//  makeMoveList();

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
      // check if mouse over free pieces
      for (i=0;i<dim;i++)
      {
        for (j=0;j<dim;j++)
        {
          if (casella[i][j][3]==1) //casella con un pezzo che si puo muovere
          {
            if ((mouseX > casella[i][j][0]-snap) && (mouseX < casella[i][j][0]+snap) && (mouseY > casella[i][j][1]-snap) && (mouseY < casella[i][j][1]+snap))
            {
              cursor(HAND);
            }
          }
        }
      }
    }
    // check mouse over info button
    if ((mouseX > width-18) && (mouseX < width) && (mouseY > 0) && (mouseY < 18))
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
  image(infoIMG,659,9);
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
  int ii=-1,jj=-1;

  // place piece within chessboard
  if ((mouseX > 88) && (mouseX < 580) && (mouseY > 88) && (mouseY < 580))
  {
    // search the nearest free/possible square (crosspoint)
    for (i=0;i<dim;i++)
    {
      for (j=0;j<dim;j++)
      {
        dd = dist(mouseX, mouseY, casella[i][j][0], casella[i][j][1]);
        if ((dd < minDist) && (casella[i][j][2]==0))
        {
          minDist=dd;
          ii=i;
          jj=j;
          //println("vicino= "+ii+"-"+jj);
        }
      }
    }
    if ((ii==i_idx) && (jj==j_idx)) //pezzo rimesso nella casa di partenza
    {
      //println("partenza");
      casella[i_idx][j_idx][0] = x_idx;  // restore x coord of square
      casella[i_idx][j_idx][1] = y_idx;  // restore y coord of square
      casella[i_idx][j_idx][2] = 1; //casella piena
      back--;
    }
    else //pezzo messo in una casella libera
    {
      // mossa possibile?
      if ( ((i_idx+2==ii) && (j_idx==jj)) || ((i_idx-2==ii) && (j_idx==jj)) || ((j_idx+2==jj) && (i_idx==ii)) || ((j_idx-2==jj) && (i_idx==ii)) )
      {
        //tolgo il pezzo dalla casa di partenza
        casella[i_idx][j_idx][0] = x_idx; // restore x coord of square
        casella[i_idx][j_idx][1] = y_idx; // restore y coord of square
        casella[i_idx][j_idx][2] = 0;  //casella di partenza vuota
        casella[i_idx][j_idx][3] = -1; //pezzo di partenza bloccato
        //tolgo il pezzo saltato
        casella[(i_idx+ii)/2][(j_idx+jj)/2][2] = 0;  //casella saltata vuota
        casella[(i_idx+ii)/2][(j_idx+jj)/2][3] = -1; //pezzo saltato bloccato
        //aggiumgo il pezzo nella casella di arrivo
        casella[ii][jj][2] = 1;  //casella di arrivo piena
        casella[ii][jj][3] = 1; //pezzo arrivo libero
      }
      else  // rimetto il pezzo nella casa di partenza
      {
        //println("casella di arrivo errata");
        casella[i_idx][j_idx][0] = x_idx; // restore x coord of square
        casella[i_idx][j_idx][1] = y_idx; // restore y coord of square
        casella[i_idx][j_idx][2] = 1;  //casella di partenza piena
        back--;
      }
    }
  }
  else // rimetto il pezzo nella casa di partenza
  {
    //println("clikkato fuori");
    casella[i_idx][j_idx][0] = x_idx; // restore x coord of square
    casella[i_idx][j_idx][1] = y_idx; // restore y coord of square
    casella[i_idx][j_idx][2] = 1;  //casella di partenza piena
    back--;
  }

  lastMoveX=casella[i_idx][j_idx][0];
  lastMoveY=casella[i_idx][j_idx][1];

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
  icon.rect(3, 3, 10, 10);
  icon.noStroke();
  icon.fill(0);
  icon.ellipse(6,6,3,3);
  icon.ellipse(10,10,3,3);
  icon.rect(9,5,3,3);
  icon.rect(5,9,3,3);

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

