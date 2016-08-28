package;

import haxe.macro.Expr;
import flixel.group.FlxGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;
import flixel.FlxBasic;

class Service<T:FlxBasic> {
  public var group:FlxTypedGroup<T>;
  var objects:Array<T> = new Array<T>();

  public function new() {
    this.objects = new Array<T>();
    this.group = new FlxTypedGroup<T>();
  }

  macro public function spawn(extra:Array<Expr>):T {
    for(object in objects) {
      if(!object.exists) {
        return object;
      }
    }

    var object:T = new T();
    objects.push(object);

    group.add(object);

    Reflect.callMethod(object, object.initialize, extra);

    return object;
  }
}
