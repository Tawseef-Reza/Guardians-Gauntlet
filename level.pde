public class Level{

  private Tile[][] tiles;
  public Level(int levelNumber){
    if(levelNumber == 1){
      tiles = new Tile[][] {{new Tile(0),new Tile(0),new Tile(0),new Tile(2),new Tile(0)},
                            {new Tile(0),new Tile(0),new Tile(0),new Tile(2),new Tile(0)},
                            {new Tile(0),new Tile(0),new Tile(0),new Tile(2),new Tile(0)},
                            {new Tile(0),new Tile(0),new Tile(0),new Tile(2),new Tile(0)},
                            {new Tile(0),new Tile(0),new Tile(0),new Tile(2),new Tile(0)},
                            {new Tile(0),new Tile(0),new Tile(0),new Tile(2),new Tile(0)}};
    }
  }
}
