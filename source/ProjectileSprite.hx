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

  public var onCollisionCallback:FlxObject->Void;

  public function new() {
    super();

    loadGraphic('assets/images/projectiles.png', true, 32, 32);
    animation.add("pulse-player", [0, 1], 10);
    animation.add("pulse-enemy", [2, 3], 10);
    animation.play("pulse-player");

    width = WIDTH;
    height = HEIGHT;
  }

  public function onCollide(other) {
    if(onCollisionCallback != null) onCollisionCallback(other);
  }

  public function initialize(direction:FlxVector, speed:Float, style:String):Void {
    dangerTimer = 0;
    velocity.x = direction.x * speed;
    velocity.y = direction.y * speed;
    animation.play('pulse-$style', true);
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
