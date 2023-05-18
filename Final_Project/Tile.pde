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
     case 1: //OBSTRUCTION
      canPlaceTower = false;
      enemyWalkable = false;
       break;
     case 2: //PATH
       canPlaceTower = false;
       enemyWalkable = true;     
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
