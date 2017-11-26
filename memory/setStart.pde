// ************************
// startPosition FUNCTION
// ************************
void startPosition()
{
  int sp=6;
  int sX=80,sY=80;

  // cards position  
  k = 0;  
  for(i=0;i<numRows;i++)
  {
    for(j=0;j<numColumns;j++)    
    {
//      pos[i][j][0]=baseX+sp+(j*sX);
//      pos[i][j][1]=baseY+sp+(i*sY);
      pos[i][j][0]=baseX+(j)*(sp+sX);
      pos[i][j][1]=baseY+(i)*(sp+sY);
      pos[i][j][2]=0;
      pos[i][j][3]=k;    
      k++;
    }
  }
}

// ************************
// shuffle FUNCTION
// ************************
void shuffle()
{
  int p, temp=0;
  
  for(i=0; i < 40; i++)
  {
    num[i] = i;
    print(num[i] + "-");          
  }
  println("");

  // random permutation  
  for(i=0; i < numCards; i++)
  {
    p = int(random(i,numCards));
    temp = num[i];
    num[i] = num[p];
    num[p] = temp;
  }  

  // print random permutation  
  for(i=0; i < numCards; i++)
    print(num[i] + "-");  
  println("");
  
  // assign random values to array of cards
  int val=-1;
  k=0;
  for(i=0; i < numRows; i++)
  {
    for(j=0; j < numColumns; j++)
    {    
      if (num[k] > numCards/2 - 1) { val = num[k] - numCards/2; }
      else { val = num[k]; }
      pos[i][j][3] = val;
      k++;
    }   
  }
}  

// ************************
// loadCards FUNCTION
// ************************
void loadCards()
{  
  // first deck (cards)
  figure[0] = loadImage("figA00.png");
  figure[1] = loadImage("figA01.png");
  figure[2] = loadImage("figA02.png");
  figure[3] = loadImage("figA03.png");
  figure[4] = loadImage("figA04.png");
  figure[5] = loadImage("figA05.png");
  figure[6] = loadImage("figA06.png");
  figure[7] = loadImage("figA07.png");
  figure[8] = loadImage("figA08.png");
  figure[9] = loadImage("figA09.png");
  figure[10] = loadImage("figA10.png");
  figure[11] = loadImage("figA11.png");
  figure[12] = loadImage("figA12.png");
  figure[13] = loadImage("figA13.png");
  figure[14] = loadImage("figA14.png");
  figure[15] = loadImage("figA15.png");
  figure[16] = loadImage("figA16.png");
  figure[17] = loadImage("figA17.png");
  figure[18] = loadImage("figA18.png");
  figure[19] = loadImage("figA19.png");
  
  // second deck (cards)
  figure2[0] = loadImage("figB00.png");
  figure2[1] = loadImage("figB01.png");
  figure2[2] = loadImage("figB02.png");
  figure2[3] = loadImage("figB03.png");
  figure2[4] = loadImage("figB04.png");
  figure2[5] = loadImage("figB05.png");
  figure2[6] = loadImage("figB06.png");
  figure2[7] = loadImage("figB07.png");
  figure2[8] = loadImage("figB08.png");
  figure2[9] = loadImage("figB09.png");
  figure2[10] = loadImage("figB10.png");
  figure2[11] = loadImage("figB11.png");
  figure2[12] = loadImage("figB12.png");
  figure2[13] = loadImage("figB13.png");
  figure2[14] = loadImage("figB14.png");
  figure2[15] = loadImage("figB15.png");
  figure2[16] = loadImage("figB16.png");
  figure2[17] = loadImage("figB17.png");
  figure2[18] = loadImage("figB18.png");
  figure2[19] = loadImage("figB19.png");  
 
  // backcards
  backCard[0] = loadImage("b00.png");
  backCard[1] = loadImage("b01.png");
  backCard[2] = loadImage("b02.png");
  backCard[3] = loadImage("b03.png");
  backCard[4] = loadImage("b04.png");  
}  

void changeCards()
{
  PImage[] temp = new PImage[20];
  FF = !(FF);
  if (FF) 
  { 
    for(i=0;i<numCards/2;i++)
    {
      temp[i] = figure2[i];
      figure2[i] = figure[i];
      figure[i] = temp[i];
    }  
  }
  else 
  { 
    for(i=0;i<numCards/2;i++)
    {    
      temp[i] = figure[i];
      figure[i] = figure2[i];
      figure2[i] = temp[i];
    }
  }
}  
   
