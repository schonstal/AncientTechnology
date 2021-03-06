package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;

import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;

class PlayerSprite extends FlxSprite implements Vulnerable
{
  var player:Player;

  public function new(player:Player) {
    super();
    loadGraphic("assets/images/player.png", true, 32, 32);
    setFacingFlip(FlxObject.RIGHT, true, false);
    setFacingFlip(FlxObject.LEFT, false, false);
    animation.add("walk", [8,9,10,11,12,13,14,15], 10, true);
    animation.add("walkBackwards", [23,16,17,18,19,21,22], 10, true);
    animation.add("idle", [0,1,2,3], 8);
    animation.callback = onAnimate;
    width = 18;
    height = 8;
    offset.y = 28;

    this.player = player;
  }

  public override function update(deltaTime:Float) {
    facing = FlxG.mouse.x < x + width/2 ? FlxObject.LEFT : FlxObject.RIGHT;
    offset.x = (facing == FlxObject.RIGHT ? 6 : 8);
    super.update(deltaTime);
  }

  public function walkingBackwards():Bool {
    return (velocity.x < 0 && facing == FlxObject.RIGHT) ||
           (velocity.x > 0 && facing == FlxObject.LEFT) ||
           (velocity.x == 0 && velocity.y < 0);
  }

  public function takeDamage(amount:Float) {
    player.hurt(amount);
  }

  function onAnimate(name:String, frame:Int, frameIndex:Int) {
    if (name == "walk" || name == "walkBackwards") {
      if (frame == 0 || frame == 4) {
        FlxG.sound.play("assets/sounds/footsteps/" + Reg.random.int(1,2) + ".wav", 0.3);
      }
    }
  }
}
