package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;

class Projectile extends FlxSpriteGroup
{
  public inline static var SPEED = 450;

  public var direction:FlxVector;
  public var physical = true;

  var projectileSprite:ProjectileSprite;
  var explosionSprite:FlxSprite;

  public function new():Void {
    super();
  }

  public function initialize(X:Float, Y:Float, direction:FlxVector):Void {
    this.x = X;
    this.y = Y;
    this.direction = direction;

    initializeProjectile(direction);
    initializeExplosion();

    physical = true;
  }

  public function onCollide():Void {
    if(!physical) return;
    physical = false;

    explosionSprite.x = projectileSprite.x - 5;
    explosionSprite.y = projectileSprite.y - 5;
    explosionSprite.visible = true;
    explosionSprite.animation.play("explode");
    projectileSprite.exists = false;
    //FlxG.camera.shake(0.02, 0.3);
    //FlxG.sound.play("assets/sounds/orb_explode.wav");
  }

  function explosionFinished(_:String):Void {
    explosionSprite.exists = false;
    exists = false;
  }

  public static function handleCollision(other, projectile):Void {
    cast(projectile, ProjectileSprite).onCollide();
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
    projectileSprite.initialize(direction);
  }

  function initializeExplosion() {
    if (explosionSprite == null) {
      explosionSprite = new FlxSprite();
      explosionSprite.loadGraphic('assets/images/projectiles/hit.png', true, 32, 32);
      explosionSprite.animation.add("explode", [0, 1, 2, 3, 4, 5], 15, false);
      explosionSprite.solid = false;
      explosionSprite.animation.finishCallback = explosionFinished;
      add(explosionSprite);
    }

    explosionSprite.visible = false;
  }
}
