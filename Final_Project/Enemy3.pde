class Enemy3 extends Enemy{
  public Enemy3(float x, float y, float health, float speed, int currentLevelNum){
    super(x,y,health,speed,currentLevelNum);
    maxHealth = 200;
    switch (currentLevelNum) {
      case 2:
        model = robotUpgrade1;
        break;
      case 3:
        model = robotUpgrade2;
        break;
      case 4:
        model = robotUpgrade3;
        break;
      case 5:
        model = robotUpgrade4;
        break;
    }
  }
}
