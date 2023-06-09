class Enemy2 extends Enemy{
  public Enemy2(float x, float y, float health, float speed, int currentLevelNum){
    super(x,y,health,speed,currentLevelNum);
    maxHealth = 50;
    model = robot2;
  }
}
