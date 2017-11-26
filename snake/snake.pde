// **************************************************
// * snake.pde
// * by cameyo 2013
// *
// * Gameboard for tris, tic-tac-toe.
// *
// * code written for Processing 1.5.1 & 2.1
// * MIT license
// **************************************************
//
//  [N] key: start new game
//  [space] key: pause game toggle
//  [S] key: save window
//  [I] key: show/hide info

import java.util.Calendar;

// ********************
// VARIABLE DECLARATION
// ********************
String TITLE = "snake";

// window info toggle
boolean showInfo;

// color of snake
//color snakeCol1=color(115,100,73);
color snakeCol1=color(0);
color snakeCol2=color(92,207,66);

// game go on...
float advance = 100;

// snake speed (framerate)
int slow = 10;
int lastBase = 2;

// snake variables
int cx, cy;
int moveX = 0;
int moveY = 0;
int snakeX = 0;
int snakeY = 0;
int foodX = -1;
int foodY = -1;
boolean check = true;
int[] snakesX;
int[] snakesY;
int snakeSize = 3;

// board dimension
int baseX = 50;
int baseY = 50;
int windowSize = 400;

// game is over
boolean gameover = false;
// pause game
boolean pause=false;
// Font
PFont gameFont;
PFont infoFont;
// Images
PImage backIMG;
PImage foodIMG;
PImage superfoodIMG;
PImage head0IMG;
PImage head1IMG;
PImage head2IMG;
PImage head3IMG;
PImage bodyIMG;
PImage tailIMG;

// direction of snake
// up=0 - right=1 - down=2 - left=3
int dir=0;

// Type of food 
// 0 = apple; 1 = apple green or lemon (superfood);
int foodType = 0; 


//******************************
// SETUP
//******************************
void setup()
{
  size(500, 500);
  // set window title
  frame.setTitle(TITLE);
  // set window icon image
  changeAppIcon();
  
  // smooth draw
  smooth();
  
  // set frame rate
  frameRate=60;
  
  // load images
  backIMG = loadImage("back.png");
  foodIMG = loadImage("food.png");  
  superfoodIMG = loadImage("superfood.png");  
  head0IMG = loadImage("head0.png");    
  head1IMG = loadImage("head1.png");    
  head2IMG = loadImage("head2.png");    
  head3IMG = loadImage("head3.png");      

  // load fonts
  gameFont = loadFont("SansSerif.bold-20.vlw");
  infoFont = loadFont("CourierNewPSMT-12.vlw");
  textFont(gameFont);  
  
  // set modes
  imageMode(CENTER);
  textAlign(CENTER);
  
  advance = 100;
  slow = 10;
  snakesX = new int[100];
  snakesY = new int[100];
 
  cx = width/2;
  cy = height/2;
  
  snakeX = cx-5;
  snakeY = cy-5;
  foodX = -1;
  foodY = -1;
  snakeSize = 3;
  
  gameover = false;
  check = true;
  
}

//******************************
// DRAW
//******************************
void draw()
{
  
  if (pause==false)
  {
    if(advance%slow == 0)
    {
      runGame();
    }
    advance++;
  }
  else 
  {
    if (gameover==false)
    {
      fill(255,128);
      stroke(0);
      rectMode(CENTER);
      rect(width/2,height/2 - 8,120,30);
      fill(0);
      text("PAUSE",width/2,height/2);      
      noLoop();
    }  
  }
  
  // draw info window
  if (showInfo)
  { 
    infoWindow();
  }  

}

//******************************
// NEW GAME
//******************************
void newGame()
{
  snakeX = cx-5;
  snakeY = cy-5;
  check = true;
  snakeSize = 3; 
  moveY = 0;
  moveX = 0;
  slow = 10;
  lastBase = 2;
  dir = 0;
  gameover = false;  
  loop();
}

//******************************
// RUN GAME
//******************************
void runGame()
{
  if(gameover== false)
  {
    // draw background image
    image(backIMG,width/2,height/2);    
    
    // update text of score (lenght of snake - 3)
    fill(255);
    text(snakeSize-3,24,64);    
    
    drawfood();
    drawSnake();
    snakeMove();
    grabFood();
    checkAutoIntersect();
//    updateSpeed();
  }
  else
  {
      fill(255,128);
      stroke(0);
      rectMode(CENTER);
      rect(width/2,height/2 - 8,150,30);
      fill(0);
      text("GAME OVER",width/2,height/2);
      text("Press 'N' to start new game",width/2,height/2+232);
      noLoop();
  }
}


