class Tile{
  private int type;
  private boolean canPlaceTower;
  private boolean enemyWalkable;
  

  public Tile(int type){
    this.type = type;
    if(type == 0){//GROUND
      canPlaceTower = true;
      enemyWalkable = false;
    }
    if(type == 1){//OBSTRUCTION
      canPlaceTower = true;
      enemyWalkable = false;
    }
    if(type == 2){//PATH
      canPlaceTower = false;
      enemyWalkable = true;
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
