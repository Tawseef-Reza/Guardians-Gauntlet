class TurretTower extends Tower {
  float damage;
  float fireRate;
  color firing;
  public TurretTower(int tilePosX, int tilePosY, float range, float damage, float fireRate) {
    type = "TurretTower";
    tilePosition =  new PVector(tilePosX, tilePosY);
    this.range = range;
    this.damage = damage;
    this.fireRate = fireRate;
    lastFiredTime = millis(); // Initialize lastFiredTime with the current time
  }
  
  void update() {
    firing = color(255,0,0);
    findTarget();
    // Check if enough time has passed since the tower last fired
    if (millis() - lastFiredTime >= 1000 / fireRate) {
      // Find an enemy within the tower's range
     
      
      if (target != null) {
        
        // Attack the target
        attack(target);
        firing = color(224, 209, 36);
        lastFiredTime = millis(); // Update lastFiredTime
      }
    } 
    displayParticles();

  }
  
  void displayParticles() {
     if (target != null) {
       stroke(firing);
       strokeWeight(4);
       //line(100, 100, 100, 200, 200, 200);
        line(-((tilePosition.x - (float)currentLevel.tiles.length / 2)*50+25),(tilePosition.y - (float)currentLevel.tiles[0].length / 2)*50+25, 25, -((target.interPos.x - (float)currentLevel.tiles.length / 2)*50+25),(target.interPos.y - (float)currentLevel.tiles[0].length / 2)*50+25,30);
       strokeWeight(0);
       noStroke();  
   }
  }
  void attack(Enemy target) {
    // Inflict damage on the target
    target.takeDamage(damage);
  }

  void findTarget() {
    // Iterate through all the enemies in the game and find the closest one within range
    float closestDistance = range;
    Enemy closestEnemy = null;

    
    for (Enemy enemy : enemies) {
      float distance = tilePosition.dist(enemy.interPos);
      if (distance <= range && distance < closestDistance) {
        closestDistance = distance;
        closestEnemy = enemy;
      }
    }
    
    target = closestEnemy;
  }
  
  void delete(){
    towers.remove(this);
    totalMoney += price[0] / 2;
  }
}
