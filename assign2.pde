PImage bg, soil, life, groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;
PImage soldier, cabbage;
PImage title, startNormal, startHovered;
PImage gameover, restartNormal, restartHovered;
int soldierX, soldierY;
int cabbageX, cabbageY;
int HP = 2;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = GAME_START;

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;

float groundhogX;
float groundhogY;
float groundhogSpeed = 80;

int down = 0;
int right = 0;
int left = 0;
float step = 80.0;
int frames = 15;

boolean upPressed, downPressed, rightPressed, leftPressed;

void setup() {
  
  size(640, 480, P2D);
  bg = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  life = loadImage("img/life.png");
  
  title = loadImage("img/title.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogX = 320;
  groundhogY = 80;
  
  soldier = loadImage("img/soldier.png");  
  soldierY = floor(random(2,6))*80;  
  
  cabbage = loadImage("img/cabbage.png");
  cabbageX = floor(random(0,8))*80;
  cabbageY = floor(random(2,6))*80;  
  
  gameover = loadImage("img/gameover.jpg");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
}

void draw(){
  switch(gameState){
    case GAME_START:
     image(title, 0, 0);
     
     if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(startHovered, 248, 360);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(startNormal, 248, 360);
      }
    break;
  
  case GAME_RUN:
  noStroke();  
  //bg
  image(bg, 0,0);
  //grass
  fill(124, 204, 25);
  rect(0, 145, 640, 15);
  //soil
  image(soil, 0, 160);
  //outer sun
  fill(255, 255, 0);
  ellipse(width-50, 50, 130, 130);  
  //inner sun
  fill(253, 184, 19);
  ellipse(width-50, 50, 120, 120);
  
    //groundhog move
    //down
    if (down > 0) {
      if (down == 1) {
        groundhogY = round(groundhogY + step/frames);
        image(groundhogIdle, groundhogX, groundhogY);
      } else {
        groundhogY = groundhogY + step/frames;
        image(groundhogDown, groundhogX, groundhogY);
      }
      down -=1;
    }

    //left
    if (left > 0) {
      if (left == 1) {
        groundhogX = round(groundhogX - step/frames);
        image(groundhogIdle, groundhogX, groundhogY);
      } else {
        groundhogX = groundhogX - step/frames;
        image(groundhogLeft, groundhogX, groundhogY);
      }
      left -=1;
    }

    //right
    if (right > 0) {
      if (right == 1) {
        groundhogX = round(groundhogX + step/frames);
        image(groundhogIdle, groundhogX, groundhogY);
      } else {
        groundhogX = groundhogX + step/frames;
        image(groundhogRight, groundhogX, groundhogY);
      }
      right -=1;
    }

    //no move
    if (down == 0 && left == 0 && right == 0 ) {
      image(groundhogIdle, groundhogX, groundhogY);
    }
  
  //life
  for (int x = 0; x < HP; x++) {
      pushMatrix();
      translate(x*70, 0);
      image(life, 10, 10);
      popMatrix();
    }
  
  //soldier
  soldierX = soldierX+1;
  if (soldierX > 640){
    soldierX = -80;
  }
  image(soldier, soldierX++, soldierY); 
  
  //encounter soldier
  if (soldierX - 80 < groundhogX && groundhogX < soldierX + 80 && soldierY + 80 > groundhogY && groundhogY > soldierY - 80){
  groundhogX = 320;
  groundhogY = 80; 
  HP -= 1;
 }   
  
  //encounter cabbage
  image(cabbage, cabbageX, cabbageY);
  if (cabbageX - 80 < groundhogX && groundhogX < cabbageX + 80 && cabbageY + 80 > groundhogY && groundhogY > cabbageY - 80){
    cabbageX = -80;
    cabbageY = 0;
    HP += 1;
  }    
  if (HP == 0){
    gameState = GAME_OVER;
  }
  break;
  
  case GAME_OVER:
    image(gameover, 0, 0);
    
    if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){
        image(restartHovered, 248, 360);
        if(mousePressed){
          gameState = GAME_RUN;
          soldierX = -80;
          soldierY = floor(random(2,6))*80;  
          cabbageX = floor(random(0,8))*80;
          cabbageY = floor(random(2,6))*80;
          
          HP = 2; 
        }
      }else{
        image(restartNormal, 248, 360);
      }
    break;
  }
  
}


void keyPressed(){
  //groundhogMoveLock
  if (down>0 || left>0 || right>0) {
    return;
  }
  if (key == CODED) {
    switch(keyCode) {
    case DOWN:
      if (groundhogY < 400) {
        downPressed = true;
        down = 15;
      }
      break;
    case LEFT:
      if (groundhogX > 0) {
        leftPressed = true;
        left = 15;
      }
      break;
    case RIGHT:
      if (groundhogX < 560) {
        rightPressed = true;
        right = 15;
      }
      break; 
    }
  }  
}

void keyReleased(){
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
}
