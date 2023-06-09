import java.util.ArrayList;
import java.util.List;

boolean temp = true;
boolean levelFinished = true; // true for starting screen, which counts as a level
final int totalNumLevels = 4;
int currentLevelChoosing = 2; // this leads to level 1
int rowChoosing = 0;
int columnChoosing = 0;
int ticksEnemy1 = 1;
int ticksEnemy2 = 1;
boolean startSecondSpawn = false;
boolean upgradeFirstSpawn = false;
boolean upgradeSecondSpawn = false;

int spawnEveryXFrames1;
int spawnEveryXFrames2;
int totalMoney = 1200;
PImage grass;
PImage sand;
PImage ice;
PImage rock;

int income = 10;

PImage path;
PImage spawner;

int BGframes = 30;
// 7 for 4 levels
//
PImage[] menuBG;
int currentFrame = 0;
boolean reverseFrames = false;

PImage[] levels;


int boxPosZ = 0;
int boxPosX = 0;
int baseHealth = 30;
boolean inBuildMode;
int[] price = new int[] {200, 500};
int[] radii = new int[] {4, 3}; // damage radius for each tower
int damage = 5;
float fireRate = 5;
int slowIntensity = 20;

int health1 = 100;
int upgradeHealth = 200;

int health2 = 50;
int upgradeHealth2 = 100;

int speedInverse1 = 20;
int upgradeSpeed = 10;

int speedInverse2 = 10;
int upgradeSpeed2 = 5;

ArrayList<PShape> towerModels;
int towerModelsIndex;

PShape tree;
PShape fridge;
PShape cactus;
PShape lavaTree;

PShape robot2;
PShape turret;
PShape sword;
PShape robot;

PShape robotUpgrade1;
PShape robotUpgrade2;
PShape robotUpgrade3;
PShape robotUpgrade4;

PShape robot2Upgrade1;
PShape robot2Upgrade2;
PShape robot2Upgrade3;
PShape robot2Upgrade4;

PShape slow;

int yrot = 0;
int zoomAmount = 0;

float isoThetaX = -atan(sin(radians(45))) + radians(5);
float isoThetaY = radians(45);
Level currentLevel;
int levelNum = 0;

int shiftX;
int shiftY;

boolean paused = false;

boolean setupDone;

void setup() {

    size(1600, 900, P3D);
    surface.setResizable(false);
   
    smooth();
    ortho();
    //noFill();
    //noStroke();
    currentLevel = new Level(levelNum);
        
    grass = loadImage("textures/grass.png");
    sand = loadImage("textures/sand.png");
    ice = loadImage("textures/ice.jpg");
    rock = loadImage("textures/rock.png");
    
    path = loadImage("textures/path.png");
    
    tree = loadShape("models/tree/tree01.obj");
    cactus = loadShape("models/cactus/cactus.obj");
    fridge = loadShape("models/fridge/fridge.obj");
    lavaTree = loadShape("models/lavaTree/lavaTree.obj");
    
    spawner = loadImage("textures/spawner.jpg");
    
    

    

    
    
    turret = loadShape("models/turret/turret.obj");
    sword = loadShape("models/sword/sword.obj");
    slow = loadShape("models/slow/slow.obj");
    towerModels = new ArrayList<PShape>(List.of(turret, slow));
    towerModelsIndex = 0;
    setupDone = true;

}
void setupExtend(){
      menuBG = new PImage[BGframes];
      for (int j = 0; j < BGframes; j++) {
        menuBG[j] = loadImage("textures/menuBackgroundArr/" + j + ".png");
      }
    
    levels = new PImage[4];
    for (int i = 0; i < levels.length; i++) {
      levels[i] = loadImage("textures/level" + (i+1) + ".png"); 
    }
    
    robot = loadShape("models/robot/robot.obj");
    robotUpgrade1 = loadShape("models/level1/robotUpgrade/robot.obj");
    // add all definitions here, for all robot upgrades,
    robotUpgrade2 = loadShape("models/level2/robotUpgrade/robot.obj");
    robotUpgrade3 = loadShape("models/level3/robotUpgrade/robot.obj");
    robotUpgrade4 = loadShape("models/level4/robotUpgrade/robot.obj");
    robot2 = loadShape("models/robot2/robot2.obj");
    robot2Upgrade1 = loadShape("models/level1/robot2Upgrade/robot2.obj");
    robot2Upgrade2 = loadShape("models/level2/robot2Upgrade/robot2.obj");
    robot2Upgrade3 = loadShape("models/level3/robot2Upgrade/robot2.obj");
    robot2Upgrade4 = loadShape("models/level4/robot2Upgrade/robot2.obj");
    setupDone = false;

}
void draw() {
  
   if(setupDone){
     setupExtend();
   }
     

    if (currentLevel.tiles != null) {
      displayLevel();
      displayBuild();
      checkKey();
      
      
    }
    else { // levels not part of game, menu and levelselect
      switch (levelNum) {
        case 0:
          menuScreen();
          break;
        case 1:
          levelSelect();
          break;
      }
    }
}

