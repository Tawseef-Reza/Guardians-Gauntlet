class Enemy4 extends Enemy{
  public Enemy4(float x, float y, float health, float speed, int currentLevelNum){
    super(x,y,health,speed,currentLevelNum);
    maxHealth = 100;
    
    switch (currentLevelNum) {
      case 2:
        model = robot2Upgrade1;
        break;
      case 3:
        model = robot2Upgrade2;
        break;
      case 4:
        model = robot2Upgrade3;
        break;
      case 5:
        model = robot2Upgrade4;
        break;
    }  
  }
}
