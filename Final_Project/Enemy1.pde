class Enemy1 extends Enemy{
  public Enemy1(float x, float y, float health, float speed, int currentLevelNum){
    super(x,y,health,speed,currentLevelNum);
    maxHealth = 100;
    
    model = robot;
  }
}
