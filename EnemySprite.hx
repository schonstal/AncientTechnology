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
    loadGraphic("assets/images/enemy.png", true, 36, 36);
    animation.add("idle", [0], 8);
    animation.add("walk", [8], 10, true);
    animation.add("fire", [13, 14, 15, 12], 10, false);

    this.enemy = enemy;
  }

  public override function update(deltaTime:Float) {
    super.update(deltaTime);
  }

  public function takeDamage(amount:Float) {
    enemy.hurt(amount);
  }
}
