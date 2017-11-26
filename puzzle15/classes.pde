//******************************************
// Board class
//******************************************
class Board
{
  // Variables
  boolean init;
  
  // Constructor
  Board()
  {
    game = new Play();
    init = true;
    game.shuffle();
  }
  
  // Show game board
  void showGame()
  {
    
    if( init == true )
    {
      init = false;
      newBoard.drawBack();
    }
    
    // show pieces
    game.showPieces();

    // if the puzzle is not solved, allow the pieces to move.
    if( game.checkSolved()==false)
    {
      for(int i=0; i<16; i++)
      {
        if( mousePressed==true && game.checkMouse(i)==true )
        {
          game.movePiece(i);
        }  
      } 
    }
  }

  // Draw back image
  void drawBack()
  {
    image(backIMG,width/2,height/2);
  }
}


//******************************************
// Puzzle class
//******************************************
class Puzzle
{
  // Variables
  int value, xpos, ypos, w, h;
  color col;
 
 // Constructor
 Puzzle(int val, int xval, int yval, int wide, int high, color c)
 {
   value = val;
   xpos = xval;
   ypos = yval;
   col = c;
   w = wide;
   h = high;
 }
  
 // Give the piece a new position
 void storePos(int xval, int yval)
 {
    xpos = xval;
    ypos = yval;
 }
  
 // Send X value of piece
 int sendX()
 {
   return xpos;
 }
  
 // Send Y value of piece
 int sendY()
 {
   return ypos;
 }
  
 //Draw pieces
 void create()
 {
   noStroke();
   fill(col);
   // draw piece
   rect(xpos,ypos,w,h);
   // draw piece number
   fill(186,179,151);
   if ((value+1) != 16) { text(value+1, xpos, ypos+10); }
   // draw small rect arond piece number
   if ((value+1) != 16) { noFill(); stroke(186,179,151,80); rect(xpos,ypos,w-36,h-36); }   
 }
}


//******************************************
// Play class
//******************************************
class Play
{
  // Variables
  Puzzle[] pieces = new Puzzle[16];
  // Color of pieces
  color[] cVal = {color(0), color(10), color(20), color(30), color(40), color(50), color(60), color(70), color(80), color(90), color(100), color(110), color(120), color(130), color(140), color(186,179,151)};
  // Piece solved
  boolean[] numSolved = {false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false};
  // shuffle location
  int[] location = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  // Pieces X coord
  int[] locX = {100, 175, 250, 325, 100, 175, 250, 325, 100, 175, 250, 325, 100, 175, 250, 325};
  // Pieces Y coord  
  int[] locY = {100, 100, 100, 100, 175, 175, 175, 175, 250, 250, 250, 250, 325, 325, 325, 325};  
  // Snap distance to move piece
  int snap = 32;  
  int i, k, o, tempX, tempY;

  
  // Constructor
  Play()
  {
    // Set up new puzzle
    for(i=0; i<16; i++)
    {
      pieces[i] = new Puzzle(i, locX[i], locY[i], 72, 72, cVal[i]);
      pieces[i].create();
    }
  }
  
  // shuffle pieces locations
  void shuffle()
  {
    // set pieces at solution places (1,2,..,15)
    for(i=0; i<16; i++)
    {
      location[i] = 1;
    }
    // create pieces
    for(i=0; i<16; i++)
    {
      pieces[i].create();
      //println(i +" - "+ locX[i]+" - "+locY[i]);
    }
    
    // move pieces at random (15*15*15 times)
    // to retain the game solvable
    int i,c;
    c=0;
    while (c < 15*15*15)
    {    
      i = (int) random(0,16);
      game.movePiece(i);
      //println(i);
      c++;
    }    
  }
  
  // Move a piece
  void movePiece(int i)
  {
    if ( checkMove(pieces[15].sendX(), pieces[15].sendY(), pieces[i].sendX(), pieces[i].sendY()) )
    {
          tempX = pieces[15].sendX();
          tempY = pieces[15].sendY();
          pieces[15].storePos(pieces[i].sendX(), pieces[i].sendY());
          pieces[i].storePos(tempX, tempY);
          pieces[15].create();
          pieces[i].create();
    }
  }
  
  // Check if current the puzzle is solved
  boolean checkSolved()
  {
    int k=0;
    for(int i=0; i<16; i++)
    {
      if( pieces[i].sendX()==locX[i] && pieces[i].sendY()==locY[i] )
      {
        numSolved[i]=true;
        k++;
      }
    }
    if(k==16)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  // Check if a piece can move
  boolean checkMove(int x15, int y15, int xi, int yi)
  {
    if( xi==x15 && ( (yi-75)==y15 || (yi+75==y15) ) )
    {
      return true;
    }
    else if( yi==y15 && ( (xi-75)==x15 || (xi+75==x15) ) )
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  // Check if the cursor is over a piece
  boolean checkMouse(int i)
  {
    //if(mouseX>=pieces[i].sendX()-24 && mouseX<=pieces[i].sendX()+24 && mouseY>=pieces[i].sendY()-24 && mouseY<=pieces[i].sendY()+24 && cVal[i]!=color(255,255,255))
    if(mouseX>=pieces[i].sendX()-snap && mouseX<=pieces[i].sendX()+snap && mouseY>=pieces[i].sendY()-snap && mouseY<=pieces[i].sendY()+snap)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  // Show Pieces
  void showPieces()
  {
    for(i=0; i<16; i++)
    {
      pieces[i].create();
    }
  }

}

