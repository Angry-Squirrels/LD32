package entities;
import core.Animation;
import core.SpriteSheet;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class AnimatedActor extends Actor
{
	
	var mCurrentAnimation : String;
	
	var mAnimations : Map<String, Animation>;
	var mAnimation : Animation;
	
	var mSpriteSheet : SpriteSheet;
	
	var mDrawBoundIfNoAnim : Bool;

	public function new(name : String) 
	{
		super(name);
		
		mAnimations = new Map<String, Animation>();
	}
	
	public function addAnimation(name : String, animation : Animation) {
		mAnimations[name] = animation;
	}
	
	public function setAnimation(anim : String) {
		if (mCurrentAnimation == anim)
			return;
		
		if (mCurrentAnimation != null)
		{
			var prev : Animation = mAnimations[mCurrentAnimation];
			if (prev != null)
				prev.reset();
		}
		
		mCurrentAnimation = anim;
		
		mAnimation = mAnimations[mCurrentAnimation];
	}
	
	override function update(delta:Float) 
	{
		super.update(delta);
		
		if (mAnimation != null)
			if (mAnimation.isPlaying()) 
				mAnimation.getNextFrame(delta);	
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		if (mAnimation != null) {
			var p = new Vec2();
			p.x = dest.x;
			p.y = dest.y;
			p.x -= mAnimation.getSpriteSheet().offsetX;
			p.y -= mAnimation.getSpriteSheet().offsetY;
			buffer.copyPixels(mAnimation.getSource(), mAnimation.getFrame(), p.toPoint());
		}else if(mDrawBoundIfNoAnim)
			buffer.fillRect(new Rectangle(dest.x, dest.y, mDim.x, mDim.y), 0xff0000);
	}
	
}