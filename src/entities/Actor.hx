package entities;
import core.Animation;
import core.Entity;
import core.Game;
import core.SpriteSheet;
import geom.Vec2;

/**
 * ...
 * @author TBaudon
 */
class Actor extends Entity
{
	
	var mXAxis : Float;
	var mYAxis : Float;
	
	var mMoveSpeed : Float;
	
	var mCurrentAnimation : String;
	
	var mAnimations : Map<String, Animation>;
	var mAnimation : Animation;
	
	var mSpriteSheet : SpriteSheet;
	
	var mMaxLife : Int;
	var mLife : Int;
	
	var mUseWorldCoord : Bool;
	
	public static inline var fakeZCoef : Float = 0.5;
	public var worldPos : Vec2;
	
	var mOthers : Array<Actor>;
	var mFriction:Float = 0.7;
	var mDestroyable : Bool;
	
	public function new(name : String) 
	{
		super(name);
		
		mAnimations = new Map<String, Animation>();
		
		mMaxLife = 5;
		mLife = mMaxLife;
		
		mXAxis = 0;
		mYAxis = 0;
		
		mUseWorldCoord = true;
		
		worldPos = new Vec2();
		
		mMoveSpeed = 100;
	}
	
	public function setOthersActors(actors : Array<Actor>) {
		mOthers = actors;
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
		
		if (mAnimation != null)
			if (mAnimation.isPlaying()) 
				mAnimation.getNextFrame(delta);	
		
		vel.x += mXAxis * mMoveSpeed;
		vel.y += mYAxis * mMoveSpeed;
		
		worldPos.x += vel.x * delta;
		worldPos.y += vel.y * delta;
		
		vel.x *= mFriction;
		vel.y *= mFriction;
		
		if(mUseWorldCoord){
			pos.x = worldPos.x - mDim.x / 2;
			pos.y = worldPos.y * fakeZCoef - mDim.y;
		}
		
		// push actors
		if (mOthers != null) 
			for (actor in mOthers) 
				if (Vec2.Dist(worldPos, actor.worldPos) < mDim.x /2 + actor.getDim().x / 2) {
					var pushVec = Vec2.Sub(worldPos, actor.worldPos);
					vel.add(pushVec);
					actor.vel.sub(pushVec);
				}
			
	}
	
	public function takeDamage(amount : Int) {
		mLife -= amount;
	}
	
	public function isDead() {
		if (mLife <= 0)
			return true;
		return false;
	}
	
	public function destroyable() : Bool {
		return mDestroyable;
	}
	
	override public function destroy() {
		super.destroy();
		mDestroyable = true;
	}
	
}