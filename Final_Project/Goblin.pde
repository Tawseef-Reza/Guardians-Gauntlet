class Goblin extends Enemy{
  public Goblin(float x, float y, float health, float speed, int currentLevelNum){
    super(x,y,health,speed,currentLevelNum);
    maxHealth = 200;
    model = goblin;
  }
}
