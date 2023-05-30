import java.util.ArrayList;
import java.util.List;

List<Enemy> enemies = new ArrayList<Enemy>(); // List to hold the enemies

class Enemy {
  float rot = 0;
  int slowAmt = 0;
  PVector position; // Position of the enemy
  PVector interPos;
  float health; // Health of the enemy
  float maxHealth;
  float slowSpeed;
  float speedSaved;
  float speed; // Movement speed of the enemy
  Level currentLevel;
  PVector targetPos;
  PVector pathRightBefore;
  int direction;
  int tick = 0;
  boolean fixTheSpeed = false;

  Enemy(float x, float y, float health, float speed, int currentLevelNum) {
    position = new PVector(x, y);
    this.health = health;
    maxHealth = health;
    this.speed = speed;
    speedSaved = speed;
    //enemies.add(this); // Add the enemy to the list
    currentLevel = new Level(currentLevelNum);
    for(int i = 0; i < currentLevel.tiles.length; i++){
      for(int j = 0; j < currentLevel.tiles[0].length; j++){
        if(currentLevel.tiles[i][j].type == 3) {
          targetPos = new PVector(i,j);
          
        }
        else if(currentLevel.tiles[i][j].type == 4)
          position = new PVector(i,j);
      }
    }
    interPos = new PVector(position.x,position.y);
 
  }

  void update() {
    println(speed);
    println(slowAmt);
    // Move the enemy towards the target (e.g., the player's base)
    if (tick % speed == 0)
      move();
    else if(direction == 0) //down
      interPos = new PVector(interPos.x + 1/speed, interPos.y);
    else if(direction == 1) //up
      interPos = new PVector(interPos.x - 1/speed, interPos.y);
    else if(direction == 2) //left
      interPos = new PVector(interPos.x, interPos.y - 1/speed);
    else if(direction == 3) //right
      interPos = new PVector(interPos.x, interPos.y + 1/speed);
    tick++;
    
  }

  void move() {
    if (fixTheSpeed) { // check if new slows were added or removed
      speed = speedSaved + slowAmt;
      tick = 0;
      fixTheSpeed = false;
    }
    
    //takeDamage(2);
    if(direction == 0) //down
      position = new PVector(position.x + 1, position.y);
    if(direction == 1) //up
      position = new PVector(position.x - 1, position.y);
    if(direction == 2) //left
      position = new PVector(position.x, position.y - 1);
    if(direction == 3) //right
      position = new PVector(position.x, position.y +1);
    interPos = new PVector(position.x,position.y);
      
    // Move the enemy along the path or towards the target
    // not sure how to make the enmy move along the path
    if(currentLevel.tiles[(int)position.x + 1][(int)position.y].type == 2 && direction != 1){ //path down
      direction = 0;
    }
    else if(currentLevel.tiles[(int)position.x][(int)position.y - 1].type == 2 && direction != 3){ //path left
      direction = 2;
    }
    else if(currentLevel.tiles[(int)position.x][(int)position.y + 1].type == 2 && direction != 2){ //path right
      direction = 3;
    }
    else if(currentLevel.tiles[(int)position.x - 1][(int)position.y].type == 2 && direction != 0){ //path right
      direction = 1;
    }
    
    //position.x += speed;
    

    // You can also add additional logic to change direction or follow a path

    // Check if the enemy has reached the target (e.g., the player's base)
    if (reachedTarget()) {
      defeat();
      baseHealth -= 1;
    }
  }

  boolean reachedTarget() {
    // not sure how to implement this logic

    // Return true if the enemy has reached the target, otherwise false
    return position.x == targetPos.x && position.y == targetPos.y; // Replace TARGET_X_POSITION with your desired threshold value
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

  boolean defeat() {
    // Perform any necessary actions when the enemy is defeated
    // (e.g., awarding points, removing the enemy from the game)

    // Remove the enemy from the list
    boolean removed = enemies.remove(this);

    return removed; // Return true if the enemy was successfully removed, otherwise false
  }
  
  void healthBar(){
    
    pushMatrix();
    
    // keeps health bar aligned no matter rotation of model
    switch (direction) {
      case 0:
        rotateY(radians(90));
        break;
      case 1:
        rotateY(radians(-90));
        break;
      case 2:
        rotateY(radians(0));
        break;
      case 3:
        rotateY(radians(180));
        break;
    }
    
    fill(200,200,200);
    rect(0,100,50,5);
    if( health / maxHealth > 0.5)
      fill(0,255,0);
    else if(health / maxHealth > 0.25)
      fill(255,165,0);
    else
      fill(255,0,0);
    translate(0,0,-1);
    
    rect(0,100,health/maxHealth * 50,5);
    popMatrix();
    }
  
}
