package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class Weapon extends FlxObject
{
  var fireTimer:Float = 0;
  var fireRate:Float = 0;

  public function initialize():Void {
  }

  public override function update(deltaTime:Float):Void {
    fireTimer += deltaTime;
    if (fireTimer >= fireRate && shouldFire(deltaTime)) {
      fire();
      fireTimer = 0;
    }
    super.update(deltaTime);
  }

  function fire() { }
  function shouldFire(deltaTime:Float):Bool { return false; }
}
