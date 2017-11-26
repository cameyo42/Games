// ************************
// startPosition FUNCTION
// ************************

void startPosition()
{
  // WHITE pieces    
  for(i=0;i<12;i++)
  {
    pos[i][0]=center[i+20][0];
    pos[i][1]=center[i+20][1];    
    pos[i][2]=0;
  }
  // BLACK pieces    
  for(i=12;i<numPieces;i++)
  {
    pos[i][0]=center[i-12][0];
    pos[i][1]=center[i-12][1];
    pos[i][2]=1;
//    println(i+"-"+center[i-12][0]+"-"+center[i-12][1]);
//    println(i+"-"+pos[i][0]+"-"+pos[i][1]);    
  }

}

// ************************
// loadCenter FUNCTION
// ************************
void loadCenter()
{
  k=0;
  int startX;
  // write center coords from upper left square (row1, row2,..,row8)
  for(i=0;i<8;i++)
  {
    for(j=0;j<4;j++)
    { 
      if (i%2==0) {startX=178;}
      else {startX=117;}
      center[k][0]=startX+(j*124);
      center[k][1]=117+(i*62);
      k++;
    }
  }
}

