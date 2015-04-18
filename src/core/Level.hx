package core ;
import entities.Laser;
import geom.Vec2;
import haxe.Json;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.Lib;
import openfl.ui.Mouse;
import core.Level.MapData;
import screens.GameScreen;

/**
 * ...
 * @author Thomas BAUDON
 */

typedef MapLayerData = {
	var x : Int;
	var y : Int;
	var width : Int;
	var height : Int;
	var name : String;
	var type : String;
	var data : Array<Int>;
	var properties : Dynamic;
	var objects : Array<Dynamic>;
}

typedef MapTileSetData = {
	var firstgid : Int;
	var image : String;
	var imagewidth : Int;
	var imageheight : Int;
	var name : String;
	var properties : Dynamic;
	var tileproperties : Dynamic;
	var tilewidth : Int;
	var tileheight : Int;
	var terrains : Array<Dynamic>;
	var tiles : Dynamic;
}
 
typedef MapData = {
	var width : Int;
	var height : Int;
	var tilewidth : Int;
	var tileheight : Int;
	var layers : Array<MapLayerData>;
	var properties : Dynamic;
	var tilesets : Array<MapTileSetData>;
}

enum HitDirection {
	TOP;
	LEFT;
	RIGHT;
	BOTTOM;
}

typedef RaycastData = {
	var object : Dynamic;
	var hitPos : Vec2;
	var from : HitDirection;
}
 
class Level extends Entity
{
	
	var mLevelPath : String;
	var mTilesets : Array<TileSet>;
	var mMapData : MapData;
	var mMainLayer : TileMapLayer;
	
	var mGravity : Vec2;
	
	var mTileCoordinateRep : Vec2;
	
	var mPointer : Pointer;
	
	var mCamera : Camera;
	
	var mActorToKeep : Map<String, Actor>;
	
	var mGameScreen : GameScreen;
	
	var mLevel : String;
	
	public function new(gameScreen : GameScreen, level : String, entityToKeep : Map<String, Actor>) 
	{
		super(level);
		
		mLevelPath = "levels/" + level + ".json";
		mGravity = new Vec2(0, 1500);
		mTileCoordinateRep = new Vec2();
		mPointer = new Pointer();
		mCamera = new Camera();
		mActorToKeep = entityToKeep;
		mGameScreen = gameScreen;
		mLevel = level;
		
		Laser.All = new Array<Laser>();
	}
	
	public function load() {
		mMapData = Json.parse(Assets.getText(mLevelPath));
		loadTileSets(mMapData);
		loadLayers(mMapData);
		add(mPointer);
		mGameScreen.showDialog(mMapData.properties.levelNum);
	}
	
	public function getTilSets() : Array<TileSet>{
		return mTilesets;
	}
	
	public function getMainLayer() : TileMapLayer {
		return mMainLayer;
	}
	
	public function getGravity() 
	{
		return mGravity;
	}
	
	public function getGameScreen() : GameScreen {
		return mGameScreen;
	}
	
	inline public function getTile(px : Int, py : Int) : Int {
		return mMainLayer.getData()[px + py * mMapData.width];
	}
	
	public function getTileCoordinate(x : Float, y : Float) : Vec2 {
		x = Std.int(x);
		y = Std.int(y);
		mTileCoordinateRep.x = Math.floor(x / mMapData.tilewidth);
		mTileCoordinateRep.y = Math.floor(y / mMapData.tileheight);
		return mTileCoordinateRep;
	}
	
	public function getTileWidth() 
	{
		return mMapData.tilewidth;
	}
	
	public function getTileHeight() 
	{
		return mMapData.tileheight;
	}
	
