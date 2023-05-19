PImage grass;
PImage path;
PImage sky;
int boxPosZ = 0;
int boxPosX = 0;
boolean inBuildMode;

float isoThetaX = -atan(sin(radians(45))) + radians(5);
float isoThetaY = radians(45);
Level currentLevel;

void setup() {
    size(1600, 900, P3D);
    smooth();
    ortho();
    //noFill();
    //noStroke();
    currentLevel = new Level(1);
    grass = loadImage("grass.png");
    path = loadImage("path.png");
    sky = loadImage("sky.png");
    sky.resize(1600,900);
    //image(sky,0,0);

}
void displayLevel(){
  background(47,193,222);
  //background(sky);
  translate(width / 2, height / 2);
  pushMatrix();
            
  //translate(width / gridSize - 100, height / gridSize - 100);
  rotateX(isoThetaX);
  rotateY(isoThetaY);
  fill(0,255,0);
  box(currentLevel.tiles.length*50,25,currentLevel.tiles[0].length*50);
  translate(0, -12.6, 0);
  rotateX(PI/2);
  for(int i = 0; i < currentLevel.tiles.length; i++){
    for(int j = 0; j < currentLevel.tiles[0].length; j++){
      if(currentLevel.tiles[currentLevel.tiles.length - i - 1][j].type == 0){
        
        image(grass,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
      }
      if(currentLevel.tiles[currentLevel.tiles.length - i - 1][j].type == 1){
        fill(255,0,0);
        rect((i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
      }
      if(currentLevel.tiles[currentLevel.tiles.length - i - 1][j].type == 2){
        //fill(212,200,130);
        image(path,(i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
      }
      
    }
    
  }
  
  popMatrix();
  

}
void draw() {
    displayLevel();
    
    if(inBuildMode){
      fill(0,255,255);
    }
    else{
      fill(255,0,0);
    }
    rect(width/2-100,height/2-50,100,50);
            
            
          if(inBuildMode){  
            translate(0, 0);
            pushMatrix();
            rotateX(isoThetaX);
            rotateY(isoThetaY);
            translate((boxPosX + (float)currentLevel.tiles.length / 2)*50-25,-37, (boxPosZ -(float)currentLevel.tiles[0].length / 2)*50+25);;
            //fill(255,0,0);
            if(currentLevel.tiles[-boxPosX][boxPosZ].getCanPlaceTower()){
              stroke(0,255,0);
            }
            else{
              stroke(255,0,0);
            }
            noFill();
            box(50);
            stroke(0,0,0);
            popMatrix();
            
            textSize(100);
            fill(0,0,0);
            text(boxPosX + ", " + boxPosZ,width / 2,height / 2);
          }

              
            

            if(keyPressed == true){
              if(key == CODED && inBuildMode == false){
               if(keyCode == UP  && isoThetaX > -radians(90)){
                isoThetaX -= radians(1);
               }
               else if(keyCode == DOWN && isoThetaX < 0){
                isoThetaX += radians(1);
               }
               else if(keyCode == LEFT && isoThetaX < 0 && isoThetaY < radians(90)){
                isoThetaY += radians(1);              
              }
               else if(keyCode == RIGHT && isoThetaX < 0 && isoThetaY > 0){
                isoThetaY -= radians(1);              
              }              
             }
            }
                  
       
}

void mousePressed(){
  if(mouseX > width-100 && mouseX < width && mouseY > height-100 && mouseY < height){
    inBuildMode = !inBuildMode;
  }
  

}


void keyPressed(){
          if(key == CODED){
            if(inBuildMode){
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
            }
            
            
          }

}
