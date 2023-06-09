class Enemy1 extends Enemy{
  public Enemy1(float x, float y, float health, float speed, int currentLevelNum){
    super(x,y,health,speed,currentLevelNum);
    maxHealth = 100;
    
    model = robot;
  }
  
  void takeDamage(float damage) {
    // Reduce the enemy's health by the given damage amount
    health -= damage;

    // Check if the enemy has been defeated
    if (health <= 0) {
      defeat();
      totalMoney += 10;
    }
  }
}
