package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.math.FlxPoint;

class CameraObject extends FlxObject
{
  private var objectToFollow:FlxObject;

  public function new(objectToFollow:FlxObject) {
    super();
    this.objectToFollow = objectToFollow;
    FlxG.camera.follow(this);
  }

  public override function update(deltaTime:Float):Void {
    x = (FlxG.mouse.x + objectToFollow.x*3)/4;
    y = (FlxG.mouse.y + objectToFollow.y*3)/4;

    super.update(deltaTime);
  }
}
