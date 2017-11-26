//******************
// Switch Player
//******************
void switchPlayer(String s)
{
  if (curPoints !=0 )
  {
    if (s.equals("computer"))
    {
      if (player.equals("A"))
      { player="B"; }
      else { player="A"; };
    }
    else
    {
      if (player.equals("A"))
      { player="B"; }
      else { player="A"; };
    }    
  }
}  
    
//******************
// Computer Move
//******************
void computerMove()
{
  // array of possible moves
  int[][] moves = new int[4][7];
  // moves[i][j] = ee -> from row (i) remove (j+1) sticks to have eval (ee)
  
  int ee;
  int row0=righe[0];
  int row1=righe[1];
  int row2=righe[2];
  int row3=righe[3];  

//  println(righe[0]+" - " +righe[1]+" - " +righe[2]+" - " +righe[3]+" - ");

  // reset moves array
  for(i=0;i<4;i++)
  {
    for(j=0;j<7;j++)
    {
      moves[i][j]=-1; // impossible move
    }
  }  
  
 // calculate eval of current position
  ee = row0 ^ row1 ^ row2^ row3;
  //println("eval: "+ ee);  
  
  // calculate eval for each possible move from current position
  //first row moves
  row0 = righe[0];
  for (i=1; i < (righe[0]+1); i++)
  {
    row0--;
    ee = row0 ^ row1 ^ row2 ^ row3;
//    println("dalla riga 1 tolgo " + (i) + " fiammiferi (" + row0+"-"+row1+"-"+row2+"-"+row3+") - > eval: "+ ee);
    moves[0][i-1]=ee;
  }
  row0 = righe[0];

  //second row moves
  row1 = righe[1];  
  for (i=1; i < (righe[1]+1); i++)
  {
    row1 = row1 - 1;
    ee = row0 ^ row1 ^ row2 ^ row3;
//    println("dalla riga 2 tolgo " + (i) + " fiammiferi (" + row0+"-"+row1+"-"+row2+"-"+row3+") - > eval: "+ ee);
    moves[1][i-1]=ee;    
  }
  row1 = righe[1];

  //third row moves
  row2 = righe[2];  
  for (i=1; i < (righe[2]+1); i++)
  {
    row2--;
    ee = row0 ^ row1 ^ row2 ^ row3;
//    println("dalla riga 3 tolgo " + (i) + " fiammiferi (" + row0+"-"+row1+"-"+row2+"-"+row3+") - > eval: "+ ee);
    moves[2][i-1]=ee;    
  }
  row2 = righe[2];  
  
  //fourth row moves
  row3 = righe[3];    
  for (i=1; i < (righe[3]+1); i++)
  {
    row3--;
    ee = row0 ^ row1 ^ row2 ^ row3;
//    println("dalla riga 4 tolgo " + (i) + " fiammiferi (" + row0+"-"+row1+"-"+row2+"-"+row3+") - > eval: "+ ee);
    moves[3][i-1]=ee;    
  }
  row3 = righe[3];   

// select computer moves
  boolean win = false;
  rowComputer=-1;
  stickComputer=0;
  
  // search for a win move
  for(i=0;i<4;i++)
  {
    for(j=0;j<7;j++)
    {
      if (moves[i][j] != -1)
      {
        if (moves[i][j] == 0)
        {
          win = true;
          rowComputer=i;
          stickComputer=j+1;
        }  
//        println("dalla riga "+ rowComputer + " tolgo " + stickComputer +" -> eval: " + moves[i][j]) ;
      }  
    }
  }
  
  if (win==true) // wins move found
  { 
    win = false;
    //println("COMPUTER WIN: row " + (rowComputer+1) + " - stick -" + (stickComputer));
  }
  else // wins move NOT found
  {
    if (curPoints==16) // if first move
    { // remove random sticks(1,2) from random rows (with some restrictions)
      stickComputer = int(random(1,3));
  
      if (stickComputer==1)
      { rowComputer = int(random(1,4)); }
      if (stickComputer==2)
      { rowComputer = int(random(2,4)); }

    }
    else
    { // select move with min (max) eval value
      int maxEval = -1;    
      int minEval = 999;          
      for(i=0;i<4;i++)
      {
        for(j=0;j<7;j++)
        {
          if (moves[i][j] != -1) // skip impossible moves
          {
            if (moves[i][j] < minEval)            
            //if (moves[i][j] > maxEval)
            {
              minEval = moves[i][j];
              //maxEval = moves[i][j];
              rowComputer=i;
              stickComputer=j+1;
            }  
  //          println("computer riga "+ (i+1) + " tolgo " + (j+1) +" -> eval: " + moves[i][j]) ;
          }  
        }
      }
    } 
    //println("COMPUTER: row " + (rowComputer+1) + " - stick -" + (stickComputer));    
  }
 
  // find coords of selected sticks (computer move)
  int c=0;
  if (rowComputer == 0) 
  {
    punti[0][2]=-1;
  }  
  
  if (rowComputer == 1) 
  {
    c = 0;
    for(k=1;k<4;k++)
    {
      if (punti[k][2]==1) 
      {
        punti[k][2]=-1;
        c++;
      }
      if (c == stickComputer) { break; }
    }  
  }
      
  if (rowComputer == 2) 
  {
    c = 0;
    for(k=4;k<9;k++)
    {
      if (punti[k][2]==1) 
      {
        punti[k][2]=-1;
        c++;
      }
      if (c == stickComputer) { break; }
    }  
  }
      
  if (rowComputer == 3) 
  {
    c = 0;
    for(k=9;k<16;k++)
    {
      if (punti[k][2]==1) 
      {
        punti[k][2]=-1;
        c++;
      }
      if (c == stickComputer) { break; }
    }  
  }
  
}

