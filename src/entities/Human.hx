package entities;
import core.Game;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class Human extends AnimatedActor
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
	
	override function update(delta:Float) 
	{
		super.update(delta);
		
		if (worldPos.y < mMinY /  Actor.fakeZCoef)
			worldPos.y = mMinY /  Actor.fakeZCoef;
			
		if (worldPos.y > mMaxY /  Actor.fakeZCoef) 
			worldPos.y = mMaxY /  Actor.fakeZCoef;
	}
	
	override public function takeDamage(amount:Int, source : Actor) 
	{
		super.takeDamage(amount, source);
		
		if (source != null) {
			
			var pushVector = Vec2.Sub(worldPos, source.worldPos);
			pushVector = Vec2.Norm(pushVector);
			
			pushVector.mul(1000);
			
			vel.add(pushVector);
			
		}
	}
	
}