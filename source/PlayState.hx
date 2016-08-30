package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.util.FlxSort;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;

class PlayState extends FlxState
{
  var dungeonObjects:FlxSpriteGroup;
  var reticle:Reticle;
  var enemies:FlxSpriteGroup;

  override public function create():Void {
    super.create();
    configure();
    registerServices();
    createDungeon();
    createPlayer();
    fillDungeon();
    add(new Reticle());
    add(new CameraObject(Reg.player.playerSprite));

    setWorldBounds();
  }

  override public function update(deltaTime:Float):Void {
    super.update(deltaTime);
    FlxG.collide(Reg.player, Reg.dungeon.collisionTilemap);

    dungeonObjects.sort(FlxSort.byY, FlxSort.ASCENDING);

    collideProjectiles();

    if (FlxG.keys.justPressed.Q) {
      FlxG.debugger.drawDebug = !FlxG.debugger.drawDebug;
    }
  }

  function collideProjectiles() {
    FlxG.overlap(Reg.playerProjectileService.group, enemies, function(a,b):Void {
      if(Std.is(a, ProjectileSprite)) a.onCollide(b);
    });

    FlxG.collide(Reg.playerProjectileService.group, Reg.dungeon.wallTilemap, function(a,b):Void {
      if(Std.is(a, ProjectileSprite)) a.onCollide(b);
    });

    FlxG.collide(Reg.enemyProjectileService.group, Reg.dungeon.wallTilemap, function(a,b):Void {
      if(Std.is(a, ProjectileSprite)) a.onCollide(b);
    });

    FlxG.overlap(Reg.enemyProjectileService.group, Reg.player, function(a,b):Void {
      if(Std.is(a, ProjectileSprite)) a.onCollide(b);
    });
  }

  function registerServices() {
    Reg.playerProjectileService = new ProjectileService();
    Reg.enemyProjectileService = new ProjectileService();
    Reg.enemyLocations = [];
  }

  function createDungeon() {
    Reg.dungeon = new Dungeon();
    add(Reg.dungeon);

    dungeonObjects = new FlxSpriteGroup();
  }

  function fillDungeon() {
    add(dungeonObjects);
    add(Reg.playerProjectileService.group);
    add(Reg.enemyProjectileService.group);
    add(Reg.dungeon.wallTopTilemap);

    enemies = new FlxSpriteGroup();
    for (point in Reg.enemyLocations) {
      var enemy = new Enemy();
      enemy.x = point.x * 32;
      enemy.y = point.y * 32;
      dungeonObjects.add(enemy);
      enemies.add(enemy);
    }
  }

  function createPlayer() {
    Reg.player = new Player();
    Reg.player.x = 36;
    Reg.player.y = 0;
    dungeonObjects.add(Reg.player);
  }

  function configure() {
    FlxG.mouse.visible = false;
  }

  function setWorldBounds() {
    FlxG.worldBounds.width = FlxG.worldBounds.height = Dungeon.SIZE * 32;
    FlxG.worldBounds.x = Reg.dungeon.wallTilemap.x;
    FlxG.worldBounds.y = Reg.dungeon.wallTilemap.y;
  }
}
