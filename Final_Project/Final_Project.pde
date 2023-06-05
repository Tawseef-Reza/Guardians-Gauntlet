import java.util.ArrayList;
import java.util.List;

boolean temp = true;
boolean levelFinished = true; // true for starting screen, which counts as a level
final int totalNumLevels = 9;
int currentLevelChoosing = 2; // this leads to level 1
int rowChoosing = 0;
int columnChoosing = 0;

int spawnEveryXFrames = 20;
int totalMoney = 2000;
PImage grass;
PImage path;
PImage spawner;
int boxPosZ = 0;
int boxPosX = 0;
int baseHealth = 100;
boolean inBuildMode;
int[] price = new int[] {100, 50};
int[] radii = new int[] {4, 3}; // damage radius for each tower
int damage = 5;
float fireRate = 5;
int slowIntensity = 20;
int health = 100;
int speedInverse = 10;
ArrayList<PShape> towerModels;
int towerModelsIndex;

PShape tree;
PShape goblin;
PShape turret;
PShape sword;
PShape robot;
PShape slow;

int yrot = 0;
int zoomAmount = 0;

float isoThetaX = -atan(sin(radians(45))) + radians(5);
float isoThetaY = radians(45);
Level currentLevel;
int levelNum = 0;

int shiftX;
int shiftY;


void setup() {

    size(1600, 900, P3D);
    surface.setResizable(false);
   
    smooth();
    ortho();
    //noFill();
    //noStroke();
    currentLevel = new Level(levelNum);
    /*
    for (int i = 0; i < currentLevel.tiles.length; i++) {
      for (int j = 0; j < currentLevel.tiles[0].length; j++) {
        
        if (currentLevel.tiles[i][j].type == 5)
          spawnTower(i, j, "TurretTower");
        else if (currentLevel.tiles[i][j].type == 6)
          spawnTower(i, j, "SlowTower");
          
      }
    }
    */
    grass = loadImage("textures/grass.png");
    path = loadImage("textures/path.png");
    tree = loadShape("models/tree/tree01.obj");
    spawner = loadImage("textures/spawner.jpg");
   
    goblin = loadShape("models/goblin/Goblin.obj");
    robot = loadShape("models/robot/robot.obj");
   
    turret = loadShape("models/turret/turret.obj");
    sword = loadShape("models/sword/sword.obj");
    slow = loadShape("models/slow/slow.obj");
    towerModels = new ArrayList<PShape>(List.of(turret, slow));
    towerModelsIndex = 0;

}

void draw() {
  
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

void menuScreen() {
  // background
  background(#9656DB);
  //title
  textAlign(CENTER, CENTER);
  textSize(125);
  fill(255);
  text("Guardians of the Gauntlet", width/2, height/2 - 100);
  
  //menu buttons
  textSize(24);
  fill(255);
  rectMode(CENTER);
  
  // Start Game
  fill(100);
  rect(width/2, height/1.5, 250, 100);
  fill(255);
  text("Press Enter to Begin", width/2, height/1.5);
  textAlign(LEFT, LEFT);
  rectMode(CORNER);
  noFill();
}

void levelSelect() {
  background(0,0,0);
  //make sure rows * columns gets u totalNumLevels
  int rows = 3;
  int columns = 3;
  int rectSizeW = width/(2 * rows + 1);
  int rectSizeH = height/(2 * columns + 1);

  
  textAlign(CENTER, CENTER);
  textSize(60);
  color[] colors = new color[] {
        color(255, 0, 0),       // Red
        color(255, 165, 0),     // Orange
        color(255, 255, 0),     // Yellow
        color(0, 255, 0),       // Green
        color(0, 0, 255),       // Blue
        color(75, 0, 130),      // Indigo
        color(238, 130, 238),   // Violet
        color(255, 105, 180),   // Pink
        color(0, 255, 255)      // Cyan
      };
  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      int pos = j * columns + i;
      //text(pos, (((2 * i + 1) * rectSizeW) + ((2 * i + 1) * rectSizeW + rectSizeW))/2, (((2 * j + 1) * rectSizeH) + ((2 * j + 1) * rectSizeH + rectSizeH))/2);
      fill(colors[pos]);
      // Calculate RGB values based on position
      if (currentLevelChoosing-2 == pos) {
        stroke(255,255,255);
        strokeWeight(10);
      }
      rect((2 * i + 1) * rectSizeW, (2 * j + 1) * rectSizeH, rectSizeW, rectSizeH, 4);
      if (pos + 1 == 9) 
        fill(colors[0]);
      else 
        fill(colors[pos+1]);
      
      text(pos, (((2 * i + 1) * rectSizeW) + ((2 * i + 1) * rectSizeW + rectSizeW))/2, (((2 * j + 1) * rectSizeH) + ((2 * j + 1) * rectSizeH + rectSizeH))/2);
      noStroke();
      strokeWeight(1);
    }
  }
  textAlign(LEFT, LEFT);
      
  levelFinished = true;
}

