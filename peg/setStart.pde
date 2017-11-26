// ************************
// startPosition FUNCTION
// ************************
void startPosition()
{
  int xS=-16, yS=-16;
  // set piece coords from upper left square (0,0 - 0,1 - 0,2 - ...)
  for(i=0;i<dim;i++)
  {
    for(j=0;j<dim;j++)
    {
      casella[i][j][0]=xS+(j*70);
      casella[i][j][1]=yS+(i*70);
      casella[i][j][2]=-1;  //casella fuori scacchiera
      if ( ( ((i==4) || (i==5) || (i==6)) && ((j>1) && (j<9)) )  ||  ( ((j==4) || (j==5) || (j==6)) && ((i>1) && (i<9)) ) )
      {
        casella[i][j][2]=1; //casella piena
      }
      casella[i][j][3]=-1; //pezzo bloccato
    }
  }
  casella[5][5][2]=0; //casella centrale vuota
  casella[5][5][3]=-1; //pezzo bloccato

}
// ************************
// makeMoveList FUNCTION
// ************************
void makeMoveList()
{
  // reset casella list
  for(i=0;i<dim;i++)
  {
    for(j=0;j<dim;j++)
    {
      casella[i][j][3]=-1;
    }
  }

  // create move list
  for(i=0;i<dim;i++)
  {
    for(j=0;j<dim;j++)
    {
      if (casella[i][j][2]==1) // se casella occupata (pezzo)
      {
        // UP free?
        if ((casella[i-1][j][2]==1) && (casella[i-2][j][2]==0))
        {
          casella[i][j][3]=1; //pezzo libero
        }
        // DOWN free?
        if ((casella[i+1][j][2]==1) && (casella[i+2][j][2]==0))
        {
          casella[i][j][3]=1; //pezzo libero
        }
        // LEFT free?
        if ((casella[i][j-1][2]==1) && (casella[i][j-2][2]==0))
        {
          casella[i][j][3]=1; //pezzo libero
        }
        // RIGHT free?
        if ((casella[i][j+1][2]==1) && (casella[i][j+2][2]==0))
        {
          casella[i][j][3]=1; //pezzo libero
        }
      }
    }
  }

}

// **********************
// diamond FUNCTION
// **********************
void classic00()
{
// set classic00 position from base (startPosition)
casella[2][5][2]=0; casella[2][5][3]=-1;
casella[5][2][2]=0; casella[5][2][3]=-1;
casella[5][8][2]=0; casella[5][8][3]=-1;
casella[8][5][2]=0; casella[8][5][3]=-1;
}

void classic01()
{
// set classic01 position from base (startPosition)
casella[2][5][2]=0; casella[2][5][3]=-1;
casella[4][4][2]=0; casella[4][4][3]=-1;
casella[4][6][2]=0; casella[4][6][3]=-1;
casella[5][2][2]=0; casella[5][2][3]=-1;
casella[5][5][2]=1; casella[5][5][3]=-1;
casella[5][8][2]=0; casella[5][8][3]=-1;
casella[6][4][2]=0; casella[6][4][3]=-1;
casella[6][6][2]=0; casella[6][6][3]=-1;
casella[8][5][2]=0; casella[8][5][3]=-1;
}

void classic02()
{
// set classic02 position from base (startPosition)
casella[2][4][2]=0; casella[2][4][3]=-1;
casella[2][6][2]=0; casella[2][6][3]=-1;
casella[3][4][2]=0; casella[3][4][3]=-1;
casella[3][6][2]=0; casella[3][6][3]=-1;
casella[4][2][2]=0; casella[4][2][3]=-1;
casella[4][3][2]=0; casella[4][3][3]=-1;
casella[4][7][2]=0; casella[4][7][3]=-1;
casella[4][8][2]=0; casella[4][8][3]=-1;
casella[6][2][2]=0; casella[6][2][3]=-1;
casella[6][3][2]=0; casella[6][3][3]=-1;
casella[6][7][2]=0; casella[6][7][3]=-1;
casella[6][8][2]=0; casella[6][8][3]=-1;
casella[7][4][2]=0; casella[7][4][3]=-1;
casella[7][6][2]=0; casella[7][6][3]=-1;
casella[8][4][2]=0; casella[8][4][3]=-1;
casella[8][6][2]=0; casella[8][6][3]=-1;
}

void classic03()
{
// set classic03 position from base (startPosition)
casella[4][2][2]=0; casella[4][2][3]=-1;
casella[4][3][2]=0; casella[4][3][3]=-1;
casella[4][7][2]=0; casella[4][7][3]=-1;
casella[4][8][2]=0; casella[4][8][3]=-1;
casella[5][2][2]=0; casella[5][2][3]=-1;
casella[5][3][2]=0; casella[5][3][3]=-1;
casella[5][7][2]=0; casella[5][7][3]=-1;
casella[5][8][2]=0; casella[5][8][3]=-1;
casella[6][5][2]=0; casella[6][5][3]=-1;
casella[7][4][2]=0; casella[7][4][3]=-1;
casella[7][5][2]=0; casella[7][5][3]=-1;
casella[7][6][2]=0; casella[7][6][3]=-1;
casella[8][4][2]=0; casella[8][4][3]=-1;
casella[8][5][2]=0; casella[8][5][3]=-1;
casella[8][6][2]=0; casella[8][6][3]=-1;
}

