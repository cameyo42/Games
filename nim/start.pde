
void loadPoints()
{
  righe[0]=1;
  righe[1]=3;
  righe[2]=5;
  righe[3]=7;

  // riga 0
  punti[0][0]=baseX;  punti[0][1]=baseY;    punti[0][2]=1;

  // riga 1
  punti[1][0]=baseX-distH;     punti[1][1]=baseY+distV;     punti[1][2]=1;
  punti[2][0]=baseX;           punti[2][1]=baseY+distV;     punti[2][2]=1;
  punti[3][0]=baseX+distH;     punti[3][1]=baseY+distV;     punti[3][2]=1;

  // riga 2
  punti[4][0]=baseX-distH*2;   punti[4][1]=baseY+distV*2;   punti[4][2]=1;
  punti[5][0]=baseX-distH;     punti[5][1]=baseY+distV*2;   punti[5][2]=1;
  punti[6][0]=baseX;           punti[6][1]=baseY+distV*2;   punti[6][2]=1;
  punti[7][0]=baseX+distH;     punti[7][1]=baseY+distV*2;   punti[7][2]=1;
  punti[8][0]=baseX+distH*2;   punti[8][1]=baseY+distV*2;   punti[8][2]=1;

  // riga 3
  punti[9][0]=baseX-distH*3;   punti[9][1]=baseY+distV*3;   punti[9][2]=1;
  punti[10][0]=baseX-distH*2;  punti[10][1]=baseY+distV*3;  punti[10][2]=1;
  punti[11][0]=baseX-distH;    punti[11][1]=baseY+distV*3;  punti[11][2]=1;
  punti[12][0]=baseX;          punti[12][1]=baseY+distV*3;  punti[12][2]=1;
  punti[13][0]=baseX+distH;    punti[13][1]=baseY+distV*3;  punti[13][2]=1;
  punti[14][0]=baseX+distH*2;  punti[14][1]=baseY+distV*3;  punti[14][2]=1;
  punti[15][0]=baseX+distH*3;  punti[15][1]=baseY+distV*3;  punti[15][2]=1;


  //random point
//  for (i=0;i<10;i++)
//  {
//    punti[i][0]=int(random(20,480));
//    punti[i][1]=int(random(20,480));
//    punti[i][2]=1;
//    println(punti[i][0]+"-"+punti[i][1]);
//  }

}



