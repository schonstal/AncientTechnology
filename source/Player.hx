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

class Player extends FlxSpriteGroup
{
  inline static var SPEED = 100;

  public var weapons:Array<Weapon>;
  public var activeWeapon:Weapon;

  public var playerSprite:PlayerSprite;

  public function new() {
    super();
    initializeSprite();
    initializeWeapons();
  }

  public override function update(deltaTime:Float) {
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
      playerSprite.velocity.x = direction.normalize().x * SPEED;
      playerSprite.velocity.y = direction.normalize().y * SPEED;
      if(playerSprite.walkingBackwards()) {
        playerSprite.animation.play("walkBackwards");
      } else {
        playerSprite.animation.play("walk");
      }
    } else {
      playerSprite.velocity.x = playerSprite.velocity.y = 0;
      playerSprite.animation.play("idle");
    }
  }

  function updateWeapon(deltaTime:Float) {
    if (activeWeapon != null) {
      activeWeapon.update(deltaTime);
    }
  }

  function initializeSprite() {
    playerSprite = new PlayerSprite();
    add(playerSprite);
  }

  function initializeWeapons() {
    weapons = new Array<Weapon>();
    weapons.push(new PlasmaWeapon());
    activeWeapon = weapons[0];
  }
}
