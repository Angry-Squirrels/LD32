package entities;
import core.Game;
import geom.Vec2;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.media.Sound;
import openfl.media.SoundChannel;

/**
 * ...
 * @author TBaudon
 */
class Human extends AnimatedActor
{
	var mGame : Game;
	
	var mMaxY : Float;
	var mMinY : Float;
	var mHeading : Int;

	public function new(name : String) 
	{
		super(name);
		
		mDim.x = 76;
		mDim.y = 162;
		
		mGame = Game.getInstance();
		
		mHeading = 1;
		
		mMinY = mGame.getHeight() / 2 - 40;
		mMaxY = mGame.getHeight();
	}
	
	function playAnim(name : String) : String {
		
		var alreadyPlaying : Bool = false;	
		var f : Int = 0;
		
		if(mAnimation != null){
			alreadyPlaying = isPlaying(name);
			f = mAnimation.getCurrentFrame();
		}
		
		if (mHeading > 0)
			name += "R";
		else
			name += "L";
			
		setAnimation(name);
		
		if (alreadyPlaying)
			mAnimation.setFrame(f);
		
		return name;
	}
	
	public function isPlaying(name : String) : Bool {
		return mCurrentAnimation == name + "L" || mCurrentAnimation == name + "R";
	}
	
	override function update(delta:Float) 
	{
		super.update(delta);
		
		if (worldPos.y < mMinY /  Actor.fakeZCoef)
			worldPos.y = mMinY /  Actor.fakeZCoef;
			
		if (worldPos.y > mMaxY /  Actor.fakeZCoef) 
			worldPos.y = mMaxY /  Actor.fakeZCoef;
	}
	
	override public function takeDamage(amount:Int, source : Actor) 
	{
		if (mInvincible) return;
		super.takeDamage(amount, source);
		
		if (source != null ) {
			
			var pushVector = Vec2.Sub(worldPos, source.worldPos);
			pushVector = Vec2.Norm(pushVector);
			
			pushVector.mul(1000);
			
			vel.add(pushVector);
			
		}
	}
	
}