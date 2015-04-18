package entities.hero;
import core.Camera;
import entities.Actor;
import entities.Weapon;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class Shoe extends Weapon
{
	
	public function new(side : String) 
	{
		super("shoe");
		
		mDim.x = 20;
		mDim.y = 20;
		
		mDamage = 3;
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		buffer.fillRect(new Rectangle(dest.x, dest.y, mDim.x, mDim.y), 0xcccccc);
	}
	
}