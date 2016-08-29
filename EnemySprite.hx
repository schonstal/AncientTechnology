package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;

import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;

class EnemySprite extends FlxSprite implements Vulnerable
{
  var enemy:Enemy;

  public function new(enemy:Enemy) {
    super();
    loadGraphic("assets/images/enemy.png", true, 32, 32);
    animation.add("walk", [8,9,10,11,12,13,14,15], 10, true);
    animation.add("idle", [0,1,2,3], 8);
    width = 18;
    height = 8;
    offset.y = 28;

    this.enemy = enemy;
  }

  public override function update(deltaTime:Float) {
    facing = FlxG.mouse.x < x + width/2 ? FlxObject.LEFT : FlxObject.RIGHT;
    offset.x = (facing == FlxObject.RIGHT ? 6 : 8);
    super.update(deltaTime);
  }

  public function walkingBackwards():Bool {
    return (velocity.x < 0 && facing == FlxObject.RIGHT) ||
           (velocity.x > 0 && facing == FlxObject.LEFT) ||
           (velocity.x == 0 && velocity.y < 0);
  }

  public function takeDamage(amount:Float) {
    enemy.hurt(amount);
  }
}
