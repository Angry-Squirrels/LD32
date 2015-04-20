package entities.ennemies;
import entities.Actor;
import entities.hero.Hero;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class Ennemy extends Human
{
	
	var mTarget : Actor;
	
	var mRangeToStartFollow : Float = 600;
	
	var mCurrentState : Float -> Void;
	
	static var mPunkFollowingHero : Array<Ennemy>;
	
	var mMaxPunkFollowing : Int;
	var mAttackTimer:Float;
	var mAttackRate:Float;
	var mFleeing:Bool;
	
	var mNormalAnim : Bool;
	var mDamageDealt:Bool;
	var mAttackFrameToDammage : Int;

	public function new(name : String) 
	{
		super(name);
		
		mAttackTimer = 0;
		mAttackRate = 0.5;
		mNormalAnim = true;
		mAttackFrameToDammage = 3;
		
		if (mPunkFollowingHero == null)
			mPunkFollowingHero = new Array<Ennemy>();
		
		mMoveSpeed = 40;
		
		mDrawBoundIfNoAnim = true;
	}
	
	override public function setOthersActors(actors:Array<Actor>) 
	{
		super.setOthersActors(actors);
	}
	
	public function setTarget(target : Actor) {
		mTarget = target;
	}
	
	override function update(delta:Float) 
	{
		
		super.update(delta);
		
		if (isDead()) {
			vel.x = 0;
			vel.y = 0;
			mXAxis = 0;
			mYAxis = 0;
			playAnim("death");
			return;
		}
		
		if (mTarget != null && !mFleeing)
			if (mTarget.worldPos.x < worldPos.x)
				mHeading = -1;
			else if (mTarget.worldPos.x > worldPos.x)
				mHeading = 1;
				
		if(mNormalAnim)
			if (vel.length() > 15)
				playAnim("walk");
			else
				playAnim("iddle");
		
		if (mCurrentState != null)
			mCurrentState(delta);
		
		var rangeToGetClose : Int = 300;
	}
	
	public function attacking(delta : Float) {
		if (mTarget != null) 
		{
			mFleeing = false;
			var rangeToAttack = mDim.x / 2 + mTarget.getDim().x / 2;
			rangeToAttack *= 1.1;
			
			if (Vec2.Dist(mTarget.worldPos, worldPos) > rangeToAttack){
				moveTowardTarget();
				mAttackTimer = 0;
			}
			else {
				mXAxis = 0;
				mYAxis = 0;
				
				mAttackTimer += delta;
				
				if (mAttackTimer >= mAttackRate && !mTarget.isDead())
				{
					attack();
					mDamageDealt = false;
					mAttackTimer = 0;
				}
			}
			
			if (isPlaying("attack") && mAnimation.getCurrentFrame() == mAttackFrameToDammage && !mDamageDealt){
				mTarget.takeDamage(1, this);
				mDamageDealt = true;
			}
		}
	}
	
	function normalAnim() {
		mNormalAnim = true;
	}
	
	public function attack() {
		playAnim("attack");
		mNormalAnim = false;
	}
	
	override public function takeDamage(amount:Int, source:Actor) 
	{
		if (mInvincible) return;
		super.takeDamage(amount, source);
		mNormalAnim = false;
		playAnim("hit");
		
		mAttackTimer = 0;
	}
	
	public function getClose(delta : Float) {
		if (mTarget != null) 
		{
			if (Vec2.Dist(mTarget.worldPos, worldPos) > 350){
				moveTowardTarget();
				mFleeing = false;
			}else if(Vec2.Dist(mTarget.worldPos, worldPos) < 250){
				fleeTarget();
				mFleeing = true;
			}else {
				
				if (worldPos.x > mTarget.worldPos.x)
					mHeading = -1;
				else
					mHeading = 1;
				
				mXAxis = 0;
				mYAxis = 0;
			}
			
		}
	}
	
	function fleeTarget() {
		var axis = Vec2.Sub(mTarget.worldPos, worldPos);
		axis = Vec2.Norm(axis);
		axis.mul( -1);
		
		if (axis.x > 0)
			mHeading = 1;
		else if (axis.x < 0)
			mHeading = -1;
		
		mYAxis = axis.y;
		mXAxis = axis.x;
	}
	
	function moveTowardTarget() 
	{	
		var axis = Vec2.Sub(mTarget.worldPos, worldPos);
		axis = Vec2.Norm(axis);
		
		mYAxis = axis.y;
		mXAxis = axis.x;
	}
	
	public function setState(state : Float -> Void) {
		mCurrentState = state;
	}
	
}