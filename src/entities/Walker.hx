package entities;
import core.Entity;
import core.Game;

/**
 * ...
 * @author TBaudon
 */
class Walker extends Entity
{
	
	var mXAxis : Float;
	var mYAxis : Float;
	
	var mMoveSpeed : Float;
	
	var mGame : Game;
	
	var mMinY : Float;
	var mMaxY : Float;
	
	public function new(name : String) 
	{
		super(name);
		
		mXAxis = 0;
		mYAxis = 0;
		
		mMoveSpeed = 70;
		
		mGame = Game.getInstance();
		mMinY = mGame.getHeight() / 2;
		mMaxY = mGame.getHeight();
	}
	
	override function update(delta:Float) 
	{
		vel.x += mXAxis * mMoveSpeed;
		vel.y += mYAxis * mMoveSpeed;
		
		pos.x += vel.x * delta;
		pos.y += vel.y * delta;
		
		vel.x *= 0.7;
		vel.y *= 0.7;
		
		if (pos.y < mMinY - getDim().y)
			pos.y = mMinY - getDim().y;
			
		if (pos.y > mMaxY - getDim().y)
			pos.y = mMaxY - getDim().y;
	}
	
}