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
	
	var mMaxLife : Int;
	var mLife : Int;
	
	public var solid : Bool;
	
	var mUseWorldCoord : Bool;
	
	public static inline var fakeZCoef : Float = 0.5;
	public var worldPos : Vec2;
	public var unpushable : Bool;
	
	var mOthers : Array<Actor>;
	var mFriction:Float = 0.7;
	var mDestroyable : Bool;
	
	public function new(name : String) 
	{
		super(name);
		
		mMaxLife = 5;
		mLife = mMaxLife;
		
		mXAxis = 0;
		mYAxis = 0;
		solid = true;
		
		mUseWorldCoord = true;
		
		worldPos = new Vec2();
		
		mMoveSpeed = 100;
	}
	
	public function setOthersActors(actors : Array<Actor>) {
		mOthers = actors;
	}
	
	override function update(delta:Float) 
	{
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
		
		// collide other actors
		if (mOthers != null && !isDead()) 
			for (actor in mOthers) {
				if (actor == this) continue;
				//if (Vec2.Dist(worldPos, actor.worldPos) < mDim.x /2 + actor.getDim().x / 2) {
				if(hitTest(this, actor)){
					var pushVec = Vec2.Sub(worldPos, actor.worldPos);
					onCollide(actor);
					
					if (actor.isDead()) continue;
					
					if(actor.solid && solid){
						if(!unpushable)
							vel.add(pushVec);
						
						if(!actor.unpushable)
							actor.vel.sub(pushVec);
					}
				}
			}
			
	}
	
	public function hitTest(a : Actor, b : Actor) : Bool {
		return Vec2.Dist(a.worldPos, b.worldPos) < a.getDim().x / 2 + b.getDim().x / 2;
	}
	
	public function takeDamage(amount : Int, source : Actor) {
		mLife -= amount;
	}
	
	public function onCollide(actor : Actor) {
		
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