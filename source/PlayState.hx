package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.util.FlxSort;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
  var player:Player;
  var dungeon:Dungeon;
  var dungeonObjects:FlxTypedGroup<FlxObject>;
  var projectiles:FlxTypedGroup<FlxObject>;

  override public function create():Void {
    super.create();
    configure();
    initializeProjectiles();
    createDungeon();
    createPlayer();
    fillDungeon();
    add(new Reticle());
    add(new CameraObject(player));

    setWorldBounds();
  }

  override public function update(deltaTime:Float):Void {
    FlxG.collide(player, dungeon.collisionTilemap);
    super.update(deltaTime);
    FlxG.collide(player, dungeon.collisionTilemap);

    FlxG.collide(G.projectiles, dungeon.wallTilemap, function(a,b):Void {
      if(Std.is(a, ProjectileSprite)) a.onCollide();
    });

    dungeonObjects.sort(FlxSort.byY, FlxSort.ASCENDING);
  }

  function initializeProjectiles() {
    Projectile.init();
    G.projectiles = new FlxTypedGroup<FlxObject>();
  }

  function createDungeon() {
    dungeon = new Dungeon();
    add(dungeon);

    dungeonObjects = new FlxTypedGroup<FlxObject>();
  }

  function fillDungeon() {
    add(dungeonObjects);
    add(dungeon.wallTopTilemap);
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
    FlxG.worldBounds.x = dungeon.wallTilemap.x;
    FlxG.worldBounds.y = dungeon.wallTilemap.y;
  }
}
