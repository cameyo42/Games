// ************************
// startPosition FUNCTIONS
// ************************

void startPosition()
{
  int sp=60;
  int sX=96,sY=634;

  // WHITE pieces    
  for(i=0;i<9;i++)
  {
    pos[i][0]=sX+(i*sp);
    pos[i][1]=sY;
    pos[i][2]=0;
  }
  // BLACK pieces    
  sY=34;
  for(i=9;i<numPieces;i++)
  {
    pos[i][0]=sX+(i-9)*sp;
    pos[i][1]=sY;
    pos[i][2]=1;
  }
  
//  pos[0][0]=100; pos[0][1]=635; pos[0][2]=0;
//  pos[1][0]=140; pos[1][1]=570; pos[1][2]=0;
//  pos[2][0]=180; pos[2][1]=570; pos[2][2]=0;
//  pos[3][0]=220; pos[3][1]=570; pos[3][2]=0;
//  pos[4][0]=260; pos[4][1]=570; pos[4][2]=0;
//  pos[5][0]=300; pos[5][1]=570; pos[5][2]=0;
//  pos[6][0]=340; pos[6][1]=570; pos[6][2]=0;
//  pos[7][0]=380; pos[7][1]=570; pos[7][2]=0;
//  pos[8][0]=420; pos[8][1]=570; pos[8][2]=0;  
  
  // BLACK pieces
//  pos[9][0]=100;  pos[9][1]=100;  pos[9][2]=1;
//  pos[10][0]=140; pos[10][1]=100; pos[10][2]=1;
//  pos[11][0]=180; pos[11][1]=100; pos[11][2]=1;
//  pos[12][0]=220; pos[12][1]=100; pos[12][2]=1;
//  pos[13][0]=260; pos[13][1]=100; pos[13][2]=1;
//  pos[14][0]=300; pos[14][1]=100; pos[14][2]=1;
//  pos[15][0]=340; pos[15][1]=100; pos[15][2]=1;
//  pos[16][0]=380; pos[16][1]=100; pos[16][2]=1;
//  pos[17][0]=420; pos[17][1]=100; pos[17][2]=1;
}


void loadCenter()
{
  center[0][0]=149; center[0][1]=149;
  center[1][0]=334; center[1][1]=149;
  center[2][0]=518; center[2][1]=149;
  
  center[3][0]=211; center[3][1]=211;
  center[4][0]=334; center[4][1]=211;
  center[5][0]=457; center[5][1]=211;
  
  center[6][0]=273; center[6][1]=273;
  center[7][0]=334; center[7][1]=273;
  center[8][0]=395; center[8][1]=273;  
  
  center[9][0]=149;  center[9][1]=334; 
  center[10][0]=211; center[10][1]=334;
  center[11][0]=273; center[11][1]=334;
  center[12][0]=395; center[12][1]=334;
  center[13][0]=457; center[13][1]=334;
  center[14][0]=518; center[14][1]=334;
  
  center[15][0]=273; center[15][1]=395;
  center[16][0]=334; center[16][1]=395;
  center[17][0]=395; center[17][1]=395;
  
  center[18][0]=211; center[18][1]=457;
  center[19][0]=334; center[19][1]=457;
  center[20][0]=457; center[20][1]=457;
                           
  center[21][0]=149; center[21][1]=519;
  center[22][0]=334; center[22][1]=519;
  center[23][0]=519; center[23][1]=519;    
}

