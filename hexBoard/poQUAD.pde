int sign(float num)
{
//  if (num == 0) { return(0); };
//  if (num < 0)  { return(-1); };
//  if (num > 0)  { return(+1); };  
//  return(2);
   return(num > 0 ? 1 : num < 0 ? -1 : 0);

}  

boolean point_in_convex_quad(float x1,float y1,float x2,float y2,float x3,float y3,float x4,float y4,float xt,float yt)
{
  float a, b, c, d;
  
  a = (x1 - xt) * (y2 - yt) - (x2 - xt) * (y1 - yt);
  b = (x2 - xt) * (y3 - yt) - (x3 - xt) * (y2 - yt);
  c = (x3 - xt) * (y4 - yt) - (x4 - xt) * (y3 - yt);
  d = (x4 - xt) * (y1 - yt) - (x1 - xt) * (y4 - yt);
  return (sign(a) == sign(b) && sign(b) == sign(c) && sign(c) == sign(d));  
}
