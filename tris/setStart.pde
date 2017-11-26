// ************************
// startPosition FUNCTIONS
// ************************

void startPosition()
{
  int sp=118;
  int sX=96,sY=634;

  // WHITE pieces    
  for(i=0;i<5;i++)
  {
    pos[i][0]=sX+(i*sp);
    pos[i][1]=sY;
    pos[i][2]=0;
  }
  // BLACK pieces    
  sY=34;
  for(i=5;i<numPieces;i++)
  {
    pos[i][0]=sX+(i-5)*sp;
    pos[i][1]=sY;
    pos[i][2]=1;
  }
}


void loadCenter()
{
  center[0][0]=210; center[0][1]=210;
  center[1][0]=334; center[1][1]=210;
  center[2][0]=458; center[2][1]=210;
  
  center[3][0]=210; center[3][1]=334;
  center[4][0]=334; center[4][1]=334;
  center[5][0]=458; center[5][1]=334;
  
  center[6][0]=210; center[6][1]=458;
  center[7][0]=334; center[7][1]=458;
  center[8][0]=458; center[8][1]=458;  
}

