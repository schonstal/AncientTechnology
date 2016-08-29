package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;
import haxe.ds.StringMap;
import Type;

class Reg {
  public static var random:FlxRandom = new FlxRandom();

  public static var playerProjectileService:ProjectileService;
  public static var enemyProjectileService:ProjectileService;
  public static var dungeon:Dungeon;
}
