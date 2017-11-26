//**************************
// Board class
//**************************
class Casella
{
  int id; // IDentifier of casella  
  int x,y; // index of casella
  int caSize; // size of casella  
  int flower = 0; // 0=empty, 1=fill
  boolean clicked, flagged;

  // constructor
  Casella(int id, int x, int y, int caSize)  
  {
    this.id = id;
    this.x = x;
    this.y = y;    
    this.caSize = caSize;
    strokeWeight(1);
    stroke(0);
    stroke(255);    
    fill(255);
//    rect(x, y, caSize, caSize);
    stroke(128);
    stroke(0);        
    fill(colC);
    rect(x+2, y+2, caSize-4, caSize-4);    
  }

  // aFlower() function
  void aFlower()
  {
    flower = 1;
  }

  // switchFlag() function
  void switchFlag()
  {
    if(!flagged)
    {
      flagged = true;
      int f = (int)random(0,8);
      image(fioreIMG[f],x+3,y+3);
      numFlagged++;      
    }
    else
    {
      flagged = false;
      stroke(0);
      fill(colC);
      rect(x+2, y+2, caSize-4, caSize-4);      
      numFlagged--;      
    }
  }

  // countFlowers() function
  void countFlowers()
  {
    int i,j;
    int total = 0;
  
    // count flowers around casa (8 case to check)
    for(i = y/caSize - 1; i <= y/caSize + 1; i++)
    {
      for(j = x/caSize - 1; j <= x/caSize + 1; j++)
      {
        if(i >= 0 && j >= 0 && i < dim && j < dim && !(i==x && j==y))
        {
          if(board[i][j].flower == 1)
          {
            total++;
          }
        }
      }
    }
    
    if ((!clicked) &&(!flagged))    
    {
      stroke(0);
      stroke(128);      
      fill(colU);
      //rect(x, y, caSize, caSize);
      stroke(128);
      stroke(0);      
      rect(x+2, y+2, caSize-4, caSize-4);      

      clicked = true;

      if(flower == 1)
      {
        image(zfioreIMG,x+3,y+3);
        lose=true;
      }
      else if (total != 0) // write number of flowers
      {
        fill(map(total,1,8,0,255),0,0);
        textAlign(CENTER);
        text(total, x + caSize / 2 + 1, y + caSize/2 + 8);
      }

      else // if total = 0
      {
//        println("total = " + total);
//        println("flower = " + flower);
        // count flower on other case (recursion)
        for(i = y/caSize - 1; i <= y/caSize + 1; i++)
        {
          for(j = x/caSize - 1; j <= x/caSize + 1; j++)
          {
            if(i >= 0 && j >= 0 && i < dim && j < dim && !(i==x && j==y))            
            {
              board[i][j].countFlowers();
            }
          }
        }
      }
    } //if ((!clicked) &&(!flagged))    
  } // end countFlowers
}
