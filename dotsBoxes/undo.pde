// *********************************
// Backup position FUNCTION
// *********************************
void backupPosition()
{
  // backup lines horizontal (lixH)
  for(i=0;i<5;i++)
  {
    for(j=0;j<4;j++)
    {
      UlixH[i][j][2] = lixH[i][j][2];
    }  
  }  
  
  // backup lines vertical (lixV)
  for(i=0;i<4;i++)
  {
    for(j=0;j<5;j++)
    {
      UlixV[i][j][2] = lixV[i][j][2];
    }
  }    
  
  // backup quads (qux)
  for(i=0;i<4;i++)
  {
    for(j=0;j<4;j++)
    {
      Uqux[i][j][2] = qux[i][j][2];
    }
  }    

}

// *********************************
// Restore position FUNCTION
// *********************************
void restorePosition()
{
  // backup lines horizontal (lixH)
  for(i=0;i<5;i++)
  {
    for(j=0;j<4;j++)
    {
      lixH[i][j][2] = UlixH[i][j][2];
    }  
  }  
  
  // backup lines vertical (lixV)
  for(i=0;i<4;i++)
  {
    for(j=0;j<5;j++)
    {
      lixV[i][j][2] = UlixV[i][j][2];
    }
  }    
  
  // backup quads (qux)
  for(i=0;i<4;i++)
  {
    for(j=0;j<4;j++)
    {
      qux[i][j][2] = Uqux[i][j][2];
    }
  }    

}
