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
    // draw on Board

    // if the puzzle is not solved, allow the pieces to move.
    if( game.checkSolved()==false )
    {
      for(int i=0; i<9; i++)
      {
        if( mousePressed==true && game.checkMouse(i)==true )
        {
          game.movePiece(i);
        }  
      } 
    }
    
    // if the puzzle is solved, show "solved" text.
    else if( game.checkSolved()==true )
    {
      //game.shuffle();
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
   if ((value+1) != 9) { text(value+1, xpos, ypos+10); }
   // draw small rect arond piece number
   if ((value+1) != 9) { noFill(); stroke(186,179,151,80); rect(xpos,ypos,w-40,h-40); }   
 }
}


//******************************************
// Play class
//******************************************
class Play
{
  // Variables
  Puzzle[] pieces = new Puzzle[9];
  // Color of pieces
  color[] cVal = {color(0), color(20), color(40), color(60), color(80), color(100), color(120), color(140), color(186,179,151)};
  // Piece solved
  boolean[] numSolved = {false, false, false, false, false, false, false, false, false};
  // shuffle location
  int[] location = {0, 0, 0, 0, 0, 0, 0, 0, 0};
  // Pieces X coord
  int[] locX = {100, 175, 250, 100, 175, 250, 100, 175, 250};
  // Pieces Y coord  
  int[] locY = {100, 100, 100, 175, 175, 175, 250, 250, 250};  
  // Snap distance to move piece
  int snap = 32;  
  int i, k, o, tempX, tempY;

  
  // Constructor
  Play()
  {
    // Set up new puzzle
    for(i=0; i<9; i++)
    {
      pieces[i] = new Puzzle(i, locX[i], locY[i], 72, 72, cVal[i]);
      pieces[i].create();
    }
  }

  // shuffle pieces locations
  void shuffle()
  {
    // set pieces at solution places (1,2,..,8)
    for(i=0; i<9; i++)
    {
      location[i] = 1;
    }
    // create pieces
    for(i=0; i<9; i++)
    {
      pieces[i].create();
      //println(i +" - "+ locX[i]+" - "+locY[i]);
    }
    
    // move pieces at random (8*8*8 times)
    // to retain the game solvable
    int i,c;
    c=0;
    while (c < 8*8*8)
    {    
      i = (int) random(0,9);
      game.movePiece(i);
      //println(i);
      c++;
    }    
  }
  
  
  // Move a piece
  void movePiece(int i)
  {
    if ( checkMove(pieces[8].sendX(), pieces[8].sendY(), pieces[i].sendX(), pieces[i].sendY()) )
    {
          tempX = pieces[8].sendX();
          tempY = pieces[8].sendY();
          pieces[8].storePos(pieces[i].sendX(), pieces[i].sendY());
          pieces[i].storePos(tempX, tempY);
          pieces[8].create();
          pieces[i].create();
    }
  }
  
  // Check if current the puzzle is solved
  boolean checkSolved()
  {
    int k=0;
    for(int i=0; i<9; i++)
    {
      if( pieces[i].sendX()==locX[i] && pieces[i].sendY()==locY[i] )
      {
        numSolved[i]=true;
        k++;
      }
    }
    if(k==9)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  // Check if a piece can move
  boolean checkMove(int x8, int y8, int xi, int yi)
  {
    if( xi==x8 && ( (yi-75)==y8 || (yi+75==y8) ) )
    {
      return true;
    }
    else if( yi==y8 && ( (xi-75)==x8 || (xi+75==x8) ) )
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
    for(i=0; i<9; i++)
    {
      pieces[i].create();
    }
  }

}
