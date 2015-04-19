package entities.hud;
import core.Entity;
import geom.Vec2;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class Go extends Entity
{
	
	var mSprite : BitmapData;
	var mRect : Rectangle;
	
	var mBlinkTimer : Float;
	var mFreq : Float;
	var mDraw : Bool;
	
	public function new() 
	{
		super("go");
		
		mBlinkTimer = 0;
		mFreq = 0.75;
		mDraw = true;
		
		mSprite = Assets.getBitmapData("img/hud/GO.png");
		mRect = new Rectangle(0, 0, mSprite.width, mSprite.height);
	}
	
	override function update(delta:Float) 
	{
		super.update(delta);
		
		mBlinkTimer += delta;
		
		if (mBlinkTimer >= mFreq){
			mBlinkTimer = 0;
			mDraw = !mDraw;
		}
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		if(mDraw)
			buffer.copyPixels(mSprite, mRect, dest.toPoint()); 
	}
	
}