void drawBG() {
  if (levelNum == 0 || levelNum == 1) {
    if (frameCount % 5 == 0) {
        if (currentFrame == BGframes - 1 && !reverseFrames) {
          reverseFrames = true;
        }
        else if (currentFrame == 0 && reverseFrames) {
          reverseFrames = false;
        }
        currentFrame += (reverseFrames ? -1 : 1);
    
      }
      // background
      if (width != 1600 && height != 900) {
        pushMatrix();
        translate(0,0,-1);
        image(menuBG[currentFrame], 0, 0, width, height);
        popMatrix();
      }
      else {
        background(menuBG[currentFrame]);
      }
  }
  else {
      if (width != 1600 && height != 900) {
        pushMatrix();
        translate(0,0,-1);
        image(levels[levelNum-2], 0, 0, width, height);
        popMatrix();
      }
      else {
        background(levels[levelNum-2]);
      }
  }
}

void menuScreen() {
  drawBG();
  //title
  textAlign(CENTER, CENTER);
  textSize(125);
  fill(255);
  text("Guardian's Gauntlet", width/2, height/2 - 200);
  
  //menu buttons
  textSize(24);
  fill(255);
  rectMode(CENTER);
  
  // Start Game
  fill(#4C83B3);
  rect(width/2, height/1.5 - 200, 250, 100);
  fill(200,0,0);
  text("Press Enter to Begin", width/2, height/1.5 - 200);
  textAlign(LEFT, LEFT);
  rectMode(CORNER);
  noFill();
}

void levelSelect() {
  drawBG();
   //make sure rows * columns gets u totalNumLevels
  int rows = 2;
  int columns = 2;
  int rectSizeW = width/(2 * columns + 1);
  int rectSizeH = height/(2 * rows + 1);

  
  textAlign(CENTER, CENTER);
  textSize(60);
  color[] bgCol = new color[] {
     color(75,50,0),
     color(194,178,128),
     color(165, 242, 243),
     color(119,3,1)
  };
  color[] textColors = new color[] {
     color(68, 165, 42),
     color(44, 162, 49),
     color(131,139,139),
     color(185,45,45)
   };
  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      int pos = j * columns + i;
      //text(pos, (((2 * i + 1) * rectSizeW) + ((2 * i + 1) * rectSizeW + rectSizeW))/2, (((2 * j + 1) * rectSizeH) + ((2 * j + 1) * rectSizeH + rectSizeH))/2);
      fill(bgCol[pos]);
      // Calculate RGB values based on position
      if (currentLevelChoosing-2 == pos) {
        stroke(255,255,255);
        strokeWeight(10);
      }
      rect((2 * i + 1) * rectSizeW, (2 * j + 1) * rectSizeH, rectSizeW, rectSizeH, 4);
      fill(textColors[pos]);
      
      text(pos, (((2 * i + 1) * rectSizeW) + ((2 * i + 1) * rectSizeW + rectSizeW))/2, (((2 * j + 1) * rectSizeH) + ((2 * j + 1) * rectSizeH + rectSizeH))/2);
      noStroke();
      strokeWeight(1);
    }
  }
  textAlign(LEFT, LEFT);
      
  levelFinished = true;
}

