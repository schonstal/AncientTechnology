package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxVector;

class ProjectileSprite extends FlxSprite {
  var WIDTH = 6;
  var HEIGHT = 6;
  var dangerTimer:Float = 0;
  var dangerTime:Float = 0.04;

  public var onCollisionCallback:Void->Void;

  public function new() {
    super();

    loadGraphic('assets/images/projectiles/projectile.png', true, 16, 16);
    animation.add("pulse", [0, 1, 2], 10);
    animation.play("pulse");

    width = WIDTH;
    height = HEIGHT;
  }

  public function onCollide() {
    if(onCollisionCallback != null) onCollisionCallback();
  }

  public function initialize(direction:FlxVector, speed:Float = Projectile.SPEED):Void {
    dangerTimer = 0;
    velocity.x = direction.x * speed;
    velocity.y = direction.y * speed;
  }

  override public function updateHitbox():Void {
    var newWidth:Float = scale.x * WIDTH;
    var newHeight:Float = scale.y * HEIGHT;

    width = newWidth;
    height = newHeight;
    offset.set( - ((newWidth - frameWidth) * 0.5), - ((newHeight - frameHeight) * 0.5));
    centerOrigin();
  }

  public function isDangerous():Bool {
    return dangerTimer >= dangerTime;
  }

  override public function update(elapsed:Float):Void {
    dangerTimer += elapsed;

    super.update(elapsed);
  }
}
