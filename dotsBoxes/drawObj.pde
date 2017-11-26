// *********************************
//  Draw objects FUNCTIONS
// *********************************

void drawPoints()
{
  noStroke();
  fill(0);
  // draw points (pox)
  for(i=0;i<5;i++)
  {
    for(j=0;j<5;j++)
    {
//      println(i+"-"+j+"-"+pox[i][j][0]+"-"+pox[i][j][1]);
      ellipse(pox[i][j][0], pox[i][j][1], 7, 7);
    }
  }
}  

void drawLinesH()
{
  rectMode(CENTER);
  noStroke();
  // lines horizontal (lixH)
  for(i=0;i<5;i++)
  {
    for(j=0;j<4;j++)
    {
      if (lixH[i][j][2] != 0)
      {
        if (lixH[i][j][2]==3)  { fill(0,0,255); }
        else  { fill(255,0,0); }
        rect(lixH[i][j][0],lixH[i][j][1],46,3);
      }
    }  
  }  
}  

void drawLinesV()
{
  rectMode(CENTER);
  noStroke();
  // lines horizontal (lixV)
  for(i=0;i<4;i++)
  {
    for(j=0;j<5;j++)
    {
      if (lixV[i][j][2] != 0)
      {
        if (lixV[i][j][2]==3)  
        { 
          fill(0,0,255); 
        }
        else  
        {
          fill(255,0,0); 
        }
        rect(lixV[i][j][0],lixV[i][j][1],3,46);                  
      }
    }  
  }  
}  

void drawQuads()
{
  rectMode(CENTER);
  noStroke();
  for(i=0;i<4;i++)
  {
    for(j=0;j<4;j++)
    {
      if (qux[i][j][2] != 0)
      {
        if (qux[i][j][2]==3)  
        { 
          fill(0,0,255,100); 
        }
        else  
        { 
          fill(255,0,0,100); 
        }
        rect(qux[i][j][0],qux[i][j][1],46,46);      
      }    
    }
  }   
}
