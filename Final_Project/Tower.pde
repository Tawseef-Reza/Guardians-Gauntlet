/*class Tower {
  PVector position; // Position of the tower
  float range; // Attack range of the tower
  float damage; // Damage inflicted by the tower
  float fireRate; // Rate of fire of the tower
  float lastFiredTime; // Time when the tower last fired

  Tower(float x, float y, float z, float range, float damage, float fireRate) {
    position = new PVector(x, y, z);
    this.range = range;
    this.damage = damage;
    this.fireRate = fireRate;
    lastFiredTime = millis(); // Initialize lastFiredTime with the current time
  }

  void update() {
    // Check if enough time has passed since the tower last fired
    if (millis() - lastFiredTime >= 1000 / fireRate) {
      // Find an enemy within the tower's range
      Enemy target = findTarget();
      if (target != null) {
        // Attack the target
        attack(target);
        lastFiredTime = millis(); // Update lastFiredTime
      }
    }
  }

  void attack(Enemy target) {
    // Inflict damage on the target
    target.takeDamage(damage);
  }

  Enemy findTarget() {
    // Iterate through all the enemies in the game and find the closest one within range
    float closestDistance = range;
    Enemy closestEnemy = null;

    for (Enemy enemy : enemies) {
      float distance = position.dist(enemy.position);
      if (distance <= range && distance < closestDistance) {
        closestDistance = distance;
        closestEnemy = enemy;
      }
    }

    return closestEnemy;
  }
}*/
