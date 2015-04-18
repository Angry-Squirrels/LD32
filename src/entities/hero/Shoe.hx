package entities.hero;
import core.Camera;
import entities.Actor;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class Shoe extends Actor
{
	
	var mFalled : Float;
	var mZVel : Float = 0;
	var mGravity : Float = 40;
	var mStartAltitude:Float;

	public function new(side : String) 
	{
		super("shoe");
		
		mDim.x = 20;
		mDim.y = 20;
		
		mFriction = 1;
		
		mUseWorldCoord = false;
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		buffer.fillRect(new Rectangle(dest.x, dest.y, mDim.x, mDim.y), 0xcccccc);
	}
	
	override function update(delta:Float) 
	{
		super.update(delta);
		
		if (mUseWorldCoord) {
			pos.y -= mStartAltitude - mFalled;
			
			mZVel += mGravity;
			
			if (mFalled < mStartAltitude)
				mFalled += mZVel * delta;
			else{
				mFalled = mStartAltitude;
				mZVel = 0;
				mFriction = 0.7;
				Camera.instance.shake(5, 200);
				destroy();
			}
		}
	}
	
	public function launch(dir : Int) {
		mUseWorldCoord = true;
		vel.x = 1000 * dir;
		mStartAltitude = 70;
		mFalled = 0;
		mZVel = - 200;
	}
	
}