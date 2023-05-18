
int boxPosZ;
int boxPosX;
boolean inBuildMode;

float isoThetaX = -radians(0);//-atan(sin(radians(45))) + radians(5);
float isoThetaY = radians(45);
Level currentLevel;

void setup() {
    size(1600, 900, P3D);
    smooth();
    ortho();
    //noFill();
    currentLevel = new Level(1);

}
void displayLevel(){
  background(47,193,222);
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
      if(currentLevel.tiles[i][j].type == 0){
        fill(0,255,0);
      }
      if(currentLevel.tiles[i][j].type == 1){
        fill(255,0,0);
      }
      if(currentLevel.tiles[i][j].type == 2){
        fill(212,200,130);
      }
      rect((i - (float)currentLevel.tiles.length / 2)*50,(j - (float)currentLevel.tiles[0].length / 2)*50,50,50);
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
            translate(boxPosX - ((float)currentLevel.tiles.length / 2)*50+25,-37, boxPosZ -((float)currentLevel.tiles[0].length / 2)*50+25);
            fill(255,0,0);
            box(50);
            popMatrix();
          }

              
            

            if(keyPressed == true){
              if(key == CODED && inBuildMode == false){
               if(keyCode == UP  && isoThetaX > -radians(90)){
                isoThetaX -= radians(1);
               }
               else if(keyCode == DOWN && isoThetaX < 0){
                isoThetaX += radians(1);
               }
               else if(keyCode == LEFT && isoThetaX < 0){
                isoThetaY += radians(1);              
              }
               else if(keyCode == RIGHT && isoThetaX < 0){
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
              if(keyCode == UP){
              
                boxPosX += 50;
              }
              else if(keyCode == DOWN){
                boxPosX -= 50;
              }
              else if(keyCode == RIGHT){
                boxPosZ += 50;
              }
              else if(keyCode == LEFT){
                boxPosZ -= 50;
              }             
            }
            
            
          }

}
