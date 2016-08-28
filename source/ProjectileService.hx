package;

import flixel.group.FlxGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class ProjectileService {
  public var group:FlxTypedGroup<Projectile>;
  var objects:Array<Projectile> = new Array<Projectile>();

  public function new() {
    this.objects = new Array<Projectile>();
    this.group = new FlxTypedGroup<Projectile>();
  }

  public function spawn(X:Float, Y:Float, direction:FlxVector):Projectile {
    for(object in objects) {
      if(!object.exists) {
        return object;
      }
    }

    var object:Projectile = new Projectile();
    objects.push(object);

    group.add(object);

    object.initialize(X, Y, direction);
    return object;
  }
}