void displayLevel(){
  if(baseHealth <= 0){
    levelFinished = true;
    
    
  }
  lights();
  drawBG();
  translate(width / 2, height / 2, zoomAmount);
  pushMatrix();            
  //translate(width / gridSize - 100, height / gridSize - 100);
  rotateX(isoThetaX);
  rotateY(isoThetaY);
  translate(shiftX,0,shiftY);
  if (!levelFinished) {
    pushMatrix();
    switch (levelNum) {
      case 2:
        fill(75,50,0);
        break;
      case 3:
        fill(194,178,128);
        break;
      case 4:
        fill(165, 242, 243);
        break;
      case 5:
        fill(119,3,1);
        break;
    }
    translate(0,4001,0);
    box(currentLevel.tiles.length*50,8000,currentLevel.tiles[0].length*50);
    popMatrix();
  }
  pushMatrix();
  translate(0,-50,0);
  fill(200,200,200);
  /*
  sphere(50);
  ambientLight(108, 237, 195, 0, 0, 0);
  */
  noFill();
  popMatrix();
  rotateX(PI/2);
  
    
    if (!levelFinished) {
      populateLevel();
      if(!paused){
      progressLevel();
      updateEnemies();
      updateTowers();
      }
      displayEnemies();
      showAxes();
      displayTowers();
      
    }

    
    
    popMatrix();
    pushMatrix();
    translate(-width/2,-height/2,-zoomAmount);
    if(paused)
      fill(0,255,0);
    else
      fill(255,0,0);
    rect(0,0,100,50);
    textSize(100);
    fill(255,255,255);
    text("Base Health: " + baseHealth,0,120);
    
    text("Money Left: $" + totalMoney, width-850, 120);
    if (levelFinished) {
      rectMode(CENTER);
      stroke(131, 103, 103);
      strokeWeight(10);
      rect(width/2, height/2, 1300, 500);
      textAlign(CENTER, CENTER);
      textSize(50);
      
      if (baseHealth > 0) {
        fill(98, 216, 131);
        text("You Survived the Invasion!", width/2, height/2 - 200);
        text("Press Enter to go back to the Main Menu", width/2, height/2);
      }
      else {
        fill(211,49,49);
        text("DEFEAT!", width/2, height/2 - 200);
        text("Press Enter to go back to the Main Menu", width/2, height/2);
      }
      noFill();
      stroke(0,0,0);
      strokeWeight(1);
      textAlign(LEFT, LEFT);
      rectMode(CORNER);
    }
    popMatrix();

}

