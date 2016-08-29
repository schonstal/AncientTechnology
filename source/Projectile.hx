package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;
import flash.display.BlendMode;

class Projectile extends FlxSpriteGroup
{
  public inline static var SPEED = 450;

  public var direction:FlxVector;
  public var physical = true;

  var shadow:FlxSprite;
  var projectileSprite:ProjectileSprite;
  var explosionSprite:FlxSprite;
  var damage:Float = 10;

  public function new():Void {
    super();
  }

  public function initialize(X:Float, Y:Float, direction:FlxVector):Void {
    this.x = X;
    this.y = Y;
    this.direction = direction;

    initializeProjectile(direction);
    initializeShadow();
    initializeExplosion();

    physical = true;
    exists = projectileSprite.exists = shadow.exists = explosionSprite.exists = true;
  }

  public override function update(deltaTime:Float) {
    super.update(deltaTime);
    updateShadow();
  }

  function updateShadow() {
    shadow.x = projectileSprite.x;
    shadow.y = projectileSprite.y;
  }

  public function onCollide(b:FlxObject):Void {
    if(!physical) return;
    physical = false;

    explosionSprite.width = projectileSprite.width;
    explosionSprite.height = projectileSprite.height;
    explosionSprite.offset.x = projectileSprite.offset.x;
    explosionSprite.offset.y = projectileSprite.offset.y;
    explosionSprite.x = projectileSprite.x;
    explosionSprite.y = projectileSprite.y;
    explosionSprite.visible = true;
    explosionSprite.animation.play("explode");
    projectileSprite.exists = false;
    shadow.exists = false;

    if (Std.is(b, Vulnerable)) {
      b.hurt(damage);
    }
  }

  function explosionFinished(_:String):Void {
    explosionSprite.exists = false;
    exists = false;
  }

  public static function handleCollision(other, projectile):Void {
    cast(projectile, ProjectileSprite).onCollide(other);
  }

  function initializeShadow() {
    if (shadow == null) {
      shadow = new FlxSprite();
      shadow.loadGraphic("assets/images/projectile_shadow.png");
//      shadow.blend = BlendMode.ADD;
//      shadow.alpha = 0.2;
      shadow.solid = false;
      Reg.dungeon.shadowGroup.add(shadow);
    }
    shadow.x = this.x;
    shadow.y = this.y;

    /*
    shadow.width = 6;
    shadow.height = 6;

    shadow.offset.x = 29 - 3;
    shadow.offset.y = 20 - 3;
    */
    shadow.offset.x = 1;
  }

  function initializeProjectile(direction:FlxVector) {
    if (projectileSprite == null) {
      projectileSprite = new ProjectileSprite();
      projectileSprite.onCollisionCallback = onCollide;
      add(projectileSprite);
    }
    projectileSprite.x = this.x;
    projectileSprite.y = this.y;
    projectileSprite.updateHitbox();
    projectileSprite.offset.y += 16;
    projectileSprite.initialize(direction);
  }

  function initializeExplosion() {
    if (explosionSprite == null) {
      explosionSprite = new FlxSprite();
      explosionSprite.loadGraphic("assets/images/projectile_explosions.png", true, 32, 32);
      explosionSprite.animation.add("explode", [0, 1, 2, 3], 15, false);
      explosionSprite.blend = BlendMode.ADD;
      explosionSprite.solid = false;
      explosionSprite.animation.finishCallback = explosionFinished;
      add(explosionSprite);
    }

    explosionSprite.visible = false;
  }
}
