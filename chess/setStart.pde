// ************************
// startPosition FUNCTIONS
// ************************

void startPositionWhite()
{
  // WHITE pieces
  // pawn
  ////text("P",baseX+48+0*62,baseY+432);
  pos[0][0]=baseX+48+0*62; pos[0][1]=baseY+432; pos[0][2]=6;
  //text("P",baseX+48+1*62,baseY+432);
  pos[1][0]=baseX+48+1*62; pos[1][1]=baseY+432; pos[1][2]=6;
  //text("P",baseX+48+2*62,baseY+432);
  pos[2][0]=baseX+48+2*62; pos[2][1]=baseY+432; pos[2][2]=6;
  //text("P",baseX+48+3*62,baseY+432);
  pos[3][0]=baseX+48+3*62; pos[3][1]=baseY+432; pos[3][2]=6;
  //text("P",baseX+48+4*62,baseY+432);
  pos[4][0]=baseX+48+4*62; pos[4][1]=baseY+432; pos[4][2]=6;
  //text("P",baseX+48+5*62,baseY+432);
  pos[5][0]=baseX+48+5*62; pos[5][1]=baseY+432; pos[5][2]=6;
  //text("P",baseX+48+6*62,baseY+432);
  pos[6][0]=baseX+48+6*62; pos[6][1]=baseY+432; pos[6][2]=6;
  //text("P",baseX+48+7*62,baseY+432);
  pos[7][0]=baseX+48+7*62; pos[7][1]=baseY+432; pos[7][2]=6;
  // figures
  //text("R",baseX+48+0*62,baseY+495);
  pos[8][0]=baseX+48+0*62; pos[8][1]=baseY+495; pos[8][2]=3;
  //text("N",baseX+48+1*62,baseY+495);
  pos[9][0]=baseX+48+1*62; pos[9][1]=baseY+495; pos[9][2]=5;
  //text("L",baseX+48+2*62,baseY+495);
  pos[10][0]=baseX+48+2*62; pos[10][1]=baseY+495; pos[10][2]=4;
  //text("Q",baseX+48+3*62,baseY+495);
  pos[11][0]=baseX+48+3*62; pos[11][1]=baseY+495; pos[11][2]=2;
  //text("K",baseX+48+4*62,baseY+495);
  pos[12][0]=baseX+48+4*62; pos[12][1]=baseY+495; pos[12][2]=1;
  //text("L",baseX+48+5*62,baseY+495);
  pos[13][0]=baseX+48+5*62; pos[13][1]=baseY+495; pos[13][2]=4;
  //text("N",baseX+48+6*62,baseY+495);
  pos[14][0]=baseX+48+6*62; pos[14][1]=baseY+495; pos[14][2]=5;
  //text("R",baseX+48+7*62,baseY+495);
  pos[15][0]=baseX+48+7*62; pos[15][1]=baseY+495; pos[15][2]=3;

  // BLACK pieces
  //pawn
  //text("P",baseX+48+0*62,baseY+123);
  pos[16][0]=baseX+48+0*62; pos[16][1]=baseY+123; pos[16][2]=6+6;
  //text("P",baseX+48+1*62,baseY+123);
  pos[17][0]=baseX+48+1*62; pos[17][1]=baseY+123; pos[17][2]=6+6;
  //text("P",baseX+48+2*62,baseY+123);
  pos[18][0]=baseX+48+2*62; pos[18][1]=baseY+123; pos[18][2]=6+6;
  //text("P",baseX+48+3*62,baseY+123);
  pos[19][0]=baseX+48+3*62; pos[19][1]=baseY+123; pos[19][2]=6+6;
  //text("P",baseX+48+4*62,baseY+123);
  pos[20][0]=baseX+48+4*62; pos[20][1]=baseY+123; pos[20][2]=6+6;
  //text("P",baseX+48+5*62,baseY+123);
  pos[21][0]=baseX+48+5*62; pos[21][1]=baseY+123; pos[21][2]=6+6;
  //text("P",baseX+48+6*62,baseY+123);
  pos[22][0]=baseX+48+6*62; pos[22][1]=baseY+123; pos[22][2]=6+6;
  //text("P",baseX+48+7*62,baseY+123);
  pos[23][0]=baseX+48+7*62; pos[23][1]=baseY+123; pos[23][2]=6+6;
  // figures
  //text("R",baseX+48+0*62,baseY+60);
  pos[24][0]=baseX+48+0*62; pos[24][1]=baseY+60; pos[24][2]=3+6;
  //text("N",baseX+48+1*62,baseY+60);
  pos[25][0]=baseX+48+1*62; pos[25][1]=baseY+60; pos[25][2]=5+6;
  //text("L",baseX+48+2*62,baseY+60);
  pos[26][0]=baseX+48+2*62; pos[26][1]=baseY+60; pos[26][2]=4+6;
  //text("Q",baseX+48+3*62,baseY+60);
  pos[27][0]=baseX+48+3*62; pos[27][1]=baseY+60; pos[27][2]=2+6;
  //text("K",baseX+48+4*62,baseY+60);
  pos[28][0]=baseX+48+4*62; pos[28][1]=baseY+60; pos[28][2]=1+6;
  //text("L",baseX+48+5*62,baseY+60);
  pos[29][0]=baseX+48+5*62; pos[29][1]=baseY+60; pos[29][2]=4+6;
  //text("N",baseX+48+6*62,baseY+60);
  pos[30][0]=baseX+48+6*62; pos[30][1]=baseY+60; pos[30][2]=5+6;
  //text("R",baseX+48+7*62,baseY+60);
  pos[31][0]=baseX+48+7*62; pos[31][1]=baseY+60; pos[31][2]=3+6;

}