//******************************
// CHECK AUTOINTERSECT
//******************************
void checkAutoIntersect()
{ if (snakeSize > 3)
  {
    for(int i = 1; i < snakeSize; i++)
    {
      if(snakeX == snakesX[i] && snakeY== snakesY[i])
      {
        gameover = true; 
      }
    }
  }  
}

//******************************
// GRAB FOOD
//******************************
void grabFood()
{
  if(foodX == snakeX && foodY == snakeY)
  {
    check = true;
    // superfood do not grow the snake lenght
    if (foodType==0) { snakeSize++; }
    updateSpeed();
  }
}

//******************************
// DRAW FOOD
//******************************
void drawfood()
{
  while(check)
  {
    foodType = 0;
    if (snakeSize > 13)
    {
      foodType = (int)random(0,10);
      // 10% probabilty of superfood after eating 10 food
      if ((foodType==9))
      {
        foodType=1;
      }
      else
      {
        foodType=0;
      }
    }  
      
    int x = (int)random(baseX/10+1,-1+(windowSize+baseX)/10);
    int y = (int)random(baseY/10+1,-1+(windowSize+baseY)/10);
    
    foodX = 5+x*10;
    foodY = 5+y*10;
    
    // check if food is over snake
    //println("x="+x+" - "+"y="+y+" - "+"foodX="+foodX+" - "+"foodY="+foodY);
    for(int i = 0; i < snakeSize; i++)
    {
      //println("snakesX["+i+"]="+snakesX[i]+" - "+"snakesY["+i+"]="+snakesY[i]);      
      if ((foodX == snakesX[i]) && (foodY == snakesY[i]))
      {
        check = true;
        //i = snakeSize;
      }
      else
      {
        check = false; 
      }
    }
  }
  
  if (foodType==0)
  {
    image(foodIMG,foodX, foodY);
  }
  else  
  {
    image(superfoodIMG,foodX, foodY);
  }  
  //rect(foodX-5, foodY-5, 10, 10);
    
}

//******************************
// DRAW SNAKE
//******************************
void drawSnake()
{
  stroke(49,121,11);
  for(int i = 0; i < snakeSize; i++) 
  {
    int X = snakesX[i];
    int Y = snakesY[i];
    noStroke();
    if(i==0)
    { 
      if (dir==0) { image(head0IMG,X,Y-6);  }
      if (dir==1) { image(head1IMG,X+6,Y);  }
      if (dir==2) { image(head2IMG,X,Y+6);  }      
      if (dir==3) { image(head3IMG,X-6,Y);  }      
    }
    else
    {
      //rect(X-5,Y-5,10,10);            
      if (i == snakeSize-1)
      {
        // esterno 
        fill(38,110,7);        
        ellipse(X,Y,9,9);
        //interno
        fill(206,232,114);      
        ellipse(X,Y,5,5);             
        //centro
        fill(44,50,25);
        ellipse(X,Y,2,2);        
      }
      else
      {
        // esterno 
        fill(38,110,7);        
        ellipse(X,Y,11,11);
        //interno
        fill(206,232,114);      
        ellipse(X,Y,7,7);             
        //centro
        fill(44,50,25);
        ellipse(X,Y,3,3);        
      }
    }
  }
  
  for(int i = snakeSize; i > 0; i--)
  {
    snakesX[i] = snakesX[i-1];
    snakesY[i] = snakesY[i-1];
  }
}

//******************************
// SNAKE MOVE
//******************************
void snakeMove()
{
  snakeX += moveX;
  snakeY += moveY;
  // check collision with borders

  if ((snakeX > windowSize+baseX) || (snakeX < baseX) || (snakeY > windowSize+baseY) || (snakeY < baseY))
  { 
     gameover = true; 
  }
  snakesX[0] = snakeX;
  snakesY[0] = snakeY;
}

//******************************
// UPDATE SPEED
//******************************
void updateSpeed()
{
  // to update speed -> update slow
  // if eat superfood -> slow = slow + 2;
  if (foodType==1)
  {
    slow = slow + 2;
  }  
  else // eat normal food
  {  
    if ((snakeSize-lastBase) > 2)
    {
      slow--;
      lastBase=snakeSize;
    }
  }
  if (slow > 10) { slow=10; } 
  if (slow < 2)  { slow=2; }   
  //println("slow = " + slow); 
}  