	override function update(delta:Float) 
	{
		mCamera.update(delta);
		super.update(delta);
		
		for (laser in Laser.All){
			laser.checkIntersect();
		}
		
		pos.x = -mCamera.pos.x;
		if (pos.x > 0)
			pos.x = 0;
		else if (pos.x < (-mMapData.width + mMainLayer.getScrollWidth()-1) * mMapData.tilewidth )
			pos.x = ( -mMapData.width + mMainLayer.getScrollWidth() - 1) * mMapData.tilewidth;
			
		if (mMainLayer.getWidth() * mMapData.tilewidth < Game.getInstance().getWidth())
			pos.x =- (mMainLayer.getWidth() * mMapData.tilewidth - Game.getInstance().getWidth()) / 2;
			
		pos.x += -mCamera.shakePosOffset.x;
		
		pos.y = -mCamera.pos.y;
		if (pos.y > 0)
			pos.y = 0;
		else if (pos.y < (-mMapData.height + mMainLayer.getScrollHeight()-1) * mMapData.tileheight )
			pos.y = ( -mMapData.height + mMainLayer.getScrollHeight() - 1) * mMapData.tileheight;
			
		if (mMainLayer.getHeight() * mMapData.tileheight < Game.getInstance().getHeight())
			pos.y =- (mMainLayer.getHeight() * mMapData.tileheight - Game.getInstance().getHeight()) / 2;
		
		pos.y -= mCamera.shakePosOffset.y;
		
		var stage = Game.getInstance();
		mPointer.pos.set(Std.int(stage.mouseX / Game.getInstance().getPixelsSize()), Std.int(stage.mouseY / Game.getInstance().getPixelsSize()));
		Mouse.hide();
	}
	
	public function changeTo(levelName : String) {
		mGameScreen.loadLevel(levelName);
	}
	
	public function getPointer() : Pointer {
		return mPointer;
	}
	
	function loadTileSets(data:MapData) 
	{
		mTilesets = new Array<TileSet>();
		for (tileset in data.tilesets)
			mTilesets.push(new TileSet(tileset));
	}
	
	function loadLayers(data : MapData):Void 
	{
		for (layer in data.layers) 
			switch (layer.type) {
				case "tilelayer" :
					loadTileMapLayer(layer);
				case "objectgroup" :
					loadObjectLayer(layer);
				default :
					trace("unknown layer type");
			}
			
		if (mMainLayer == null)
			throw "No main layer";
	}
	
	function loadObjectLayer(layer:MapLayerData) 
	{
		var objects : Array<Dynamic> = layer.objects;
		for (object in objects) {
			var instance : Actor;
			if (mActorToKeep[object.name] != null) {
				instance = mActorToKeep[object.name];
			}else{
				var objectClass = Type.resolveClass(object.type);
				instance = Type.createInstance(objectClass, []);
			}
			instance.setLevel(this);
			if (Reflect.hasField(object, "properties"))
				instance.setProperties(object.properties);
			instance.pos.set(object.x, object.y);
			add(instance);
			instance.name = object.name;
			if (Reflect.hasField(object.properties, "hasFocus"))
				mCamera.setTarget(instance);
		}
	}
	
	function loadTileMapLayer(layer:MapLayerData) 
	{
		var tileMapLayer = new TileMapLayer(this, mMapData.tilewidth, mMapData.tileheight, layer);
		
		add(tileMapLayer);
		if (tileMapLayer.name == "main")
			mMainLayer = tileMapLayer;
	}
	
