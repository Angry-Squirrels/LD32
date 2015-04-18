package core;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Thomas B
 */
class Animation
{
	
	var mFrames : Array<Int>;
	var mCurrentFrame : Int;
	var mTimeCounter : Float;
	var mTimeToNextFrame : Float;
	var mLoop : Bool;
	var mSpriteSheet : SpriteSheet;
	var mIsPlaying:Bool;
	
	public var onFinished : Void -> Void;
	
	public function new(spriteSheet : SpriteSheet, frames : Array<Int> = null, fps : Int = 12, loop = true ) 
	{
		if (frames == null){
			frames = new Array<Int>();
			for (i in 0 ... spriteSheet.getNbFrame())
				frames.push(i);
		}
		
		mFrames = frames;
		mCurrentFrame = 0;
		mTimeToNextFrame = 1 / fps;
		mTimeCounter = 0;
		mLoop = loop;
		mIsPlaying = true;
		mSpriteSheet = spriteSheet;
	}
	
	public function play() {
		mIsPlaying = true;
	}
	
	public function stop() {
		mIsPlaying = false;
	}
	
	public function isPlaying() : Bool {
		return mIsPlaying;
	}
	
	public function getNextFrame(delta : Float) : Int {
		mTimeCounter += delta;
		if (mTimeCounter >= mTimeToNextFrame){
			mTimeCounter = 0;
			mCurrentFrame ++;
		}
		
		if (mCurrentFrame == mFrames.length && mLoop)
			mCurrentFrame = 0;
		else if(mCurrentFrame == mFrames.length){
			mCurrentFrame = mFrames.length - 1;
			if(onFinished != null) onFinished();
		}
			
		return mFrames[mCurrentFrame];
	}
	
	public function getSpriteSheet() : SpriteSheet {
		return mSpriteSheet;
	}
	
	public function getFrame() : Rectangle {
		return mSpriteSheet.getFrame(mCurrentFrame);
	}
	
	public function getSource() : BitmapData {
		return mSpriteSheet.getBitmap();
	}
	
	public function reset() {
		mCurrentFrame = 0;
	}
	
}