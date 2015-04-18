package core;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Thomas B
 */
class SpriteSheet
{
	
	var mBitmap : BitmapData;
	var mSpriteWidth : Int;
	var mSpriteHeight : Int;
	var mNbCol : Int;
	var mNbLine : Int;
	var mFrameRect : Rectangle;
	
	public var offsetX : Int;
	public var offsetY : Int;

	public function new(path : String, spriteWidth : Int, spriteHeight : Int) 
	{
		mBitmap = Assets.getBitmapData("img/" + path +".png");
		setFrameDim(spriteWidth, spriteHeight);
	}
	
	public function getFrame(frame : Int) : Rectangle {
		var x = frame % mNbCol;
		var y = Std.int(frame / mNbCol);
		mFrameRect.x = x * mSpriteWidth;
		mFrameRect.y = y * mSpriteHeight;
		return mFrameRect;
	}
	
	public function getBitmap() : BitmapData {
		return mBitmap;
	}
	
	public function setFrameDim(width : UInt, height : UInt) 
	{
		mSpriteWidth = width;
		mSpriteHeight = height;
		mFrameRect = new Rectangle(0, 0, mSpriteWidth, mSpriteHeight);
		mNbCol = Std.int(mBitmap.width / mSpriteWidth);
		mNbLine = Std.int(mBitmap.height / mSpriteHeight);
	}
	
}