import java.util.ArrayList;
import java.util.List;

List<Tower> towers = new ArrayList<Tower>(); // List to hold the enemies


abstract class Tower {
  Enemy target;
  String type;
  float range; // Attack range of the tower
  float lastFiredTime; // Time when the tower last fired
  PVector tilePosition;
  abstract void update();

  
  abstract void displayParticles();
  abstract void delete();
}
