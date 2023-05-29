import java.util.ArrayList;
import java.util.List;

class SlowTower extends Tower {
  float slowIntensity;
  ArrayList<Enemy> targets;
  //boolean multiple;
  public SlowTower(int tilePosX, int tilePosY, float range, float slowIntensity) {
      type = "SlowTower";
      targets = new ArrayList<Enemy>();
      tilePosition =  new PVector(tilePosX, tilePosY);
      this.range = range;
      this.slowIntensity = slowIntensity;
  }
  void update() {
    editTargets();
    displayParticles();
  }
  void displayParticles() {
    if (targets.size() != 0) {
      for (Enemy target : targets) {
       stroke(0, 0, 255);
       strokeWeight(4);
       //line(100, 100, 100, 200, 200, 200);
        line(-((tilePosition.x - (float)currentLevel.tiles.length / 2)*50+25),(tilePosition.y - (float)currentLevel.tiles[0].length / 2)*50+25, 25, -((target.interPos.x - (float)currentLevel.tiles.length / 2)*50+25),(target.interPos.y - (float)currentLevel.tiles[0].length / 2)*50+25,30);
       strokeWeight(0);
       noStroke();  
      }
   }
  }
  
  void editTargets() {
    ArrayList<Enemy> allTargets = new ArrayList<Enemy>();
    for (Enemy enemy : enemies) {
      float distance = tilePosition.dist(enemy.interPos);
      if (distance <= range) {
        allTargets.add(enemy);
      }
    }
    // arraylist with all new subjects
    ArrayList<Enemy> newTargets = new ArrayList<Enemy>(allTargets);
    newTargets.removeAll(targets);
    for (Enemy newTarget : newTargets) {
      newTarget.slowAmt += slowIntensity;
      newTarget.fixTheSpeed = true;
    }
      
    targets.removeAll(allTargets);
    for (Enemy target : targets) {
      target.slowAmt -= slowIntensity;
      target.fixTheSpeed = true;
    }
    targets = allTargets;
  }
}
