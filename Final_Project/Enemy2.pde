class Enemy2 extends Enemy{
  public Enemy2(float x, float y, float health, float speed, int currentLevelNum){
    super(x,y,health,speed,currentLevelNum);
    maxHealth = 50;
    model = robot2;
  }
  void takeDamage(float damage) {
    // Reduce the enemy's health by the given damage amount
    health -= damage;

    // Check if the enemy has been defeated
    if (health <= 0) {
      defeat();
      totalMoney += 20;
    }
  }
}
