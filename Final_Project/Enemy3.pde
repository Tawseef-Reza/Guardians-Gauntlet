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
     void takeDamage(float damage) {
    // Reduce the enemy's health by the given damage amount
    health -= damage;

    // Check if the enemy has been defeated
    if (health <= 0) {
      defeat();
      totalMoney += 40;
    }
  }
}