//******************
// show best move
//******************
void evalMove()
{
  // array of possible moves
  int[][] moves = new int[4][7];
  // moves[i][j] = ee -> from row (i) remove (j+1) sticks to have eval (ee)
  
  int ee;
  int row0=righe[0];
  int row1=righe[1];
  int row2=righe[2];
  int row3=righe[3];  

//  println(righe[0]+" - " +righe[1]+" - " +righe[2]+" - " +righe[3]+" - ");

  // reset moves array
  for(i=0;i<4;i++)
  {
    for(j=0;j<7;j++)
    {
      moves[i][j]=-1; // impossible move
    }
  }  
  
 // calculate eval of current position
  ee = row0 ^ row1 ^ row2^ row3;
  //println("eval: "+ ee);  
  
  // calculate eval for each possible move from current position
  //first row moves
  row0 = righe[0];
  for (i=1; i < (righe[0]+1); i++)
  {
    row0--;
    ee = row0 ^ row1 ^ row2 ^ row3;
//    println("dalla riga 1 tolgo " + (i) + " fiammiferi (" + row0+"-"+row1+"-"+row2+"-"+row3+") - > eval: "+ ee);
    moves[0][i-1]=ee;
  }
  row0 = righe[0];

  //second row moves
  row1 = righe[1];  
  for (i=1; i < (righe[1]+1); i++)
  {
    row1 = row1 - 1;
    ee = row0 ^ row1 ^ row2 ^ row3;
//    println("dalla riga 2 tolgo " + (i) + " fiammiferi (" + row0+"-"+row1+"-"+row2+"-"+row3+") - > eval: "+ ee);
    moves[1][i-1]=ee;    
  }
  row1 = righe[1];

  //third row moves
  row2 = righe[2];  
  for (i=1; i < (righe[2]+1); i++)
  {
    row2--;
    ee = row0 ^ row1 ^ row2 ^ row3;
//    println("dalla riga 3 tolgo " + (i) + " fiammiferi (" + row0+"-"+row1+"-"+row2+"-"+row3+") - > eval: "+ ee);
    moves[2][i-1]=ee;    
  }
  row2 = righe[2];  
  
  //fourth row moves
  row3 = righe[3];    
  for (i=1; i < (righe[3]+1); i++)
  {
    row3--;
    ee = row0 ^ row1 ^ row2 ^ row3;
//    println("dalla riga 4 tolgo " + (i) + " fiammiferi (" + row0+"-"+row1+"-"+row2+"-"+row3+") - > eval: "+ ee);
    moves[3][i-1]=ee;    
  }
  row3 = righe[3];   

// select computer moves
  boolean win = false;
  rowComputer=-1;
  stickComputer=0;
  
  // search for a win move
  for(i=0;i<4;i++)
  {
    for(j=0;j<7;j++)
    {
      if (moves[i][j] != -1)
      {
        if (moves[i][j] == 0)
        {
          win = true;
          rowComputer=i;
          stickComputer=j+1;
        }  
//        println("dalla riga "+ (i+1) + " tolgo " + (j+1) +" -> eval: " + moves[i][j]) ;
      }  
    }
  }
  
  if (win==true) // wins move found
  { 
    win = false;
    fill(255);
    text((rowComputer+1)+"."+ stickComputer,382,438);
    //println("WIN: from row " + (rowComputer+1) + " remove "+ (stickComputer) + " stick(s)" );    
    
  }
  else // wins move NOT found
  {
    fill(0);
    text("0.0",382,438);
    //println("LOSE: from row " + (rowComputer+1) + " remove "+ (stickComputer) + " stick(s)" );    
  }
}

