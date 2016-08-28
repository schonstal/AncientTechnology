package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;

class PlasmaWeapon extends Weapon
{
  public function new() {
    super();
    fireRate = 0.25;
  }

  override function fire() {
    var direction = new FlxVector(FlxG.mouse.x - x, FlxG.mouse.y - y).normalize();
    Reg.playerProjectileService.spawn(x, y, direction);
  }

  override function shouldFire(deltaTime:Float):Bool {
    return FlxG.mouse.justPressed;
  }
}
