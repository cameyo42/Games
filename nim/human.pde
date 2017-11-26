//******************
// capture (human)
//******************
void capture()
{
    int lineaH=-1;
    //println("capture...");
    for (i=0;i<numPoints;i++)
    {
      if (punti[i][2]==1)
      {
        if (pointInsideMarquee(punti[i][0],punti[i][1]))
        {
          punti[i][2]=-1; //captured (possible)
          lineaH=punti[i][1]; // linea di cattura (orizzontale)
        }  
      }
    }

    // check correct capture (only horizontal capture)
    boolean correct = true;
    for (i=0;i<numPoints;i++)
    { 
      if (punti[i][2] == -1)
      {
        if (punti[i][1] != lineaH) { correct=false; }
      }  
    }    

    // update points array with capture
    numCaptured=0;
    k=0;
    for (i=0;i<numPoints;i++)
    { 
      if ((punti[i][2] == -1) && (correct==true))
      {
        punti[i][2] = 0; //truly captured;
        numCaptured++;
        captured[k]=i;
        k++;
      }
      else
      {
        if (punti[i][2] == -1)
        {        
          punti[i][2] = 1; //not captured;
        }
      }
    }

    //mustCapture=false;      
    //println("captured = " + numCaptured);
    //print("List of captured: ");
//    for(i=0;i<numCaptured;i++)
//    {
//      print(captured[i]+" - ");
//    }
//    println(" ");

    // if captured was succesfull update values
    if (numCaptured > 0)
    {
      if (lineaH == punti[0][1]  )
      {
        righe[0]=righe[0]-numCaptured;
      }
      if (lineaH == punti[1][1] )
      {
        righe[1]=righe[1]-numCaptured;
      }
      if (lineaH == punti[4][1])
      {
        righe[2]=righe[2]-numCaptured;
      }
      if (lineaH == punti[9][1])
      {
        righe[3]=righe[3]-numCaptured;
      }
      
      // update number of active points
      curPoints=curPoints-numCaptured;
      
      // switch player
      switchPlayer("human");
      
      // computer turn
      if (computer==true) { computerTurn=true; }
      
      // calculate position value
      // XOR the number of points on rows
//      posValue = righe[0];  
//      for(i=1;i<numRows;i++)
//      {
//        posValue=posValue ^ righe[i];
//      }  
//      println("eval: "+ posValue);      
      
    }
    
    // status of RIGHE
    //println("RIGHE");
    //for(i=0;i<numRows;i++)
    //{
      //print(righe[i]+" - ");
    //}  
    //println("");

    //println("POINTS: " + curPoints);          

    posValue = righe[0];  
    for(i=1;i<numRows;i++)
    {
      posValue=posValue ^ righe[i];
    }  
    //println("eval: "+ posValue);      
    
    //reset value
    numCaptured=0;

    // disable capturing
    mustCapture=false;
    
}  


//***********************
// points inside marquee
//***********************
boolean pointInsideMarquee(int x, int y)
{
  boolean dentro = false;
  
  if ((x > bX) && (x < eX) && (y > bY) && (y < eY))
  {
    dentro=true;
  }
  
  return(dentro);
}  

