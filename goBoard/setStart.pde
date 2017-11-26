// ************************
// startPosition FUNCTIONS
// ************************

void startPosition()
{
  for(i=0;i<numPieces;i++)
  {
    pos[i][0]=-200;
    pos[i][1]=-200;
    pos[i][2]=-1;    
  }
  // WHITE pieces    
  for(i=0;i<180;i++)
  {
    pos[i][0]=88;
    pos[i][1]=34;
    pos[i][2]=0;
  }
  // BLACK pieces    
  for(i=180;i<numPieces;i++)
  {
    pos[i][0]=580;
    pos[i][1]=635;
    pos[i][2]=1;
  }
  
}


void loadCenter()
{
  k=0;
  // write center coords from upper left square (row1, row2,..,row8)
  for(i=0;i<19;i++)
  {
    for(j=0;j<19;j++)
    {
      center[k][0]=baseX+22+(j*27);
      center[k][1]=baseY+22+(i*27);
      k++;
    }
  }
}

