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
