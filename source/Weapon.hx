package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class Weapon extends FlxObject
{
  public var fireRate:Float = 0;

  public function initialize():Void {
  }

  public override function update(deltaTime:Float):Void {
    super.update(deltaTime);
  }

  public function fire() { }
  public function shouldFire(deltaTime:Float):Bool { return false; }
}
