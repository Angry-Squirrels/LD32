package entities;
import core.Game;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class Human extends Actor
{
	var mGame : Game;
	
	var mMaxY : Float;
	var mMinY : Float;

	public function new(name : String) 
	{
		super(name);
		
		mDim.x = 76;
		mDim.y = 162;
		
		mGame = Game.getInstance();
		
		mMinY = mGame.getHeight() / 2 + 20;
		mMaxY = mGame.getHeight();
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		buffer.fillRect(new Rectangle(dest.x, dest.y, mDim.x, mDim.y), 0x00ff00);
	}
	
	override function update(delta:Float) 
	{
		super.update(delta);
		
		if (worldPos.y < mMinY /  Actor.fakeZCoef)
			worldPos.y = mMinY /  Actor.fakeZCoef;
			
		if (worldPos.y > mMaxY /  Actor.fakeZCoef) 
			worldPos.y = mMaxY /  Actor.fakeZCoef;
	}
	
}