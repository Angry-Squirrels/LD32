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
	var mBuildingsContainer : Entity;
	
	var mRoadContainer : Entity;
	var mRoads : Array<Entity>;
	
	var mActors : Array<Actor>;
	var mActorsToDestroy : Array<Actor>;
	
	var mGame : Game;
	
	var mMaxScroll : Float;
	
	var mGenerationTimes : UInt;
	var mThroneContainer:Entity;

	public function new() 
	{
		super("World");
		
		mGame = Game.getInstance();
		
		mRoads = new Array<Entity>();
		mRoadContainer = new Entity();
		add(mRoadContainer);
		
		mGenerationTimes = 0;
		
		mCamera = new Camera();
		
		mBuildings = new Array<Entity>();
		mBuildingsContainer = new Entity("buildings");
		add(mBuildingsContainer);
		
		mThroneContainer = new Entity("fsdf");
		add(mThroneContainer);
		
		mMaxScroll = 0;
		
		mActors = new Array<Actor>();
		mActorsToDestroy = new Array<Actor>();
	}
	
	public function generateBuilding(maxX : Int) {
		
		mGenerationTimes++;
		mMaxScroll = maxX - mGame.getWidth();
		
		var lastX = 0;
		
		do {
			lastX = addABuilding();
		}while (lastX < maxX);
		
		lastX = 0;
		
		do {
			lastX = addARoad();
		}while (lastX < maxX);
		
	}
	
	public function addThrone(throne : Throne) {
		mThroneContainer.add(throne);
	}
	
	public function getMaxScroll() : Float {
		return mMaxScroll;
	}
	
	public function addABuilding() : Int {
		var building : Building;
		
		if(mBuildings.length == 0){
			building = new Building(true);
			//mRoads.push(building);
		}
		else {
			if(mGenerationTimes > 4){
				building = new Building(false, true);
				//mRoads.push(building);
				mMaxScroll += 300;
			}
			else{
				building = new Building();
				building.pos.y = mGame.getHeight() / 2 - building.getDim().y - 20;
			}
			var lastBuilding = mBuildings[mBuildings.length - 1];
			building.pos.x = lastBuilding.pos.x + lastBuilding.getDim().x;
		}
		
		mBuildingsContainer.add(building);
			
		mBuildings.push(building);
		return cast building.pos.x + building.getDim().x;
	}
	
	public function addARoad() : Int {
		var road = new Road();
		mRoadContainer.add(road);
		if (mRoads.length == 0)
			road.pos.x = 0;
		else {
			var prev = mRoads[mRoads.length - 1];
			road.pos.x = prev.pos.x + prev.getDim().x;
		}
		
		mRoads.push(road);
		return cast road.pos.x + road.getDim().x;
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
		
		pos.x -= (mCamera.pos.x + pos.x) / 20;
		
		if (pos.x > 0)
			pos.x = 0;
		
		if (pos.x < -mMaxScroll )
			pos.x = -mMaxScroll;
			
		pos.x += mCamera.getShakeOffsetX();
		pos.y += mCamera.getShakeOffsetY();
		
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
			if (otherActor.worldPos.y < actor.worldPos.y &&
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