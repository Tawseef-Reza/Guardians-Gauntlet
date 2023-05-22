import java.util.ArrayList;
import java.util.List;

List<Enemy> enemies = new ArrayList<Enemy>(); // List to hold the enemies

class Enemy {
  PVector position; // Position of the enemy
  float health; // Health of the enemy
  float speed; // Movement speed of the enemy

  Enemy(float x, float y, float z, float health, float speed) {
    position = new PVector(x, y, z);
    this.health = health;
    this.speed = speed;

    enemies.add(this); // Add the enemy to the list
  }

  void update() {
    // Move the enemy towards the target (e.g., the player's base)
    move();
  }

  void move() {
    // Move the enemy along the path or towards the target
    // not sure how to make the enmy move along the path
    position.x += speed;

    // You can also add additional logic to change direction or follow a path

    // Check if the enemy has reached the target (e.g., the player's base)
    if (reachedTarget()) {
      defeat();
    }
  }

  boolean reachedTarget() {
    // not sure how to implement this logic

    // Return true if the enemy has reached the target, otherwise false
    return position.x >= TARGET_X_POSITION; // Replace TARGET_X_POSITION with your desired threshold value
  }

  void takeDamage(float damage) {
    // Reduce the enemy's health by the given damage amount
    health -= damage;

    // Check if the enemy has been defeated
    if (health <= 0) {
      defeat();
    }
  }

  boolean defeat() {
    // Perform any necessary actions when the enemy is defeated
    // (e.g., awarding points, removing the enemy from the game)

    // Remove the enemy from the list
    boolean removed = enemies.remove(this);

    return removed; // Return true if the enemy was successfully removed, otherwise false
  }
}
