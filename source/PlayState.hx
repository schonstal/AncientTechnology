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

    setWorldBounds();
  }

  override public function update(deltaTime:Float):Void {
    FlxG.collide(player, Reg.dungeon.collisionTilemap);
    super.update(deltaTime);
    FlxG.collide(player, Reg.dungeon.collisionTilemap);

    FlxG.collide(Reg.playerProjectileService.group, Reg.dungeon.wallTilemap, function(a,b):Void {
      if(Std.is(a, ProjectileSprite)) a.onCollide();
    });

    dungeonObjects.sort(FlxSort.byY, FlxSort.ASCENDING);
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
    FlxG.debugger.drawDebug = true;
    FlxG.debugger.visible = true;
  }

  function setWorldBounds() {
    FlxG.worldBounds.width = FlxG.worldBounds.height = Dungeon.SIZE * 32;
    FlxG.worldBounds.x = Reg.dungeon.wallTilemap.x;
    FlxG.worldBounds.y = Reg.dungeon.wallTilemap.y;
  }
}
