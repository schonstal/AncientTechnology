package;

import flixel.addons.effects.FlxTrail;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.util.FlxSort;

import flash.display.BlendMode;

class Player extends FlxSpriteGroup
{
  inline static var SPEED = 100;

  public var hedron:Hedron;
  public var playerSprite:PlayerSprite;
  public var shadow:FlxSprite;

  public function new() {
    super();
    initializeShadow();
    initializeSprite();
    initializeHedron();
  }

  public override function update(deltaTime:Float) {
    processMovement();
    super.update(deltaTime);
    updateShadow();
    updateHedron();
    sortEntities();
  }

  function sortEntities() {
    sort(FlxSort.byY, FlxSort.ASCENDING);
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

  function initializeShadow() {
    shadow = new FlxSprite();
    shadow.loadGraphic("assets/images/player_shadow.png");
    shadow.solid = false;
    Reg.dungeon.shadowGroup.add(shadow);
  }

  function updateShadow() {
    shadow.x = playerSprite.x;
    shadow.y = playerSprite.y;
  }

  function updateHedron() {
    var direction:FlxVector = new FlxVector(
      FlxG.mouse.x - playerSprite.getMidpoint().x,
      FlxG.mouse.y - playerSprite.getMidpoint().y
    ).normalize();

    var magnitude:Float = 18;

    hedron.x = shadow.getMidpoint().x + direction.x * magnitude - hedron.width/2;
    hedron.y = shadow.getMidpoint().y + direction.y * magnitude - hedron.height/2;
    hedron.updateShadow();
  }

  function initializeSprite() {
    playerSprite = new PlayerSprite();
    add(playerSprite);
  }

  function initializeHedron() {
    hedron = new Hedron();
    add(hedron);
  }
}
