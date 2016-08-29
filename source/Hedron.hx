package;

import flash.display.BlendMode;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;
import flixel.math.FlxPoint;

class Hedron extends FlxSpriteGroup
{
  var fireTimer:Float = 0;

  var shadow:FlxSprite;
  var body:FlxSprite;
  var weapon:Weapon;
  var muzzleFlash:FlxSprite;

  var oscillator:Float;
  var originalOffset:Float;

  public function new() {
    super();
    initializeShadow();
    initializeBody();
    initializeMuzzleFlash();
    initializeWeapon();
  }

  function fire() {
    weapon.fire();
    body.animation.play("fire", true);
    muzzleFlash.animation.play("fire", true);
  }

  public override function update(deltaTime:Float) {
    super.update(deltaTime);
    updateOscillation(deltaTime);
    updateWeapon();

    fireTimer += deltaTime;
    if (fireTimer >= weapon.fireRate && weapon.shouldFire(deltaTime)) {
      fire();
      fireTimer = 0;
    }

    muzzleFlash.x = body.x;
    muzzleFlash.y = body.y;
  }

  function updateOscillation(deltaTime:Float) {
    oscillator += deltaTime;
    body.offset.y = originalOffset + Math.sin(oscillator * 3);
  }

  public function updateShadow() {
    shadow.x = body.x;
    shadow.y = body.y;
  }

  function initializeWeapon() {
    weapon = new PlasmaWeapon();
  }

  function updateWeapon() {
    weapon.x = body.x;
    weapon.y = body.y;
  }

  function initializeShadow() {
    if (shadow == null) {
      shadow = new FlxSprite();
      shadow.loadGraphic("assets/images/projectile_shadow.png");
      shadow.solid = false;
      Reg.dungeon.shadowGroup.add(shadow);
    }
    shadow.x = this.x;
    shadow.y = this.y;
    shadow.updateHitbox();
  }

  function initializeBody() {
    if (body == null) {
      body = new FlxSprite();
      body.loadGraphic("assets/images/hedron.png", true, 32, 32);
      body.animation.add("idle", [0]);
      body.animation.add("fire", [1, 1, 2, 3, 4, 0], 20, false);
      body.solid = false;
      add(body);
    }
    body.x = this.x;
    body.y = this.y;

    body.offset.x = body.width/2 - shadow.width/2;
    body.offset.y = body.height/2 - shadow.width/2 + 16;

    body.width = shadow.width;
    body.height = shadow.height;

    originalOffset = body.offset.y;
  }

  function initializeMuzzleFlash() {
    if (muzzleFlash == null) {
      muzzleFlash = new FlxSprite();
      muzzleFlash.loadGraphic("assets/images/hedron_flash.png", true, 32, 32);
      muzzleFlash.animation.add("idle", [3]);
      muzzleFlash.animation.add("fire", [0, 1, 2, 3], 20, false);
      muzzleFlash.solid = false;
      muzzleFlash.blend = BlendMode.ADD;
      muzzleFlash.animation.play("idle");
      add(muzzleFlash);
    }
    muzzleFlash.x = this.x;
    muzzleFlash.y = this.y;

    muzzleFlash.offset.x = muzzleFlash.width/2 - shadow.width/2;
    muzzleFlash.offset.y = muzzleFlash.height/2 - shadow.width/2 + 16;

    muzzleFlash.width = shadow.width;
    muzzleFlash.height = shadow.height;
  }
}
