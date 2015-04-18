package entities;
import core.Camera;
import entities.hero.Hero;

/**
 * ...
 * @author TBaudon
 */
class Weapon extends AnimatedActor
{
	
	var mDamage : Int;
	
	var mFalled : Float;
	var mZVel : Float = 0;
	var mGravity : Float = 40;
	public var startAltitude : Float;

	public function new(name : String) 
	{
		super(name);
		
		mDamage = 1;
		
		mFriction = 1;
		
		mUseWorldCoord = false;
	}
	
	public function getDamage() : Int {
		return mDamage;
	}
	
	public function launch(dir : Int) {
		mUseWorldCoord = true;
		vel.x = 1000 * dir;
		mFalled = 0;
		mZVel = - 200;
	}
	
	override public function onCollide(actor:Actor) 
	{
		super.onCollide(actor);
		if (!Std.is(actor, Hero)) {
			explode();
			actor.takeDamage(mDamage);
		}
	}
	
	override function update(delta:Float) 
	{
		super.update(delta);
		
		if (mUseWorldCoord) {
			pos.y -= startAltitude - mFalled;
			
			mZVel += mGravity;
			
			if (mFalled < startAltitude)
				mFalled += mZVel * delta;
			else{
				mFalled = startAltitude;
				mZVel = 0;
				mFriction = 0.7;
				explode();
			}
		}
	}
	
	function explode() {
		Camera.instance.shake(5, 200);
		destroy();	
	}
	
	
}