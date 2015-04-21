package entities;
import core.Entity;
import core.Game;
import geom.Vec2;
import openfl.Assets;
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

	var mSprite : BitmapData;
	
	static var mLastUsed : String;
	
	public function new(begin : Bool = false, end : Bool = false) 
	{
		super("Building");
		
		mGame = Game.getInstance();
		
		if (begin){
			mSprite = Assets.getBitmapData("img/Decors/road_start.jpg");
		}else if (end)
			mSprite = Assets.getBitmapData("img/Decors/road_boss.jpg");
		else{
			var availableBuilding = ["img/Decors/frontage.png"];
			var decorId = Std.int(Math.random() * availableBuilding.length);
			mSprite = Assets.getBitmapData(availableBuilding[decorId]);
		}
		
		mDim.x = mSprite.width;
		mDim.y = mSprite.height;
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		if (dest.x + mDim.x > 0 && dest.x < mGame.getWidth()) {
			buffer.copyPixels(mSprite, new Rectangle(0, 0, mDim.x, mDim.y), dest.toPoint());
		}
		
	}
	
}