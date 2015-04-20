package core;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.media.Sound;
import openfl.media.SoundTransform;

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
	var mSounds:Map<Int,Sound>;
	var mVolume:Map<Int,Float>;
	
	public var onFinished : Void -> Void;
	
	public function new(spriteSheet : SpriteSheet, frames : Array<Int> = null, fps : Int = 12, loop = true ) 
	{
		mSounds = new Map<Int, Sound>();
		mVolume = new Map<Int, Float>();
		
		if (frames == null) {
			frames = new Array<Int>();
			for (i in 0 ... spriteSheet.getNbFrame())
				if (spriteSheet.flipped){
					frames.unshift(i);
				}
				else
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
		
		var frame = mCurrentFrame;
		
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
		
		if (frame != mCurrentFrame && mSounds[mCurrentFrame] != null){
			var channel = mSounds[mCurrentFrame].play();
			channel.soundTransform = new SoundTransform(mVolume[mCurrentFrame]);
		}
		return mFrames[mCurrentFrame];
	}
	
	public function getSpriteSheet() : SpriteSheet {
		return mSpriteSheet;
	}
	
	public function addSound(frame : Int, id : String, volume : Float = 1) {
		mSounds[frame] = Assets.getSound(id);
		mVolume[frame] = volume;
	}
	
	public function getFrame() : Rectangle {
		return mSpriteSheet.getFrame(mFrames[mCurrentFrame]);
	}
	
	public function getCurrentFrame() : Int {
		return mCurrentFrame;
	}
	
	public function getSource() : BitmapData {
		return mSpriteSheet.getBitmap();
	}
	
	public function reset() {
		mCurrentFrame = 0;
	}
	
	public function setFrame(frame:Int) 
	{
		mCurrentFrame = frame;
	}
	
}