//*********************************
// Computer Move CLOCKWISE
//*********************************
void clockwise()
{
    // CLOCKWISE MOVEMENTS
    // calculate NEXT move
    // if previous move was DESTRA then test collision with same direction:
    // - not collision -> continue with DESTRA
    // - collision -> continue with SOTTO
    if (compdir=="DESTRA")
    {
      compx=compx+moto;
      if (get(compx+moto, compy)!= boardCol)
      {
        compdir="SOTTO";
      }
    }
    // if previous move was SINISTRA...    
    else if (compdir=="SINISTRA")
    {
      compx=compx-moto;
      if (get(compx-moto, compy)!= boardCol)
      {
        compdir="SOPRA";
      }
    }
    // if previous move was SOPRA...        
    else if (compdir=="SOPRA")
    {
      compy=compy-moto;
      if (get(compx, compy-moto)!= boardCol)
      {
        compdir="DESTRA";
      }
    }
    // if previous move was SOTTO...        
    else if (compdir=="SOTTO")
    {
      compy=compy+moto;
      if (get(compx, compy+moto)!= boardCol)
      {
        compdir="SINISTRA";
      }
    }
}

//*********************************
// Computer Move ANTICLOCKWISE
//*********************************
void anticlockwise()
{
    // ANTICLOCKWISE MOVEMENTS
    // calculate NEXT move
    // if previous move was DESTRA then test collision with same direction:
    // - not collision -> continue with DESTRA
    // - collision -> continue with SOPRA
    if (compdir=="DESTRA")
    {
      compx=compx+moto;
      if (get(compx+moto, compy)!= boardCol)
      {
        compdir="SOPRA";
      }
    }
    // if previous move was SINISTRA...    
    else if (compdir=="SINISTRA")
    {
      compx=compx-moto;
      if (get(compx-moto, compy)!= boardCol)
      {
        compdir="SOTTO";
      }
    }
    // if previous move was SOPRA...        
    else if (compdir=="SOPRA")
    {
      compy=compy-moto;
      if (get(compx, compy-moto)!= boardCol)
      {
        compdir="SINISTRA";
      }
    }
    // if previous move was SOTTO...        
    else if (compdir=="SOTTO")
    {
      compy=compy+moto;
      if (get(compx, compy+moto)!= boardCol)
      {
        compdir="DESTRA";
      }
    }
}
