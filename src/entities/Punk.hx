package entities;
import entities.Actor;
import entities.hero.Hero;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class Punk extends Human
{
	
	var mTarget : Actor;
	
	var mRangeToStartFollow : Float = 600;
	
	static var mPunkFollowingHero : Array<Punk>;
	
	var mMaxPunkFollowing : Int;

	public function new() 
	{
		super("Punk");
		
		if (mPunkFollowingHero == null)
			mPunkFollowingHero = new Array<Punk>();
		
		mMoveSpeed = 40;
		
		mDrawBoundIfNoAnim = true;
	}
	
	override public function setOthersActors(actors:Array<Actor>) 
	{
		super.setOthersActors(actors);
	}
	
	function lookForTarget() {
		for (actor in mOthers)
			if (actor.name == Hero.HERO && 
				Vec2.Dist(worldPos, actor.worldPos) <= mRangeToStartFollow)
				mTarget = actor;
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
		
		if (mTarget == null) 
			lookForTarget();
		else {
			
			var rangeToAttack = mDim.x / 2 + mTarget.getDim().x / 2;
			rangeToAttack *= 1.3;
			
			if (Vec2.Dist(mTarget.worldPos, worldPos) > rangeToAttack)
				moveTowardTarget();
			else {
				mXAxis = 0;
				mYAxis = 0;
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
	
	function moveTowardTarget() 
	{
		var targetPos = mTarget.pos.clone();
		targetPos.x += mTarget.getDim().x / 2;
		targetPos.y += mTarget.getDim().y;
		
		var destPos = pos.clone();
		destPos.x += getDim().x / 2;
		destPos.y += getDim().y;
		
		var axis = Vec2.Sub(targetPos, destPos);
		axis = Vec2.Norm(axis);
		
		mYAxis = axis.y;
		mXAxis = axis.x;
	}
	
	
	
}