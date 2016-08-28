package;

import flixel.util.FlxSave;
import flixel.group.FlxGroup;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import haxe.ds.StringMap;
import Type;

class Reg {
  static var services:StringMap<Dynamic> = new StringMap<Dynamic>();

  public static function register<T>(group:FlxSpriteGroup) {
    services.set(Type.getClassName(T), new Service<T>());
  }

  public static function service<T>():Service<T> {
    return cast services.get(Type.getClassName(T));
  }
}
