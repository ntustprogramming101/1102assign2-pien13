PImage bg, soil, life, groundhogIdle, soldier, cabbage;
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

boolean upPressed, downPressed, rightPressed, leftPressed;

void setup() {
  
  size(640, 480, P2D);
  bg = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  life = loadImage("img/life.png");
  
  title = loadImage("img/title.jpeg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogX = 320;
  groundhogY = 80;
  
  soldier = loadImage("img/soldier.png");  
  soldierY = floor(random(2,6))*80;  
  
  cabbage = loadImage("img/cabbage.png");
  cabbageX = floor(random(0,8))*80;
  cabbageY = floor(random(2,6))*80;  
  
  gameover = loadImage("img/gameover.jpeg");
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
  
  //groundhog
  if (upPressed){
    groundhogY -= groundhogSpeed;
  }
  if (downPressed){
    groundhogY += groundhogSpeed;
  }
  if (leftPressed){
    groundhogX -= groundhogSpeed;
    if (groundhogX < 0){
    groundhogX = 0;
    }
  }
  if (rightPressed){
    groundhogX += groundhogSpeed;
  } 
  image(groundhogIdle, groundhogX, groundhogY);
  
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
          HP = 2; 
        }
      }else{
        image(restartNormal, 248, 360);
      }
    break;
  }
  
}


void keyPressed(){
  switch (keyCode){
    case UP:
      groundhogY -= groundhogSpeed;
      if (groundhogY < 80){groundhogY = 80;}
      break;
    case DOWN:
      groundhogY += groundhogSpeed;
      if (groundhogY > height - 80){groundhogY = height - 80;}
      break;
    case RIGHT:
      groundhogX += groundhogSpeed;
      if (groundhogX > width - 80){groundhogX = width - 80;}
      break;
    case LEFT:
      groundhogX -= groundhogSpeed;
      if (groundhogX < 0){groundhogX = 0;}
      break;   
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
