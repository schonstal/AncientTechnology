package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;

class EnemyOmniWeapon extends Weapon
{
  var offset:Float = 0;

  public function new() {
    super();
    fireRate = 0.2;
  }

  public override function fire() {
    var direction = new FlxVector(FlxG.mouse.x - x, FlxG.mouse.y - y + 16).normalize();

    for (i in 0...20) {
      var direction = new FlxVector(Math.sin(i/20 * 2 * Math.PI + offset), Math.cos(i/20 * 2 * Math.PI + offset));
      Reg.enemyProjectileService.spawn(x, y, direction, 300, "enemy");
    }
  }

  public override function shouldFire(deltaTime:Float):Bool {
    offset += deltaTime;
    return true; //FlxG.mouse.justPressed;
  }
}
