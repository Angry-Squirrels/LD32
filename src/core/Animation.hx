package core;

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
	
	public function new(frames : Array<Int>, fps : Int, loop = true ) 
	{
		mFrames = frames;
		mCurrentFrame = 0;
		mTimeToNextFrame = 1 / fps;
		mTimeCounter = 0;
		mLoop = loop;
	}
	
	public function getNextFrame(delta : Float) : Int {
		mTimeCounter += delta;
		if (mTimeCounter >= mTimeToNextFrame){
			mTimeCounter = 0;
			mCurrentFrame ++;
		}
		
		if (mCurrentFrame == mFrames.length && mLoop)
			mCurrentFrame = 0;
		else if(mCurrentFrame == mFrames.length)
			mCurrentFrame = mFrames.length - 1;
			
		return mFrames[mCurrentFrame];
	}
	
	public function reset() {
		mCurrentFrame = 0;
	}
	
}