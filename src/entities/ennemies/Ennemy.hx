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

	public function new() 
	{
		super("Punk");
		
		mAttackTimer = 0;
		mAttackRate = 1.5;
		
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
			mDim.x = 120;
			mDim.y = 72;
			vel.x = 0;
			vel.y = 0;
			mXAxis = 0;
			mYAxis = 0;
			return;
		}
		
		if (mCurrentState != null)
			mCurrentState(delta);
		
		var rangeToGetClose : Int = 300;
	}
	
	public function attacking(delta : Float) {
		if (mTarget != null) 
		{
			
			var rangeToAttack = mDim.x / 2 + mTarget.getDim().x / 2;
			rangeToAttack *= 1.4;
			
			if (Vec2.Dist(mTarget.worldPos, worldPos) > rangeToAttack)
				moveTowardTarget();
			else {
				mXAxis = 0;
				mYAxis = 0;
				
				mAttackTimer += delta;
				
				if (mAttackTimer >= mAttackRate)
				{
					attack();
					mAttackTimer = 0;
				}
			}
		}
	}
	
	public function attack() {
		mTarget.takeDamage(1, this);
	}
	
	public function getClose(delta : Float) {
		if (mTarget != null) 
		{
			if (Vec2.Dist(mTarget.worldPos, worldPos) > 350)
				moveTowardTarget();
			else {
				fleeTarget();
			}
		}
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		if(!isDead())
			super.draw(buffer, dest);
		else
			buffer.fillRect(new Rectangle(dest.x, dest.y, 162, 72), 0x006699);
	}
	
	function fleeTarget() {
		var axis = Vec2.Sub(mTarget.worldPos, worldPos);
		axis = Vec2.Norm(axis);
		axis.mul( -1);
		
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