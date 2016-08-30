package;

import flixel.FlxObject;
import flixel.math.FlxRandom;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;

class DungeonTiles
{
  inline static var BRUSH_SIZE = 2;

  public var tiles:Array<Array<Int>>;
  public var width:Int;
  public var height:Int;

  var position:FlxPoint;
  var direction:FlxVector;

  var dirty:Bool = false;

  public function new(width:Int, height:Int) {
    this.width = width;
    this.height = height;
    position = new FlxPoint(width/2-1, height/2);
    direction = new FlxVector(1,0);

    generateTiles();
  }

  private function generateTiles():Void {
    tiles = new Array<Array<Int>>();
    for(y in 0...height) {
      tiles[y] = new Array<Int>();
      for(x in 0...width) {
        tiles[y][x] = 0;
      }
    }

    for(i in 0...401) {
      position.x += direction.x;
      position.y += direction.y;

      var localSize = BRUSH_SIZE + ((new FlxRandom().bool(5) || i == 0) ? 1 : 0);
      for(x in 0...localSize) {
        for(y in 0...localSize) {
          var localY = Std.int(position.y) + y;
          var localX = Std.int(position.x) + x;

          if (dirty) {
            tiles[localY][localX] = new FlxRandom().int(3,11);
          } else {
            tiles[localY][localX] = ((localY + localX) % 2 == 0 ? 1 : 2);
          }

          if(Reg.random.bool(0.3)) {
            Reg.enemyLocations.push(new FlxPoint(localX - Dungeon.SIZE/2, localY - Dungeon.SIZE/2));
          }
        }
      }
      changeDirection();
      getDirty();
    }
  }

  private function getDirty():Void {
    if (new FlxRandom().bool(5)) {
      dirty = !dirty;
    }
  }

  private function changeDirection():Void {
    if (new FlxRandom().bool(30) || outOfBounds()) {

      direction.x = new FlxRandom().int(-1,1);
      direction.y = new FlxRandom().int(-1,1);
    }

    if(outOfBounds())
      changeDirection();
  }

  private function outOfBounds():Bool {
    return position.x + direction.x * (BRUSH_SIZE + 1) + BRUSH_SIZE >= width ||
           position.x + direction.x * (BRUSH_SIZE + 1) < 0 ||
           position.y + direction.y * (BRUSH_SIZE + 1) + BRUSH_SIZE >= height ||
           position.y + direction.y * (BRUSH_SIZE + 1) < 0;
  }
}