void startPositionBlack()
{
  // BLACK pieces
  // pawn
  //text("P",baseX+48+0*62,baseY+432);
  pos[0][0]=baseX+48+0*62; pos[0][1]=baseY+432; pos[0][2]=6+6;
  //text("P",baseX+48+1*62,baseY+432);
  pos[1][0]=baseX+48+1*62; pos[1][1]=baseY+432; pos[1][2]=6+6;
  //text("P",baseX+48+2*62,baseY+432);
  pos[2][0]=baseX+48+2*62; pos[2][1]=baseY+432; pos[2][2]=6+6;
  //text("P",baseX+48+3*62,baseY+432);
  pos[3][0]=baseX+48+3*62; pos[3][1]=baseY+432; pos[3][2]=6+6;
  //text("P",baseX+48+4*62,baseY+432);
  pos[4][0]=baseX+48+4*62; pos[4][1]=baseY+432; pos[4][2]=6+6;
  //text("P",baseX+48+5*62,baseY+432);
  pos[5][0]=baseX+48+5*62; pos[5][1]=baseY+432; pos[5][2]=6+6;
  //text("P",baseX+48+6*62,baseY+432);
  pos[6][0]=baseX+48+6*62; pos[6][1]=baseY+432; pos[6][2]=6+6;
  //text("P",baseX+48+7*62,baseY+432);
  pos[7][0]=baseX+48+7*62; pos[7][1]=baseY+432; pos[7][2]=6+6;
  // figures
  //text("R",baseX+48+0*62,baseY+495);
  pos[8][0]=baseX+48+0*62; pos[8][1]=baseY+495; pos[8][2]=3+6;
  //text("N",baseX+48+1*62,baseY+495);
  pos[9][0]=baseX+48+1*62; pos[9][1]=baseY+495; pos[9][2]=5+6;
  //text("L",baseX+48+2*62,baseY+495);
  pos[10][0]=baseX+48+2*62; pos[10][1]=baseY+495; pos[10][2]=4+6;
  //text("K",baseX+48+3*62,baseY+495);
  pos[11][0]=baseX+48+3*62; pos[11][1]=baseY+495; pos[11][2]=1+6;
  //text("Q",baseX+48+4*62,baseY+495);
  pos[12][0]=baseX+48+4*62; pos[12][1]=baseY+495; pos[12][2]=2+6;
  //text("L",baseX+48+5*62,baseY+495);
  pos[13][0]=baseX+48+5*62; pos[13][1]=baseY+495; pos[13][2]=4+6;
  //text("N",baseX+48+6*62,baseY+495);
  pos[14][0]=baseX+48+6*62; pos[14][1]=baseY+495; pos[14][2]=5+6;
  //text("R",baseX+48+7*62,baseY+495);
  pos[15][0]=baseX+48+7*62; pos[15][1]=baseY+495; pos[15][2]=3+6;

  // WHITE pieces
  // pawns
  //text("P",baseX+48+0*62,baseY+123);
  pos[16][0]=baseX+48+0*62; pos[16][1]=baseY+123; pos[16][2]=6;
  //text("P",baseX+48+1*62,baseY+123);
  pos[17][0]=baseX+48+1*62; pos[17][1]=baseY+123; pos[17][2]=6;
  //text("P",baseX+48+2*62,baseY+123);
  pos[18][0]=baseX+48+2*62; pos[18][1]=baseY+123; pos[18][2]=6;
  //text("P",baseX+48+3*62,baseY+123);
  pos[19][0]=baseX+48+3*62; pos[19][1]=baseY+123; pos[19][2]=6;
  //text("P",baseX+48+4*62,baseY+123);
  pos[20][0]=baseX+48+4*62; pos[20][1]=baseY+123; pos[20][2]=6;
  //text("P",baseX+48+5*62,baseY+123);
  pos[21][0]=baseX+48+5*62; pos[21][1]=baseY+123; pos[21][2]=6;
  //text("P",baseX+48+6*62,baseY+123);
  pos[22][0]=baseX+48+6*62; pos[22][1]=baseY+123; pos[22][2]=6;
  //text("P",baseX+48+7*62,baseY+123);
  pos[23][0]=baseX+48+7*62; pos[23][1]=baseY+123; pos[23][2]=6;
  // figures
  //text("R",baseX+48+0*62,baseY+60);
  pos[24][0]=baseX+48+0*62; pos[24][1]=baseY+60; pos[24][2]=3;
  //text("N",baseX+48+1*62,baseY+60);
  pos[25][0]=baseX+48+1*62; pos[25][1]=baseY+60; pos[25][2]=5;
  //text("L",baseX+48+2*62,baseY+60);
  pos[26][0]=baseX+48+2*62; pos[26][1]=baseY+60; pos[26][2]=4;
  //text("K",baseX+48+3*62,baseY+60);
  pos[27][0]=baseX+48+3*62; pos[27][1]=baseY+60; pos[27][2]=1;
  //text("Q",baseX+48+4*62,baseY+60);
  pos[28][0]=baseX+48+4*62; pos[28][1]=baseY+60; pos[28][2]=2;
  //text("L",baseX+48+5*62,baseY+60);
  pos[29][0]=baseX+48+5*62; pos[29][1]=baseY+60; pos[29][2]=4;
  //text("N",baseX+48+6*62,baseY+60);
  pos[30][0]=baseX+48+6*62; pos[30][1]=baseY+60; pos[30][2]=5;
  //text("R",baseX+48+7*62,baseY+60);
  pos[31][0]=baseX+48+7*62; pos[31][1]=baseY+60; pos[31][2]=3;
}

void loadCenter()
{
  k=0;
  // write center coords from upper left square (row1, row2,..,row8)
  for(i=0;i<8;i++)
  {
    for(j=0;j<8;j++)
    {
      center[k][0]=117+(j*62);
     // 11 is the vertical offside of the font
      center[k][1]=117+(i*62)+11;
      k++;
    }
  }
}

