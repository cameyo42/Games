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
  for(i=0;i<21;i++)
  {
    pos[i][0]=88;
    pos[i][1]=44;
    pos[i][2]=0;
  }
  // BLACK pieces    
  for(i=21;i<numPieces;i++)
  {
    pos[i][0]=580;
    pos[i][1]=44;
    pos[i][2]=1;
  }
  
}


void loadCenter()
{
  k=0;
  // write center coords from upper left square (row1, row2,..,row8)
  for(i=0;i<6;i++)
  {
    for(j=0;j<7;j++)
    {
      center[k][0]=baseX+50+(j*72);
      center[k][1]=baseY+121+(i*72);
      k++;
    }
  }
}

