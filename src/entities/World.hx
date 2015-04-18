package entities;
import core.Camera;
import core.Entity;
import core.Game;
import geom.Vec2;
import openfl.display.BitmapData;

/**
 * ...
 * @author TBaudon
 */
class World extends Entity
{
	
	var mCamera : Camera;
	
	var mBuildings : Array<Entity>;
	var mRoads : Array<Entity>;
	
	var mActors : Array<Actor>;
	var mActorsToDestroy : Array<Actor>;
	
	var mGame : Game;
	
	var mMaxScroll : Float;

	public function new() 
	{
		super("World");
		
		mGame = Game.getInstance();
		
		mCamera = new Camera();
		
		mBuildings = new Array<Entity>();
		
		var prevB : Building = null;
		
		mMaxScroll = 300;
		
		for (i in 0 ... 10) {
			var b = new Building();
			mBuildings.push(b);
			if (prevB == null)
				b.pos.x = 0;
			else
				b.pos.x = prevB.pos.x + prevB.getDim().x;
			prevB = b;
			b.pos.y = mGame.getHeight() / 2 - b.getDim().y - 20;
			add(b);
		}
		
		mRoads = new Array<Entity>();
		mActors = new Array<Actor>();
		mActorsToDestroy = new Array<Actor>();
	}
	
	public function addActor(actor : Actor) {
		mActors.push(actor);	
		add(actor);
		actor.setOthersActors(mActors);
	}
	
	override function update(delta:Float) 
	{
		super.update(delta);
		
		mCamera.update(delta);
		
		pos.x = -mCamera.pos.x;
		
		if (pos.x > 0)
			pos.x = 0;
		
		if (pos.x < -mMaxScroll )
			pos.x = -mMaxScroll;
			
		pos.x += mCamera.shakePosOffset.x;
		pos.y += mCamera.shakePosOffset.y;
		
		manageActors();
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		super.draw(buffer, dest);
	}
	
	function manageActors() {
		for (actor in mActors) {
			if (actor.destroyable()){
				mActorsToDestroy.push(actor);
				continue;
			}
				
			zSortActors(actor);
		}
		
		for (actor in mActorsToDestroy)
		{
			mActors.remove(actor);
			remove(actor);
		}
	}
	
	function zSortActors(actor : Actor):Void 
	{
		for (otherActor in mActors) {
			if (otherActor.pos.y + otherActor.getDim().y < actor.pos.y + actor.getDim().y &&
				children.indexOf(otherActor) > children.indexOf(actor))
				swap(otherActor, actor);
		}
	}
	
	public function focus(ent : Entity) {
		mCamera.setTarget(ent);
	}
	
	public function setMaxScroll(scroll : Float) {
		mMaxScroll = -scroll - mGame.getWidth();
	}
	
	
}