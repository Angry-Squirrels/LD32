package core ;
import geom.Vec2;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Thomas BAUDON
 */
class Pointer extends Entity
{
	
	var mBitmap : BitmapData;
	var mRect : Rectangle;
	var mDestPoint : Point;

	public function new() 
	{
		super();
		mBitmap = Assets.getBitmapData("img/Pointer.png");
		mRect = new Rectangle(0, 0, 9, 9);
		mDestPoint = new Point();
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		super.draw(buffer, dest);
		mDestPoint.x = pos.x - 4;
		mDestPoint.y = pos.y - 4;
		buffer.copyPixels(mBitmap, mRect, mDestPoint);
	}
	
}