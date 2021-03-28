PImage backgroundImg;
PImage groundhogIdleImg;
PImage lifeImg;
PImage soilImg;
PImage soldierImg;
PImage cabbageImg;
PImage gameoverImg;
PImage groundhogDownImg;
PImage groundhogLeftImg;
PImage groundhogRightImg;
PImage restartHoveredImg;
PImage restartNormalImg;
PImage startHoveredImg;
PImage startNormalImg;
PImage titleImg;

//button
float buttonLeft = 248;
float buttonTop = 360;
float buttonRight = 248+144;
float buttonDown = 360+60;

//boolean
boolean upPressed = false;
boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;

//soldier
float soldierX;
float soldierY;

//cabbage
float cabbageX;
float cabbageY;

//game state
int gameState;
final int gameStart = 0;
final int gameRun = 1;
final int gameLose = 2;

//groundhog spacing
final int spacing = 80;
float groundhogX = 4*spacing;
float groundhogY= spacing;

//life
int life1X = -60;
int lifeSpace = 70;

void setup() {
	size(640, 480, P2D);

  // images
  backgroundImg = loadImage("img/bg.jpg");
  groundhogIdleImg = loadImage("img/groundhogIdle.png");
  lifeImg = loadImage("img/life.png");
  soilImg = loadImage("img/soil.png");
  soldierImg = loadImage("img/soldier.png");
  cabbageImg = loadImage("img/cabbage.png");
  gameoverImg = loadImage("img/gameover.jpg");
  groundhogDownImg = loadImage("img/groundhogDown.png");
  groundhogLeftImg = loadImage("img/groundhogLeft.png");
  groundhogRightImg = loadImage("img/groundhogRight.png");
  restartHoveredImg = loadImage("img/restartHovered.png");
  restartNormalImg = loadImage("img/restartNormal.png");
  startHoveredImg = loadImage("img/startHovered.png");
  startNormalImg = loadImage("img/startNormal.png");
  titleImg = loadImage("img/title.jpg");
  
  //soldier show
  soldierX = 0;
  soldierY = floor(random(2,6))*80;
  
  //cabbage show
  cabbageX = floor(random(0,8))*80;
  cabbageY = floor(random(2,6))*80;
  
  //frame rate
  frameRate(60);
}

void draw() {
  //pressed speed
  /* test
  if(upPressed){
    groundhogY -= spacing;
  }
   if(downPressed){
    groundhogY += spacing;
  }
   if(rightPressed){
    groundhogX += spacing;
  }
   if(leftPressed){
    groundhogX -= spacing;
  }
  */
  
  //moving space
  if(groundhogX >= width-spacing){
    groundhogX = width-spacing;
  }
  if(groundhogX <= 0){
    groundhogX = 0;
  }
  if(groundhogY >= height-spacing){
    groundhogY = height-spacing;
  }
  if(groundhogY <= spacing){
    groundhogY = spacing;
  }
    
  
  //gameState
	switch (gameState){ 
		// Game Start
    case gameStart:
      image(titleImg, 0, 0);
      if(mouseX > buttonLeft && mouseX < buttonRight
      && mouseY > buttonTop && mouseY < buttonDown){
        image(startHoveredImg, 248, 360);
        if(mousePressed){
          gameState = gameRun;
        }
      }else{
        image(startNormalImg, 248, 360);
      }
    break;
    
		// Game Run
    case gameRun:
      // background
      image(backgroundImg,0,0);
      
      //soil
      image(soilImg,0,160);
      
      //grass
      noStroke();
      fill(124, 204, 25); //grass color
      rect(0,145,640,15);
      
      //sun
      strokeWeight(5);
      stroke(255, 255, 0);
      fill(253, 184, 19);
      ellipse(590, 50, 120, 120);
      
      //groundhog
      image(groundhogIdleImg, groundhogX, groundhogY);
      
      //life
      image(lifeImg, life1X, 10);
      image(lifeImg, life1X+lifeSpace, 10);
      image(lifeImg, life1X+lifeSpace*2, 10);
      
      //cabbage
      image(cabbageImg, cabbageX, cabbageY);
      
      //soldier
      if(soldierX>=width){
        soldierX =- spacing;
      }
      image(soldierImg, soldierX, soldierY);
  
      //soldier move
      soldierX+=4;
      soldierX%=width+spacing;
      
      //if groundhog touch soldier
      if ( groundhogX < soldierX+spacing && groundhogX+spacing > soldierX
          && groundhogY < soldierY+spacing && groundhogY+spacing > soldierY){
            life1X = life1X - lifeSpace;
            groundhogX = spacing*4;
            groundhogY = spacing;
          }
          
      //if groundhog eat cabbage
      if ( groundhogX < cabbageX+spacing && groundhogX+spacing > cabbageX
          && groundhogY < cabbageY+spacing && groundhogY+spacing > cabbageY){
            life1X = life1X + lifeSpace;
            cabbageX = cabbageX + 1000;
          }
          
      //if life 0
      if (life1X + lifeSpace*2 <= 0){
        gameState = gameLose;
      }
            
          
    break;
    
		// Game Lose
    case gameLose:
      image(gameoverImg, 0, 0);
      if(mouseX > buttonLeft && mouseX < buttonRight
      && mouseY > buttonTop && mouseY < buttonDown){
        image(restartHoveredImg, 248, 360);
        if(mousePressed){
          gameState = gameRun;
        }
      }else{
        image(restartNormalImg, 248, 360);
      }
      
      //initial life and groundhog
      life1X = -60;
      groundhogX = spacing*4;
      groundhogY = spacing;
      //cabbage
      cabbageX = floor(random(0,8))*80;
      cabbageY = floor(random(2,6))*80;
    break;
    
  }
}

void keyPressed(){
    switch (keyCode){
     case DOWN:
       groundhogY+=spacing;
       break;
     case LEFT:
       groundhogX-=spacing;
       break;
     case RIGHT:
       groundhogX+=spacing;
       break;
    }
       
  /*
  switch (keyCode){
    case UP:
    upPressed = true;
    break;
    case DOWN:
    downPressed = true;
    break;
    case RIGHT:
    rightPressed = true;
    break;
    case LEFT:
    leftPressed = true;
    break; 
  }
  */
}

void keyReleased(){
  /*
  switch (keyCode){ 
    case UP:
    upPressed = false;
    break;
    case DOWN:
    downPressed = false;
    break;
    case RIGHT:
    rightPressed = false;
    break;
    case LEFT:
    leftPressed = false;
    break;
  }
  */
}
