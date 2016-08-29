package;

import flixel.addons.effects.FlxTrail;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.util.FlxSort;

import flash.display.BlendMode;

class Enemy extends FlxSpriteGroup
{
  inline static var SPEED = 100;

  public var enemySprite:EnemySprite;
  public var shadow:FlxSprite;

  public function new() {
    super();
    initializeShadow();
    initializeSprite();
    initializeStatus();
  }

  public override function update(deltaTime:Float) {
    processMovement();
    super.update(deltaTime);
    updateShadow();
  }

  function processMovement() {
    var direction:FlxVector = new FlxVector(0,0);

    if(direction.length > 0) {
      enemySprite.velocity.x = direction.normalize().x * SPEED;
      enemySprite.velocity.y = direction.normalize().y * SPEED;
      enemySprite.animation.play("walk");
    } else {
      enemySprite.velocity.x = enemySprite.velocity.y = 0;
      enemySprite.animation.play("idle");
    }
  }

  function initializeShadow() {
    shadow = new FlxSprite();
    shadow.loadGraphic("assets/images/player_shadow.png");
    shadow.solid = false;
    Reg.dungeon.shadowGroup.add(shadow);
  }

  function updateShadow() {
    shadow.x = enemySprite.x;
    shadow.y = enemySprite.y;
  }

  function initializeSprite() {
    enemySprite = new EnemySprite();
    add(enemySprite);
  }

  function initializeStatus() {
    health = 50;
  }
}
