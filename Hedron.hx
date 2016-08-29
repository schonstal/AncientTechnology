package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;

class Hedron extends FlxSpriteGroup
{
  var fireTimer:Float = 0;
  var fireRate:Float = 0;

  var shadow:FlxSprite;
  var body:FlxSprite;
  var weapon:Weapon;

  var oscillator:Float;

  public function new() {
    super();
    initializeShadow();
    initializeBody();
  }

  function fire() { }

  public override function update(deltaTime:Float) {
    super.update(deltaTime);
    shadow.x = body.x;
    shadow.y = body.y + 10;
    oscillator += deltaTime;
    body.offset.y = Math.sin(oscillator * 2) * 2;
  }

  function initializeShadow() {
    if (shadow == null) {
      shadow = new FlxSprite();
      shadow.loadGraphic("assets/images/projectile_shadow.png");
      shadow.solid = false;
      Reg.dungeon.shadowGroup.add(shadow);
    }
    shadow.x = this.x;
    shadow.y = this.y;
  }

  function initializeBody() {
    if (body == null) {
      body = new FlxSprite();
      body.loadGraphic("assets/images/projectiles.png", true, 32, 32);
      body.solid = false;
      add(body);
    }
    body.x = this.x;
    body.y = this.y;
  }
}
