package entities;
import core.Entity;
import geom.Vec2;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class Road extends Entity
{
	
	var mBmp : BitmapData;

	public function new() 
	{
		super("Road");
		
		mBmp = Assets.getBitmapData("img/Decors/road.jpg");
		
		mDim.x = mBmp.width;
		mDim.y = mBmp.height;
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		if(dest.x + mBmp.width > 0 && dest.x < 800)
			buffer.copyPixels(mBmp, new Rectangle(0, 0, mBmp.width, mBmp.height), dest.toPoint());
	}
	
}