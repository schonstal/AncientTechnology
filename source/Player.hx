package;

import flixel.addons.effects.FlxTrail;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;

import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;

import flixel.math.FlxVector;
import flixel.math.FlxRandom;

import flash.display.BlendMode;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxEase.EaseFunction;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.TweenOptions;
import flixel.tweens.misc.VarTween;

class Player extends FlxSprite
{
  inline static var SPEED = 100;

  inline static var DASH_DISTANCE = 60;
  inline static var DASH_DURATION = 0.6;
  inline static var IFRAME_DURATION = 0.3;

  inline static var RECOIL_DISTANCE = -20;
  inline static var RECOIL_DURATION = 0.4;

  public var weapons:Array<Weapon>;
  public var activeWeapon:Weapon;

  public function new() {
    super();
    loadGraphic("assets/images/player.png", true, 32, 32);
    setFacingFlip(FlxObject.RIGHT, true, false);
    setFacingFlip(FlxObject.LEFT, false, false);
    animation.add("walk", [8,9,10,11,12,13,14,15], 10, true);
    animation.add("walkBackwards", [23,16,17,18,19,21,22], 10, true);
    animation.add("idle", [0,1,2,3], 8);
    animation.callback = onAnimate;
    width = 22;
    height = 12;
    offset.x = 4;
    offset.y = 20;

    weapons = new Array<Weapon>();
    weapons.push(new PlasmaWeapon());
    activeWeapon = weapons[0];
  }

  public override function update(deltaTime:Float) {
    facing = FlxG.mouse.x < x + width/2 ? FlxObject.LEFT : FlxObject.RIGHT;
    processMovement();
    updateWeapon(deltaTime);
    super.update(deltaTime);
  }

  function processMovement() {
    var direction:FlxVector = new FlxVector(0,0);

    if(FlxG.keys.pressed.W) {
      direction.y = -1;
    }
    if(FlxG.keys.pressed.S) {
      direction.y = 1;
    }
    if(FlxG.keys.pressed.A) {
      direction.x = -1;
    }
    if(FlxG.keys.pressed.D) {
      direction.x = 1;
    }

    if(direction.length > 0) {
      velocity.x = direction.normalize().x * SPEED;
      velocity.y = direction.normalize().y * SPEED;
      if(walkingBackwards()) {
        animation.play("walkBackwards");
      } else {
        animation.play("walk");
      }
    } else {
      velocity.x = velocity.y = 0;
      animation.play("idle");
    }
  }

  function updateWeapon(deltaTime:Float) {
    if (activeWeapon != null) {
      activeWeapon.update(deltaTime);
    }
  }

  function walkingBackwards():Bool {
    return (velocity.x < 0 && facing == FlxObject.RIGHT) ||
           (velocity.x > 0 && facing == FlxObject.LEFT) ||
           (velocity.x == 0 && velocity.y < 0);
  }

  function onAnimate(name:String, frame:Int, frameIndex:Int) {
    if (name == "walk" || name == "walkBackwards") {
      if (frame == 0 || frame == 4) {
        FlxG.sound.play("assets/sounds/footsteps/" + new FlxRandom().int(1,2) + ".wav", 0.3);
      }
    }
  }
}