void classic04()
{
// set classic04 position from base (startPosition)
casella[4][2][2]=0; casella[4][2][3]=-1;
casella[4][3][2]=0; casella[4][3][3]=-1;
casella[4][7][2]=0; casella[4][7][3]=-1;
casella[4][8][2]=0; casella[4][8][3]=-1;
casella[5][2][2]=0; casella[5][2][3]=-1;
casella[5][3][2]=0; casella[5][3][3]=-1;
casella[5][7][2]=0; casella[5][7][3]=-1;
casella[5][8][2]=0; casella[5][8][3]=-1;
casella[6][2][2]=0; casella[6][2][3]=-1;
casella[6][3][2]=0; casella[6][3][3]=-1;
casella[6][7][2]=0; casella[6][7][3]=-1;
casella[6][8][2]=0; casella[6][8][3]=-1;
}

void classic05()
{
// set classic05 position from base (startPosition)
casella[2][4][2]=0; casella[2][4][3]=-1;
casella[2][6][2]=0; casella[2][6][3]=-1;
casella[4][2][2]=0; casella[4][2][3]=-1;
casella[4][5][2]=0; casella[4][5][3]=-1;
casella[4][8][2]=0; casella[4][8][3]=-1;
casella[5][4][2]=0; casella[5][4][3]=-1;
casella[5][6][2]=0; casella[5][6][3]=-1;
casella[6][2][2]=0; casella[6][2][3]=-1;
casella[6][5][2]=0; casella[6][5][3]=-1;
casella[6][8][2]=0; casella[6][8][3]=-1;
casella[8][4][2]=0; casella[8][4][3]=-1;
casella[8][6][2]=0; casella[8][6][3]=-1;
}

void classic06()
{
// set classic05 position from base (startPosition)
casella[2][6][2]=0; casella[2][6][3]=-1;
casella[3][6][2]=0; casella[3][6][3]=-1;
casella[4][2][2]=0; casella[4][2][3]=-1;
casella[4][3][2]=0; casella[4][3][3]=-1;
casella[5][5][2]=1; casella[5][5][3]=-1;
casella[6][7][2]=0; casella[6][7][3]=-1;
casella[6][8][2]=0; casella[6][8][3]=-1;
casella[7][4][2]=0; casella[7][4][3]=-1;
casella[8][4][2]=0; casella[8][4][3]=-1;
}

void classic07()
{
// set classic07 position from base (startPosition)
casella[4][4][2]=0; casella[4][4][3]=-1;
casella[4][5][2]=0; casella[4][5][3]=-1;
casella[4][6][2]=0; casella[4][6][3]=-1;
casella[5][4][2]=0; casella[5][4][3]=-1;
casella[5][5][2]=1; casella[5][5][3]=-1;
casella[5][6][2]=0; casella[5][6][3]=-1;
casella[6][4][2]=0; casella[6][4][3]=-1;
casella[6][5][2]=0; casella[6][5][3]=-1;
casella[6][6][2]=0; casella[6][6][3]=-1;
}

void classic08()
{
// set classic08 position from base (startPosition)
casella[2][4][2]=0; casella[2][4][3]=-1;
casella[2][5][2]=0; casella[2][5][3]=-1;
casella[2][6][2]=0; casella[2][6][3]=-1;
casella[3][4][2]=0; casella[3][4][3]=-1;
casella[3][6][2]=0; casella[3][6][3]=-1;
casella[4][2][2]=0; casella[4][2][3]=-1;
casella[4][8][2]=0; casella[4][8][3]=-1;
casella[5][2][2]=0; casella[5][2][3]=-1;
casella[5][3][2]=0; casella[5][3][3]=-1;
casella[5][7][2]=0; casella[5][7][3]=-1;
casella[5][8][2]=0; casella[5][8][3]=-1;
casella[6][2][2]=0; casella[6][2][3]=-1;
casella[6][8][2]=0; casella[6][8][3]=-1;
casella[7][4][2]=0; casella[7][4][3]=-1;
casella[7][6][2]=0; casella[7][6][3]=-1;
casella[8][4][2]=0; casella[8][4][3]=-1;
casella[8][5][2]=0; casella[8][5][3]=-1;
casella[8][6][2]=0; casella[8][6][3]=-1;
}

void classic09()
{
// set classic09 position from base (startPosition)
casella[4][2][2]=0; casella[4][2][3]=-1;
casella[4][8][2]=0; casella[4][8][3]=-1;
casella[5][2][2]=0; casella[5][2][3]=-1;
casella[5][4][2]=0; casella[5][4][3]=-1;
casella[5][5][2]=1; casella[5][5][3]=-1;
casella[5][6][2]=0; casella[5][6][3]=-1;
casella[5][8][2]=0; casella[5][8][3]=-1;
casella[6][2][2]=0; casella[6][2][3]=-1;
casella[6][8][2]=0; casella[6][8][3]=-1;
}

// **********************
// backup FUNCTION
// **********************
void doBackup()
{
  back++;
  if (back < maxBack)
  {
    for(i=0;i<dim;i++)
    {
      for(j=0;j<dim;j++)
      {
        backup[back][i][j][2] = casella[i][j][2];
        backup[back][i][j][3] = casella[i][j][3];
      }
    }
  }
  else { back=maxBack-1; }
}

// **********************
// undo FUNCTION
// **********************
void doUndo()
{
  if (back > 0)
  {
    for(i=0;i<dim;i++)
    {
      for(j=0;j<dim;j++)
      {
        casella[i][j][2] = backup[back][i][j][2];
        casella[i][j][3] = backup[back][i][j][3];
      }
    }
    back--;
  }
  else { back=0; }
}

