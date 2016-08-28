package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;
import haxe.ds.StringMap;
import Type;

class Reg {
  public static var random:FlxRandom = new FlxRandom();

  public static var playerProjectileService:Service<Projectile>;
  public static var enemyProjectileService:Service<Projectile>;
}
