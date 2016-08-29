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

  public function new():Void {
    super();
  }

  public function initialize(X:Float, Y:Float, direction:FlxVector):Void {
    this.x = X;
    this.y = Y;
    this.direction = direction;

    initializeShadow();
    initializeProjectile(direction);
    initializeExplosion();

    physical = true;
    exists = projectileSprite.exists = shadow.exists = explosionSprite.exists = true;
  }

  public override function update(deltaTime:Float) {
    super.update(deltaTime);
    updateShadow();
  }

  function updateShadow() {
    shadow.x = this.projectileSprite.x;
    shadow.y = this.projectileSprite.y + 10;
  }

  public function onCollide():Void {
    if(!physical) return;
    physical = false;

    explosionSprite.x = projectileSprite.x - 5;
    explosionSprite.y = projectileSprite.y - 5;
    explosionSprite.visible = true;
    explosionSprite.animation.play("explode");
    projectileSprite.exists = false;
  }

  function explosionFinished(_:String):Void {
    explosionSprite.exists = false;
    exists = false;
  }

  public static function handleCollision(other, projectile):Void {
    cast(projectile, ProjectileSprite).onCollide();
  }

  function initializeShadow() {
    if (shadow == null) {
      shadow = new FlxSprite();
      shadow.loadGraphic("assets/images/projectile_glow.png");
      shadow.blend = BlendMode.ADD;
      shadow.alpha = 0.2;
      shadow.solid = false;
      Reg.dungeon.shadowGroup.add(shadow);
    }
    shadow.x = this.x;
    shadow.y = this.y;
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
      explosionSprite.loadGraphic("assets/images/projectile_explosions.png", true, 32, 32);
      explosionSprite.animation.add("explode", [0, 1, 2, 3], 10, false);
      explosionSprite.blend = BlendMode.ADD;
      explosionSprite.solid = false;
      explosionSprite.animation.finishCallback = explosionFinished;
      add(explosionSprite);
    }

    explosionSprite.visible = false;
  }
}