//******************************
// KEYPRESSED
//******************************
void keyPressed() 
{
  // key used to move the snake
  if (keyCode == UP)    
  { 
    if (snakesY[1] != snakesY[0]-10) 
    {  
      moveY = -10; 
      moveX = 0; 
      dir=0;
    } 
  }
  
  if (keyCode == DOWN)  
  { 
    if (snakesY[1] != snakesY[0]+10) 
    {
      moveY = 10;  
      moveX = 0; 
      dir=2;
    } 
  }
  
  if (keyCode == LEFT)  
  { 
    if (snakesX[1] != snakesX[0]-10) 
    {
      moveX = -10; 
      moveY = 0; 
      dir=3;
    } 
  }
  
  if (keyCode == RIGHT) 
  { 
    if (snakesX[1] != snakesX[0]+10) 
    {
      moveX = 10;
      moveY = 0; 
      dir=1;
    } 
  }

  // start new game
  if ((key == 'N') || (key=='n'))  
  { 
    newGame(); 
  }

  // pause game
  if ((key==' ') || (key == 'P') || (key=='p'))  
  { 
    if ((showInfo==false) && (gameover==false))
    {
      pause=!(pause); 
      loop(); 
    }
  } 

  // show info window
  if (key=='i' || key=='I')
  {
    if ((pause==false)  && (gameover==false))
    {
      showInfo = !(showInfo);
      if (showInfo==false)
      { 
        loop(); 
      }
    }  
  }

  // save image window
  if (key=='s' || key=='S')
  {
    saveFrame("s" + timestamp() + ".png");
  }
  
  // intercept ESC key
  if (keyCode==ESC)
  {
    key=0;
    //println("ESC");
  }    
}

// ***************************
// MOUSE INTERACTION
// ***************************

// ***************************
// mousePressed
// ***************************
void mousePressed()
{
  //  println("mouse: " + mouseX + " - " + mouseY);
  // check if press info button
  if ((mouseX > 481) && (mouseX < 498) && (mouseY > 481) && (mouseY < 498))
  {
    if ((pause==false)  && (gameover==false))
    {
      showInfo = !(showInfo);
      if (showInfo==false)
      { 
        loop(); 
      }
    }  
  }  
}

// ***************************
// mouseMoved
// ***************************
void mouseMoved()
{
  //set cursor
  // check if mouse is over new game button
  if ((mouseX > 481) && (mouseX < 498) && (mouseY > 481) && (mouseY < 498))
  {
    cursor(HAND);
  }
  else
  { 
    cursor(ARROW);
  }        
}


// **********************
// infoWindow FUNCTION
// **********************
void infoWindow()
{
  fill(0, 210);
  rectMode(CENTER);
  textAlign(CENTER);
  noStroke();
  rect(width/2, height/2, 250, 150);
  fill(240);
  textFont(infoFont);
  text("SNAKE by cameyo", width/2, height/2-54);
  text("The game of Snake.", width/2, height/2-32);        
  textAlign(LEFT);
  text("[N] key: start new game", width/2-114, height/2-10);
  text("[arrows] key: up,right,down,left", width/2-114, height/2+6);  
  text("[space] key: pause game", width/2-114, height/2+22);
  text("[S] key: save window", width/2-114, height/2+38);
  text("[I] key: show/hide info", width/2-114, height/2+54);
  text("__________________________________", width/2-119, height/2+66);
  textFont(gameFont);
  textAlign(CENTER);
  noLoop();
}  

// **********************
// changeAppIcon FUNCTION
// **********************
void changeAppIcon()
{
  // create icon for application
  PGraphics icon = createGraphics(16, 16, JAVA2D);
  // draw icon
  icon.beginDraw();
  icon.stroke(0);
  icon.noFill();
  icon.rect(0, 0, 15, 15);
  
  icon.stroke(53,100,30);
  icon.line(3,12,3,9);
  icon.line(3,9,6,9);
  icon.line(6,9,6,3);
  icon.line(6,3,11,3);
  icon.line(11,3,11,9);
  
  icon.stroke(255,30,30);
  icon.line(11,12,11,12);

  icon.endDraw();
  // set icon
  frame.setIconImage(icon.image);
}


// **********************
// timestamp FUNCTION
// **********************
String timestamp()
{
  Calendar now = Calendar.getInstance();
  return String.format("20%1$ty-%1$tm-%1$td_%1$tH.%1$tM.%1$tS", now);
}