void populateLevel() {
  for(int i = 0; i < currentLevel.tiles.length; i++){
      for(int j = 0; j < currentLevel.tiles[0].length; j++){
        if(currentLevel.tiles[currentLevel.tiles.length - i - 1][j].type == 0){
         switch(levelNum) {
            case 2:
              image(grass,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
              break;
            case 3:
              image(sand,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
              break;
            case 4:
              image(ice,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
              break;
            case 5:
             image(rock,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
              break;
            } 
             
        }
        if(currentLevel.tiles[currentLevel.tiles.length - i - 1][j].type == 1){
          switch(levelNum) {
            case 2:
              pushMatrix();
              translate((i - (float)currentLevel.tiles.length / 2)*50+25,(j - (float)currentLevel.tiles[0].length / 2)*50+25,0);
              image(grass,-25,-25,50,50);
            
              rotateX(radians(90));
      
              shape(tree,0,0);
              popMatrix();
              break;
            case 3:
              pushMatrix();
              translate((i - (float)currentLevel.tiles.length / 2)*50+25,(j - (float)currentLevel.tiles[0].length / 2)*50+25,0);
              image(sand,-25,-25,50,50);
            
              rotateX(radians(90));
      
              shape(cactus,0,0);
              popMatrix();
              
              break;
            case 4:
              pushMatrix();
              translate((i - (float)currentLevel.tiles.length / 2)*50+25,(j - (float)currentLevel.tiles[0].length / 2)*50+25,0);
              image(ice,-25,-25,50,50);
            
              rotateX(radians(90));
      
              shape(fridge,0,0);
              popMatrix();
              
              break;
            case 5:
              pushMatrix();
              translate((i - (float)currentLevel.tiles.length / 2)*50+25,(j - (float)currentLevel.tiles[0].length / 2)*50+25,0);
              image(rock,-25,-25,50,50);
            
              rotateX(radians(90));
      
              shape(lavaTree,0,0);
              popMatrix();
              
              break;
               
          }
          
        }
        if(currentLevel.tiles[currentLevel.tiles.length - i - 1][j].type == 2){
          //fill(212,200,130);
          image(path,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
        }
        if(currentLevel.tiles[currentLevel.tiles.length - i - 1][j].type == 3){
          image(spawner,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
  
        }
        if(currentLevel.tiles[currentLevel.tiles.length - i - 1][j].type == 4){
          image(spawner,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
  
        }
        if(currentLevel.tiles[currentLevel.tiles.length - i - 1][j].type == 5){
          switch(levelNum) {
            case 2:
              image(grass,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
              break;
            case 3:
              image(sand,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
              break;
            case 4:
              image(ice,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
              break;
            case 5:
             image(rock,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
              break;
               
          }
        }
        if(currentLevel.tiles[currentLevel.tiles.length - i - 1][j].type == 6){
         
          switch(levelNum) {
            case 2:
              image(grass,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
              break;
            case 3:
              image(sand,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
              break;
            case 4:
              image(ice,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
              break;
            case 5:
             image(rock,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
              break;
               
            } 

          }
       
         
      }
   
    } 
}

void progressLevel() {
/*
  ticksEnemy1++;
      if(ticksEnemy1 > 3000)
        ticksEnemy2++;
        spawnEveryXFrames1 = 100000/(ticksEnemy1+1) + (int)(20*Math.random());
*/
  println(ticksEnemy1 + " is enemy1 and " + ticksEnemy2 + " is enemy2");
  println(spawnEveryXFrames1 + " is spawnEveryXFrames1 and " + spawnEveryXFrames2 + " is spawnEveryXFrames2"); 
  println(levelFinished);
  println("progressing in levelNum " + levelNum);
  switch (levelNum) {
    case 2:
      // setting rate 
      if (ticksEnemy1 % 60 == 0) totalMoney+=income;
      spawnEveryXFrames1 = 400000/(ticksEnemy1) + int(random(-10, 10));
      
      ticksEnemy1++;
      if (ticksEnemy1 > 3000) {
        if (!startSecondSpawn) {
          startSecondSpawn = true;
        }
        spawnEveryXFrames2 = 400000/(ticksEnemy2);
        ticksEnemy2++;
      }
      
      if (ticksEnemy1 > 5000) {
         upgradeFirstSpawn = true;
      }
      if (ticksEnemy2 > 5000) {
        upgradeSecondSpawn = true;
      }
      spawnEveryXFrames1 = spawnEveryXFrames1 <= 0 ? 1 : spawnEveryXFrames1;
      spawnEveryXFrames2 = spawnEveryXFrames2 <= 0 ? 1 : spawnEveryXFrames2;
//---------------------
      if (ticksEnemy1 % spawnEveryXFrames1 == 0) {
        if (upgradeFirstSpawn) {
          spawnEnemy(2);
        }
        else {
          spawnEnemy(0);

        } 
      }
      else if (startSecondSpawn){
        if (ticksEnemy2 % spawnEveryXFrames2 == 0) {
          if (upgradeSecondSpawn) {
            spawnEnemy(3);
          }
          else {
            spawnEnemy(1);
          } 
        }
      }
      
      
      
    if (ticksEnemy1 == 50000) 
        levelFinished = true;
      break;
    case 3:
// setting rate 
      if (ticksEnemy1 % 60 == 0) totalMoney+=income;
      spawnEveryXFrames1 = 400000/(ticksEnemy1) + int(random(-10, 10));
      
      ticksEnemy1++;
      if (ticksEnemy1 > 3000) {
        if (!startSecondSpawn) {
          startSecondSpawn = true;
        }
        spawnEveryXFrames2 = 400000/(ticksEnemy2);
        ticksEnemy2++;
      }
      
      if (ticksEnemy1 > 5000) {
         upgradeFirstSpawn = true;
      }
      if (ticksEnemy2 > 5000) {
        upgradeSecondSpawn = true;
      }
      spawnEveryXFrames1 = spawnEveryXFrames1 <= 0 ? 1 : spawnEveryXFrames1;
      spawnEveryXFrames2 = spawnEveryXFrames2 <= 0 ? 1 : spawnEveryXFrames2;
//---------------------
      if (ticksEnemy1 % spawnEveryXFrames1 == 0) {
        if (upgradeFirstSpawn) {
          spawnEnemy(2);
        }
        else {
          spawnEnemy(0);

        } 
      }
      else if (startSecondSpawn){
        if (ticksEnemy2 % spawnEveryXFrames2 == 0) {
          if (upgradeSecondSpawn) {
            spawnEnemy(3);
          }
          else {
            spawnEnemy(1);
          } 
        }
      }
      
      
      
    if (ticksEnemy1 == 50000) 
        levelFinished = true;
      break;
    case 4:
// setting rate
      if (ticksEnemy1 % 60 == 0) totalMoney+=income;
      spawnEveryXFrames1 = 400000/(ticksEnemy1) + int(random(-10, 10));
      
      ticksEnemy1++;
      if (ticksEnemy1 > 3000) {
        if (!startSecondSpawn) {
          startSecondSpawn = true;
        }
        spawnEveryXFrames2 = 400000/(ticksEnemy2);
        ticksEnemy2++;
      }
      
      if (ticksEnemy1 > 5000) {
         upgradeFirstSpawn = true;
      }
      if (ticksEnemy2 > 5000) {
        upgradeSecondSpawn = true;
      }
      spawnEveryXFrames1 = spawnEveryXFrames1 <= 0 ? 1 : spawnEveryXFrames1;
      spawnEveryXFrames2 = spawnEveryXFrames2 <= 0 ? 1 : spawnEveryXFrames2;
//---------------------
      if (ticksEnemy1 % spawnEveryXFrames1 == 0) {
        if (upgradeFirstSpawn) {
          spawnEnemy(2);
        }
        else {
          spawnEnemy(0);

        } 
      }
      else if (startSecondSpawn){
        if (ticksEnemy2 % spawnEveryXFrames2 == 0) {
          if (upgradeSecondSpawn) {
            spawnEnemy(3);
          }
          else {
            spawnEnemy(1);
          } 
        }
      }
      
      
      
    if (ticksEnemy1 == 50000) 
        levelFinished = true;
      break;
    case 5:
// setting rate 
      if (ticksEnemy1 % 60 == 0) totalMoney+=income;
      spawnEveryXFrames1 = 400000/(ticksEnemy1) + int(random(-10, 10));
      
      ticksEnemy1++;
      if (ticksEnemy1 > 3000) {
        if (!startSecondSpawn) {
          startSecondSpawn = true;
        }
        spawnEveryXFrames2 = 400000/(ticksEnemy2);
        ticksEnemy2++;
      }
      
      if (ticksEnemy1 > 5000) {
         upgradeFirstSpawn = true;
      }
      if (ticksEnemy2 > 5000) {
        upgradeSecondSpawn = true;
      }
      spawnEveryXFrames1 = spawnEveryXFrames1 <= 0 ? 1 : spawnEveryXFrames1;
      spawnEveryXFrames2 = spawnEveryXFrames2 <= 0 ? 1 : spawnEveryXFrames2;
//---------------------
      if (ticksEnemy1 % spawnEveryXFrames1 == 0) {
        if (upgradeFirstSpawn) {
          spawnEnemy(2);
        }
        else {
          spawnEnemy(0);

        } 
      }
      else if (startSecondSpawn){
        if (ticksEnemy2 % spawnEveryXFrames2 == 0) {
          if (upgradeSecondSpawn) {
            spawnEnemy(3);
          }
          else {
            spawnEnemy(1);
          } 
        }
      }
      
      
      
    if (ticksEnemy1 == 50000) 
        levelFinished = true;
      break;
  }
}

void displayBuild() {  
  if(inBuildMode && !levelFinished){  
    translate(0, 0);
    pushMatrix();
    rotateX(isoThetaX);
    rotateY(isoThetaY);
    translate(-((-boxPosX - (float)currentLevel.tiles.length / 2)*50+25-shiftX),-25, (boxPosZ -(float)currentLevel.tiles[0].length / 2)*50+25 + shiftY);

    //translate((boxPosX + (float)currentLevel.tiles.length / 2)*50-25 + shiftX,-25, (boxPosZ -(float)currentLevel.tiles[0].length / 2)*50+25 + shiftY);;
    //fill(255,0,0);
    pushMatrix();
      if (currentLevel.tiles[-boxPosX][boxPosZ].getCanPlaceTower())
        fill(0,255,0);
      else
        fill(255,0,0);
      translate(0, 24, 0);
      rotateX(radians(90));
      circle(0,0, 100 + 50 * radii[towerModelsIndex]);
    popMatrix();
   
    noFill();
    stroke(0,0,0);
    rotateZ(radians(180));
    yrot = yrot++ == 360 ? 0 : yrot;
    rotateY(radians(yrot));
   
    translate(0, -25, 0);
    shape(towerModels.get(towerModelsIndex), 0, 0);
   
    popMatrix();
  }
  

}
void checkKey() {
    if(keyPressed == true){
       if(key == 'w'  && isoThetaX > -radians(90)){
        //isoThetaX -= radians(1);
        shiftY += 5;
       }
       else if(key == 's' && isoThetaX < 0){
        //isoThetaX += radians(1);
        shiftY -= 5;
       }
       else if(key == 'a' && isoThetaX < 0 && isoThetaY < radians(90)){
        //isoThetaY += radians(1);  
        shiftX += 5;
      }
       else if(key == 'd' && isoThetaX < 0 && isoThetaY > 0){
        //isoThetaY -= radians(1);
        shiftX -= 5;          
     }
    }
   
}

void mousePressed(){
  if (currentLevel.tiles != null) {
    if(mouseX > 0 && mouseX < 100 && mouseY > 0 && mouseY < 50){
      paused = !paused;
    }
  }
  
  //zoomAmount += 100;
 

}

void keyPressed(){
  if (currentLevel.tiles != null) {
    
        if (key == 'z'){
          zoomAmount += 100;          
        }
        else if (key == 'x'){
          zoomAmount -= 100;
        }
        zoomAmount = constrain(zoomAmount, -1500, 500);
        if (levelFinished && key == ENTER) {
          
          reset();
        }
        else if(key == 'b'){
          inBuildMode = !inBuildMode;
        }
         else if(inBuildMode && !paused){
            if(key == CODED){
              if(keyCode == UP && boxPosX < 0){
             
                boxPosX += 1;
              }
              else if(keyCode == DOWN && boxPosX > -(currentLevel.tiles.length - 1)){
                boxPosX -= 1;
              }
              else if(keyCode == RIGHT && boxPosZ < currentLevel.tiles[0].length - 1){
                boxPosZ += 1;
              }
              else if(keyCode == LEFT && boxPosZ > 0){
                boxPosZ -= 1;
              }
              else if (keyCode == SHIFT) { //PLACE TOWER
               if( currentLevel.tiles[-boxPosX][boxPosZ].getCanPlaceTower()){
                if (totalMoney - price[towerModelsIndex] < 0) {
                   
                }
                else {
                  totalMoney -= price[towerModelsIndex];
                  if (towerModels.get(towerModelsIndex) == turret) {
                     spawnTower(-boxPosX, boxPosZ, "TurretTower");
                     currentLevel.tiles[-boxPosX][boxPosZ] = new Tile(5);
 
                  }
                  else if (towerModels.get(towerModelsIndex) == slow) {
                     spawnTower(-boxPosX, boxPosZ, "SlowTower");
                     currentLevel.tiles[-boxPosX][boxPosZ] = new Tile(6);
 
                  }
                }
               }
               
             
              }  
              else if (keyCode == ALT) { //DELETE TOWER
                int towerIndex = -1;
                for(int i = 0; i < towers.size(); i++){
                  if(towers.get(i).tilePosition.x == -boxPosX && towers.get(i).tilePosition.y == boxPosZ)
                    towerIndex = i;
                }
                if(towerIndex >= 0){
                  towers.get(towerIndex).delete();
                  currentLevel.tiles[-boxPosX][boxPosZ] = new Tile(0);
                }
              }
            }
            else {
              if (key == 'c') { // SWAP BETWEEN TOWERS
                if (++towerModelsIndex == towerModels.size()) 
                  towerModelsIndex = 0;
                
              }
            }
          }
          
  }
  else {

    if (key == ENTER && levelFinished) {
      if (levelNum == 0) {
        levelNum = 1;
        currentLevel = new Level(levelNum);
        levelFinished = true;
      }
      else if (levelNum == 1) { // select level
        levelNum = currentLevelChoosing;
        currentLevel = new Level(levelNum);
        levelFinished = false;
        
      }
    }
    else if (key == TAB && levelNum == 1) {
      currentLevelChoosing = ++currentLevelChoosing == totalNumLevels+2 ? 2 : currentLevelChoosing; // total num is 9, so push by 2 since current level choosing pushed by 2
    }
    
  }
  
         

}


void displayTowers() {
  for (int i = 0; i < towers.size(); i++) {
    pushMatrix();
    translate(-(((towers.get(i)).tilePosition.x - (float)currentLevel.tiles.length / 2)*50+25),((towers.get(i)).tilePosition.y - (float)currentLevel.tiles[0].length / 2)*50+25,0);
    /*
    println("position on tile is " + towers.get(i).tilePosition);
    println("position on world is: x " + -(((towers.get(i)).tilePosition.x - (float)currentLevel.tiles.length / 2)*50+25) + " y " + ((towers.get(i)).tilePosition.y - (float)currentLevel.tiles[0].length / 2)*50+25);
   
    println("position of box is [" + -boxPosX + " " + boxPosZ + "]");
    println("position on world is: x " + -((-boxPosX - (float)currentLevel.tiles.length / 2)*50+25) + " y " + (boxPosZ -(float)currentLevel.tiles[0].length / 2)*50+25);
    */
    rotateX(radians(90));
    switch (towers.get(i).type) {
      case "TurretTower":
        if (towers.get(i).target != null) {
          PVector turretPos = towers.get(i).tilePosition;
          PVector enemyPos = towers.get(i).target.interPos;
          PVector directionToEnemy = new PVector(enemyPos.x - turretPos.x, enemyPos.y - turretPos.y);
          float angle = PVector.angleBetween(new PVector(0,-1), directionToEnemy);
          rotateY(/*(3 * PI)/2*/angle * (directionToEnemy.x > 0 ? -1 : 1));
          //println(turretPos + " vs "  + -boxPosX + " and " + boxPosZ);
          //println(enemyPos.x + " " + enemyPos.y);
          //println("angle is " + angle);
        }
        shape(turret, 0, 0);
        break;
      case "SlowTower":
        shape(slow, 0, 0);
        break;
    }
    popMatrix();
  }
}

void updateTowers() {
  
    for (int i = 0; i < towers.size(); i++) {
      towers.get(i).update();
    }
  
}


void displayEnemies(){
       
        for(int i = 0; i < enemies.size(); i++){
          pushMatrix();
          translate(-(((enemies.get(i)).interPos.x - (float)currentLevel.tiles.length / 2)*50+25),((enemies.get(i)).interPos.y - (float)currentLevel.tiles[0].length / 2)*50+25,0);
          //image(grass,-25,-25,50,50);
          switch (enemies.get(i).direction) {
            case 0:
              rotateZ(radians(270));
              break;
            case 1:
              rotateZ(radians(90));
              break;
            case 2:
              rotateZ(radians(0));
              break;
            case 3:
              rotateZ(radians(180));
              break;
          }
          //rotateZ(radians(yrot));
          rotateX(radians(90));
         
         
         
          //translate(0,200,0);
         
          shape(enemies.get(i).model,0,0);
          enemies.get(i).healthBar();
          popMatrix();
        }

}

void updateEnemies() {
  
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).update();
  }
}
void spawnEnemy(int type){ //0 Robot 1 robot2 UNFINISHED
    switch (type) {
      case 0:
        enemies.add(new Enemy1(0,0,health1,speedInverse1,levelNum));
        break;
      case 1:
        enemies.add(new Enemy2(0,0,health2,speedInverse2,levelNum));
        break;
      case 2:
        enemies.add(new Enemy3(0,0,upgradeHealth,upgradeSpeed,levelNum));
        break;
      case 3:
        enemies.add(new Enemy4(0,0,upgradeHealth2,upgradeSpeed2,levelNum));
        break;
    }
    //enemies.add(new Enemy1(0,0,health,speedInverse,levelNum));
}
void spawnTower(int tilePosX, int tilePosY, String type) {
  switch (type) {
    case "TurretTower":
      towers.add(new TurretTower(tilePosX, tilePosY, radii[0], damage, fireRate));
      break;
    case "SlowTower":
      towers.add(new SlowTower(tilePosX, tilePosY, radii[1], slowIntensity));
      break;
  }
}

void reset(){
  shiftX = 0;
  shiftY = 0;
  ticksEnemy1 = 1;
  ticksEnemy2 = 1;
  enemies = new ArrayList<Enemy>();
  towers = new ArrayList<Tower>();
  levelNum = 0;
  currentLevel = new Level(levelNum);
  //currentLevel.tiles = null;
  
  levelFinished = true; // since we are returning to hte menu screen, it should be automatically back to true 
  startSecondSpawn = false;

  baseHealth = 30;
  totalMoney = 1200;
  //levelNum = 0;
  upgradeFirstSpawn = false;
  upgradeSecondSpawn = false;
}
void showAxes(){/*
  stroke(255,0,0);
  line(0,0,0,100,0,0);
  stroke(0,255,0);
  line(0,0,0,0,100,0);
    stroke(0,0,255);
  line(0,0,0,0,0,100);*/
  stroke(0,0,0);
}
