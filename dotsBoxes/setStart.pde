// *********************************
// Setting starting values FUNCTION
// *********************************

void setStartValues()
{
  int  sX, sY;

  // points (pox)
  sX=baseX;
  sY=baseY;  
  for(i=0;i<5;i++)
  {
    for(j=0;j<5;j++)
    {
      pox[i][j][0]=sX+(j*60);
      pox[i][j][1]=sY+(i*60);
      pox[i][j][2]=0;
    }  
  }
  
  // lines horizontal (lixH)
  sX = baseX+30;
  sY = baseY;  
  for(i=0;i<5;i++)
  {
    for(j=0;j<4;j++)
    {
      lixH[i][j][0]=sX+(j*60);
      lixH[i][j][1]=sY+(i*60);
      lixH[i][j][2]=0;
    }  
  }  
  
  // lines vertical (lixV)
  sX = baseX;
  sY = baseY+30;  
  for(i=0;i<4;i++)
  {
    for(j=0;j<5;j++)
    {
      lixV[i][j][0]=sX+(j*60);
      lixV[i][j][1]=sY+(i*60);
      lixV[i][j][2]=0;
    }
  }    
  
  // quads (qux)
  sX = baseX+30;
  sY = baseY+30;  
  for(i=0;i<4;i++)
  {
    for(j=0;j<4;j++)
    {
      qux[i][j][0]=sX+(j*60);
      qux[i][j][1]=sY+(i*60);
      qux[i][j][2]=0;
    }
  }    

  // backup position
  backupPosition();
}

