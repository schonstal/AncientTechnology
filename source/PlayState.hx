package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.util.FlxSort;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
  var player:Player;
  var dungeonObjects:FlxSpriteGroup;
  var reticle:Reticle;

  override public function create():Void {
    super.create();
    configure();
    registerServices();
    createDungeon();
    createPlayer();
    fillDungeon();
    add(new Reticle());
    add(new CameraObject(player.playerSprite));
    add(new Enemy());

    setWorldBounds();
  }

  override public function update(deltaTime:Float):Void {
    super.update(deltaTime);
    FlxG.collide(player, Reg.dungeon.collisionTilemap);

    dungeonObjects.sort(FlxSort.byY, FlxSort.ASCENDING);

    collideProjectiles();

    if (FlxG.keys.justPressed.Q) {
      FlxG.debugger.drawDebug = !FlxG.debugger.drawDebug;
    }
  }

  function collideProjectiles() {
    //FlxG.overlap(Reg.playerProjectileService.group, enemies);

    FlxG.collide(Reg.playerProjectileService.group, Reg.dungeon.wallTilemap, function(a,b):Void {
      if(Std.is(a, ProjectileSprite)) a.onCollide(b);
    });

    FlxG.collide(Reg.enemyProjectileService.group, Reg.dungeon.wallTilemap, function(a,b):Void {
      if(Std.is(a, ProjectileSprite)) a.onCollide(b);
    });

    FlxG.overlap(Reg.enemyProjectileService.group, player, function(a,b):Void {
      if(Std.is(a, ProjectileSprite)) a.onCollide(b);
    });
  }

  function registerServices() {
    Reg.playerProjectileService = new ProjectileService();
    Reg.enemyProjectileService = new ProjectileService();
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
  }

  function createPlayer() {
    player = new Player();
    player.x = 36;
    player.y = 0;
    dungeonObjects.add(player);
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
