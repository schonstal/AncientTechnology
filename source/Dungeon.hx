package;

import flixel.group.FlxGroup;

import flixel.math.FlxRandom;
import flixel.util.FlxStringUtil;

import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap;
import flixel.group.FlxSpriteGroup;

class Dungeon extends FlxGroup
{
  inline public static var SIZE = 40;

  //We have to add this one separately to layer it on top
  public var wallTopTilemap:FlxTilemap;
  public var wallTilemap:FlxTilemap;
  public var collisionTilemap:FlxTilemap;
  public var groundTilemap:FlxTilemap;
  public var drapedTilemap:FlxTilemap;
  public var drapedWallTilemap:FlxTilemap;
  public var shadowGroup:FlxSpriteGroup;

  var dungeonTiles:DungeonTiles;
  var drapedTiles:DrapedTiles;
  var isometricWalls:IsometricWalls;
  var isometricTops:IsometricTops;

  public function new() {
    super();
    dungeonTiles = new DungeonTiles(SIZE,SIZE);

    groundTilemap = new FlxTilemap();
    groundTilemap.loadMapFromCSV(
      FlxStringUtil.arrayToCSV(flattenArray(dungeonTiles.tiles), SIZE),
      "assets/images/tiles.png", 32, 32, FlxTilemapAutoTiling.OFF
    );
    groundTilemap.x = -20 * 32;
    groundTilemap.y = -20 * 32;
    add(groundTilemap);

    //Invert the tiles for collision
    collisionTilemap = new FlxTilemap();
    var collisionArray:Array<Int> = flattenArray(dungeonTiles.tiles);
    for (i in 0...collisionArray.length-1) {
      if(collisionArray[i] > 0) {
        collisionArray[i] = 0;
      } else {
        collisionArray[i] = 1;
      }
    }
    collisionTilemap.loadMapFromCSV(
      FlxStringUtil.arrayToCSV(collisionArray, SIZE),
      "assets/images/tiles.png", 32, 32, FlxTilemapAutoTiling.OFF
    );
    collisionTilemap.x = groundTilemap.x;
    collisionTilemap.y = groundTilemap.y;

    shadowGroup = new FlxSpriteGroup();
    add(shadowGroup);

    isometricWalls = new IsometricWalls(dungeonTiles);
    wallTilemap = new FlxTilemap();
    wallTilemap.loadMapFromCSV(
      FlxStringUtil.arrayToCSV(flattenArray(isometricWalls.tiles), SIZE),
      "assets/images/tiles.png", 32, 32, FlxTilemapAutoTiling.OFF
    );
    wallTilemap.x = groundTilemap.x;
    wallTilemap.y = groundTilemap.y;
    add(wallTilemap);

    var draperArray:Array<Array<Int>> = new Array<Array<Int>>();
    for (y in 0...dungeonTiles.tiles.length) {
      draperArray[y] = new Array<Int>();
      for (x in 0...dungeonTiles.tiles[0].length) {
        draperArray[y][x] = ((dungeonTiles.tiles[y][x] + isometricWalls.tiles[y][x]) > 0 ? 1 : 0);
      }
    }

    drapedTiles = new DrapedTiles(draperArray);

    drapedTilemap = new FlxTilemap();
    drapedTilemap.loadMapFromCSV(
      FlxStringUtil.arrayToCSV(flattenArray(drapedTiles.tiles), SIZE),
      "assets/images/tiles.png", 32, 32, FlxTilemapAutoTiling.OFF
    );
    drapedTilemap.x = groundTilemap.x;
    drapedTilemap.y = groundTilemap.y;
    add(drapedTilemap);

    isometricTops = new IsometricTops(isometricWalls);
    wallTopTilemap = new FlxTilemap();
    wallTopTilemap.loadMapFromCSV(
      FlxStringUtil.arrayToCSV(flattenArray(isometricTops.tiles), SIZE),
      "assets/images/tiles.png", 32, 32, FlxTilemapAutoTiling.OFF
    );
    wallTopTilemap.x = groundTilemap.x;
    wallTopTilemap.y = groundTilemap.y;

    collisionTilemap.visible = false;
    add(collisionTilemap);
  }

  private function flattenArray(array:Array<Array<Int>>):Array<Int> {
    var flattenedArray = new Array<Int>(); 
    for (tileArray in array) {
      for (tile in tileArray) {
        flattenedArray.push(tile);
      }
    }

    return flattenedArray;
  }
}
