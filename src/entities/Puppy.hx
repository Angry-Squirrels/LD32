package entities;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class Puppy extends Weapon
{

	public function new(target : Actor ) 
	{
		super("Puppy");
		
		mDim.x = 20;
		mDim.y = 20;
		
		mAgainstHero = true;
		
		mExplode = true;
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		//super.draw(buffer, dest);
		buffer.fillRect(new Rectangle(dest.x, dest.y, mDim.x, mDim.y), 0xff0000);
	}
	
}