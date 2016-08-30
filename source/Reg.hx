package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;
import flixel.math.FlxPoint;

class Reg {
  public static var random:FlxRandom = new FlxRandom();

  public static var playerProjectileService:ProjectileService;
  public static var enemyProjectileService:ProjectileService;
  public static var dungeon:Dungeon;
  public static var player:Player; // It's a game jam!
  public static var enemyLocations:Array<FlxPoint>;
}
