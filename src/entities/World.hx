package entities;
import core.Camera;
import core.Entity;

/**
 * ...
 * @author TBaudon
 */
class World extends Entity
{
	
	var mCamera : Camera;
	
	var mBuildings : Array<Entity>;
	var mRoads : Array<Entity>;

	public function new() 
	{
		super("World");
		
		mCamera = new Camera();
		
		mBuildings = new Array<Entity>();
		mRoads = new Array<Entity>();
	}
	
	override function update(delta:Float) 
	{
		super.update(delta);
		
		mCamera.update(delta);
		
		pos.x = -mCamera.pos.x;
	}
	
	public function focus(ent : Entity) {
		mCamera.setTarget(ent);
	}
	
	
}