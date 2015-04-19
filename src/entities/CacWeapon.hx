package entities;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class CacWeapon extends Weapon
{
	
	var mLifeTime : Float;
	var mLifeSpan : Float = 0.2;
	var mLaunched:Bool;

	public function new(name : String) 
	{
		super(name);
		
		mGravity = 0;
		
		mDim.x = 70;
		mDim.y = 30;
		
		mLifeTime = 0;
	}
	
	override public function launch(dir:Int) 
	{
		super.launch(dir);
		mZVel = 0;
		vel.x = 0;
		mMoveSpeed = 0;
		mLaunched = true;
	}
	
	override function update(delta:Float) 
	{
		super.update(delta);
		
		vel.x = 0;
		vel.y = 0;
		
		if(mLaunched){
			mLifeTime += delta;
			if (mLifeTime >= mLifeSpan){
				destroy();
			}
		}
	}
	
	/*override function draw(buffer:BitmapData, dest:Vec2) 
	{
		buffer.fillRect(new Rectangle(dest.x, dest.y, mDim.x, mDim.y), 0xffff00);
		super.draw(buffer, dest);
	}*/
	
}