	public function castRay( x1 : Float, y1 : Float, x2 : Float, y2 : Float):RaycastData
	{
		var data : RaycastData = { object : null, hitPos:new Vec2(), from : TOP };
		//INITIALISE//////////////////////////////////////////
		var tileSize = mMapData.tilewidth;

		// normalise the points
		var p1:Vec2 = new Vec2( x1 / tileSize, y1 / tileSize);
		var p2:Vec2 = new Vec2( x2 / tileSize, y2 / tileSize);
	
		if ( Std.int( p1.x ) == Std.int( p2.x ) && Std.int( p1.y ) == Std.int( p2.y ) ) {
			//since it doesn't cross any boundaries, there can't be a collision
			return null;
		}
		
		//find out which direction to step, on each axis
		var stepX:Int = ( p2.x > p1.x ) ? 1 : -1;  
		var stepY:Int = ( p2.y > p1.y ) ? 1 : -1;

		var rayDirection:Vec2= new Vec2( p2.x - p1.x, p2.y - p1.y );

		//find out how far to move on each axis for every whole integer step on the other
		var ratioX:Float= rayDirection.x / rayDirection.y;
		var ratioY:Float = rayDirection.y / rayDirection.x;

		var deltaY:Float= p2.x - p1.x;
		var deltaX:Float = p2.y - p1.y;
		//faster than Math.abs()...
		deltaX = deltaX < 0 ? -deltaX : deltaX;
		deltaY = deltaY < 0 ? -deltaY : deltaY;

		//initialise the integer test coordinates with the coordinates of the starting tile, in tile space ( integer )
		//Note: using noralised version of p1
		var testX:Int = Std.int(p1.x); 
		var testY:Int = Std.int(p1.y);

		//initialise the non-integer step, by advancing to the next tile boundary / ( whole integer of opposing axis )
		//if moving in positive direction, move to end of curent tile, otherwise the beginning
		var maxX:Float = deltaX * ( ( stepX > 0 ) ? ( 1.0 - (p1.x % 1) ) : (p1.x % 1) ); 
		var maxY:Float = deltaY * ( ( stepY > 0 ) ? ( 1.0 - (p1.y % 1) ) : (p1.y % 1) );

		var endTileX : Int = Std.int(p2.x);
		var endTileY : Int = Std.int(p2.y);
		
		//TRAVERSE//////////////////////////////////////////

		var hit:Bool;
		var collisionPoint:Vec2= new Vec2();
		
		while( testX != endTileX || testY != endTileY ) {
			
			if (  maxX < maxY ) {
			
				maxX += deltaX;
				testX += stepX;
				
				var tile = getTile(testX, testY);
				var infos : TileInfo = getTileInfo(tile);
				
				if ( infos != null && infos.block ) {
					collisionPoint.x = testX;
					if ( stepX < 0 ) { 
						collisionPoint.x += 1.0; //add one if going left
						data.from = RIGHT;
					}else 
						data.from = LEFT;
					collisionPoint.y = p1.y + ratioY * ( collisionPoint.x - p1.x);	
					collisionPoint.x *= tileSize;//scale up
					collisionPoint.y *= tileSize;
					data.object = infos;
					data.hitPos = collisionPoint;
					return data;
				}
				
			} else {
				
				maxY += deltaY;
				testY += stepY;
				
				var tile = getTile(testX, testY);
				var infos : TileInfo = getTileInfo(tile);

				if ( infos != null && infos.block ) {
					collisionPoint.y = testY;
					if ( stepY < 0 ) {
						collisionPoint.y += 1.0; //add one if going up
						data.from = BOTTOM;
					}else
						data.from = TOP;
					collisionPoint.x = p1.x + ratioX * ( collisionPoint.y - p1.y);
					collisionPoint.x *= tileSize;//scale up
					collisionPoint.y *= tileSize;
					data.object = infos;
					data.hitPos = collisionPoint;
					return data;
				}
			}
	
		}
		
		//no intersection found, just return end point:
		return null;
	}
	
	
	public function getCamera() : Camera {
		return mCamera;
	}
	
	inline public function getTileTileset(tileId : Int) : TileSet {
		var rep : TileSet = null;
		for (tileset in mTilesets)
			if (tileset.hasTile(tileId)){
				rep = tileset;
				break;
			}
		return rep;
	}
	
	inline public function getTileInfoAt(x : Float, y : Float) : TileInfo { 
		if (x > -1 && x < mMapData.width && y > -1 && y < mMapData.height)
			return null;
		return getTileInfo(getTile(Std.int(x / mMapData.tilewidth), Std.int(y / mMapData.tileheight)));
	}
	
	inline public function getTileInfo(id : Int) : TileInfo {
		var tileSet = getTileTileset(id);
		if (tileSet == null) return null;
		return tileSet.getTileInfo(id);
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		super.draw(buffer, dest);
	}
	
	override public function destroy() 
	{
		super.destroy();
		
		while(children.length > 0)
		{
			var child = children.shift();
			remove(child);
			if(mActorToKeep != null && mActorToKeep[child.name] == null)
				child.destroy();
		}
		
		while (Laser.All.length > 0)
			Laser.All.pop().destroy();
		
		while (Actor.AllActors.length > 0)
			Actor.AllActors.pop().destroy();
	}
	
	public function restart() {
		mGameScreen.loadLevel(mLevel);
	}
}