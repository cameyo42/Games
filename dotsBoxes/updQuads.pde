void updateQuads()
{
  makeQuad = false; 
  // vertical [4x5]
  if (lineFoundV)
  {
    // row 0
    if ( (iVL==0) && (jVL==0) ) {                 checkQuad(0,0); }
    if ( (iVL==0) && (jVL==1) ) { checkQuad(0,0); checkQuad(0,1); }
    if ( (iVL==0) && (jVL==2) ) { checkQuad(0,1); checkQuad(0,2); }
    if ( (iVL==0) && (jVL==3) ) { checkQuad(0,2); checkQuad(0,3); }
    if ( (iVL==0) && (jVL==4) ) { checkQuad(0,3); }
    
    // row 1
    if ( (iVL==1) && (jVL==0) ) {                 checkQuad(1,0); }
    if ( (iVL==1) && (jVL==1) ) { checkQuad(1,0); checkQuad(1,1); }
    if ( (iVL==1) && (jVL==2) ) { checkQuad(1,1); checkQuad(1,2); }
    if ( (iVL==1) && (jVL==3) ) { checkQuad(1,2); checkQuad(1,3); }
    if ( (iVL==1) && (jVL==4) ) { checkQuad(1,3); }    
    
    // row 2
    if ( (iVL==2) && (jVL==0) ) {                 checkQuad(2,0); }
    if ( (iVL==2) && (jVL==1) ) { checkQuad(2,0); checkQuad(2,1); }
    if ( (iVL==2) && (jVL==2) ) { checkQuad(2,1); checkQuad(2,2); }
    if ( (iVL==2) && (jVL==3) ) { checkQuad(2,2); checkQuad(2,3); }
    if ( (iVL==2) && (jVL==4) ) { checkQuad(2,3); }        
    
    // row 3
    if ( (iVL==3) && (jVL==0) ) {                 checkQuad(3,0); }
    if ( (iVL==3) && (jVL==1) ) { checkQuad(3,0); checkQuad(3,1); }
    if ( (iVL==3) && (jVL==2) ) { checkQuad(3,1); checkQuad(3,2); }
    if ( (iVL==3) && (jVL==3) ) { checkQuad(3,2); checkQuad(3,3); }
    if ( (iVL==3) && (jVL==4) ) { checkQuad(3,3); }        
  }  
    
  // horizontall [5x4]
  if (lineFoundH)
  {
    // row 0    
    if ( (iHL==0) && (jHL==0) ) {                 checkQuad(0,0); }    
    if ( (iHL==0) && (jHL==1) ) {                 checkQuad(0,1); }    
    if ( (iHL==0) && (jHL==2) ) {                 checkQuad(0,2); }    
    if ( (iHL==0) && (jHL==3) ) {                 checkQuad(0,3); }    
    
    // row 1    
    if ( (iHL==1) && (jHL==0) ) { checkQuad(0,0); checkQuad(1,0); }    
    if ( (iHL==1) && (jHL==1) ) { checkQuad(0,1); checkQuad(1,1); }    
    if ( (iHL==1) && (jHL==2) ) { checkQuad(0,2); checkQuad(1,2); }    
    if ( (iHL==1) && (jHL==3) ) { checkQuad(0,3); checkQuad(1,3); }    
    
    //row 2
    if ( (iHL==2) && (jHL==0) ) { checkQuad(1,0); checkQuad(2,0); }    
    if ( (iHL==2) && (jHL==1) ) { checkQuad(1,1); checkQuad(2,1); }    
    if ( (iHL==2) && (jHL==2) ) { checkQuad(1,2); checkQuad(2,2); }    
    if ( (iHL==2) && (jHL==3) ) { checkQuad(1,3); checkQuad(2,3); }        
    
    //row 3
    if ( (iHL==3) && (jHL==0) ) { checkQuad(2,0); checkQuad(3,0); }    
    if ( (iHL==3) && (jHL==1) ) { checkQuad(2,1); checkQuad(3,1); }    
    if ( (iHL==3) && (jHL==2) ) { checkQuad(2,2); checkQuad(3,2); }    
    if ( (iHL==3) && (jHL==3) ) { checkQuad(2,3); checkQuad(3,3); }            
    
    //row 4
    if ( (iHL==4) && (jHL==0) ) { checkQuad(3,0); }    
    if ( (iHL==4) && (jHL==1) ) { checkQuad(3,1); }    
    if ( (iHL==4) && (jHL==2) ) { checkQuad(3,2); }    
    if ( (iHL==4) && (jHL==3) ) { checkQuad(3,3); }        
  }  
}  


void checkQuad(int I, int J)
{
  if ( (lixV[I][J][2] != 0) && (lixV[I][J+1][2] != 0) && (lixH[I][J][2] != 0) && (lixH[I+1][J][2] != 0) )
  {
    qux[I][J][2] = player;
    makeQuad = true;    
  }
}  