void displayLevel(){
  lights();
  background(77,70,170);
  //background(sky);
  translate(width / 2, height / 2, zoomAmount);
  pushMatrix();            
  //translate(width / gridSize - 100, height / gridSize - 100);
  rotateX(isoThetaX);
  rotateY(isoThetaY);
  translate(shiftX,0,shiftY);
  pushMatrix();
  fill(75,50,0);
  translate(0,4001,0);
  box(currentLevel.tiles.length*50,8000,currentLevel.tiles[0].length*50);
  popMatrix();
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
  
    populateLevel();
    updateEnemies();
   
    displayEnemies();
    showAxes();
    updateTowers();
    displayTowers();
    popMatrix();
    pushMatrix();
    translate(-width/2,-height/2,-zoomAmount);
    if(inBuildMode)
      fill(0,255,0);
    else
      fill(255,0,0);
    rect(0,0,100,50);
    textSize(100);
    fill(255,255,255);
    text("Base Health: " + baseHealth,0,120);
    text("Money Left: $" + totalMoney, width-850, 120);
    popMatrix();

}

void populateLevel() {
  for(int i = 0; i < currentLevel.tiles.length; i++){
      for(int j = 0; j < currentLevel.tiles[0].length; j++){
        if(currentLevel.tiles[currentLevel.tiles.length - i - 1][j].type == 0){
         
          image(grass,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
        }
        if(currentLevel.tiles[currentLevel.tiles.length - i - 1][j].type == 1){
          //fill(255,0,0);
          pushMatrix();
          translate((i - (float)currentLevel.tiles.length / 2)*50+25,(j - (float)currentLevel.tiles[0].length / 2)*50+25,0);
          image(grass,-25,-25,50,50);
         
          rotateX(radians(90));
  
          shape(tree,0,0);
          popMatrix();
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
         
          image(grass,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
        }
        if(currentLevel.tiles[currentLevel.tiles.length - i - 1][j].type == 6){
         
          image(grass,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
        }
       
         
      }
   
    } 
}

void displayBuild() {  
  if(inBuildMode){  
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
      inBuildMode = !inBuildMode;
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
          if(inBuildMode){
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
                println("ran");
                if (++towerModelsIndex == towerModels.size()) 
                  towerModelsIndex = 0;
                
              }
            }
          }
  }
  else {

    if (key == ENTER && levelFinished) {
      if (levelNum == 1) { // select level
        levelNum = currentLevelChoosing;
        currentLevel = new Level(levelNum);
        levelFinished = false;
      }
      else {
        currentLevel = new Level(++levelNum);
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
  if (!inBuildMode) {
    for (int i = 0; i < towers.size(); i++) {
      towers.get(i).update();
    }
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
         
          shape(robot,0,0);
          enemies.get(i).healthBar();
          popMatrix();
        }

}

void updateEnemies() {
  if (inBuildMode) {
   return;
  }
  if(frameCount % spawnEveryXFrames == 0){
    if (temp) {
      spawnEnemy();
     // temp = false;
    }
  }
  for (int i = 0; i < enemies.size(); i++) {
    enemies.get(i).update();
  }
}
void spawnEnemy(){
    enemies.add(new Enemy(0,0,health,speedInverse,levelNum));
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

void showAxes(){
  stroke(255,0,0);
  line(0,0,0,100,0,0);
  stroke(0,255,0);
  line(0,0,0,0,100,0);
    stroke(0,0,255);
  line(0,0,0,0,0,100);
  noStroke();
}
