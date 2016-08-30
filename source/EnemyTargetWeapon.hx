package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;

class EnemyTargetWeapon extends Weapon
{
  var offset:Float = 0;

  var resetTime:Float = 0;
  var resetDuration:Float = 1;
  var holdTime:Float = 0.05;

  public function new() {
    super();
    fireRate = 0.1;
    resetTime = Reg.random.float(0, 1);
  }

  public override function fire() {
    var direction = new FlxVector(
      Reg.player.playerSprite.getMidpoint().x - x,
      Reg.player.playerSprite.getMidpoint().y - y + 16
    ).normalize();
    Reg.enemyProjectileService.spawn(x, y, direction, 300, "enemy");
  }

  public override function shouldFire(deltaTime:Float):Bool {
    resetTime += deltaTime;
    if (resetTime > resetDuration) {
      if (resetTime > resetDuration + holdTime) {
        resetTime = 0;
      }
      return true;
    }
    return false;
  }
}
