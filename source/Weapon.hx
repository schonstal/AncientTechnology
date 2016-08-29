package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;

class Weapon extends FlxSpriteGroup
{
  var fireTimer:Float = 0;
  var fireRate:Float = 0;

  var shadow:FlxSprite;
  var body:FlxSprite;

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

  function initializeShadow() {
    if (shadow == null) {
      shadow = new FlxSprite();
      shadow.loadGraphic("assets/images/projectiles/shadow.png");
      shadow.solid = false;
      add(shadow);
    }
    shadow.x = this.x;
    shadow.y = this.y;
  }

  function initializeBody() {
    if (body == null) {
      body = new FlxSprite();
      body.loadGraphic("assets/images/projectiles/body.png");
      body.solid = false;
      add(body);
    }
    body.x = this.x;
    body.y = this.y;
  }
}
