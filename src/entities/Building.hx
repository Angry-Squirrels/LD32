package entities;
import core.Entity;
import core.Game;
import geom.Vec2;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;

/**
 * ...
 * @author TBaudon
 */
class Building extends Entity
{
	
	var mColor : UInt;
	var mGame : Game;

	public function new() 
	{
		super("Building");
		
		mGame = Game.getInstance();
		
		mDim.x = Math.random() * 200 + 100;
		mDim.y = Math.random() * 100 + 150;
		
		var grey = Std.int(Math.random() * 100) + 155;
		mColor = grey | grey << 8 | grey << 16;
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		if(dest.x + mDim.x > 0 && dest.x < mGame.getWidth())
			buffer.fillRect(new Rectangle(dest.x, dest.y, mDim.x, mDim.y), mColor);
		
	}
	
}