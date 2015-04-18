package entities.hero;
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

	public function new(side : String) 
	{
		super("shoe");
		
		mDim.x = 20;
		mDim.y = 20;
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		buffer.fillRect(new Rectangle(dest.x, dest.y, mDim.x, mDim.y), 0xcccccc);
	}
	
}