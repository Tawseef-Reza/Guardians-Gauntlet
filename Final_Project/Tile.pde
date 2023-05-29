class Tile{
  private int type;
  private boolean canPlaceTower;
  private boolean enemyWalkable;
  

  public Tile(int type){
    this.type = type;
    
    switch (type) {
     case 0: // GROUND
       canPlaceTower = true;
       enemyWalkable = false;
       break;
     case 1: //OBSTRUCTION (Tree)
      canPlaceTower = false;
      enemyWalkable = false;
       break;
     case 2: //PATH
       canPlaceTower = false;
       enemyWalkable = true;     
       break;
     case 3: //FINISH LINE
       canPlaceTower = false;
       enemyWalkable = true;
       break;
     case 4: //SPAWNER
       canPlaceTower = false;
       enemyWalkable = true;
       break;
     case 5: //TURRETTOWER
       canPlaceTower = false;
       enemyWalkable = false;
       break;
     case 6: //SLOWTOWER
       canPlaceTower = false;
       enemyWalkable = false;
       break;
    }
  }
    
    
    
  
  public int getType(){
    return type;
  }
  public boolean getCanPlaceTower(){
    return canPlaceTower;
  }
  public boolean getEnemyWalkable(){
    return enemyWalkable;
  }
}
