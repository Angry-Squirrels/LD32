package entities;
import core.Animation;
import core.SpriteSheet;
import entities.Actor;
import entities.ennemies.Boss;
import entities.hero.Hero;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class Puppy extends Weapon
{
	var mTarget:Hero;
	var mBoss : Boss;

	public function new(target : Hero, boss : Boss ) 
	{
		super("Puppy");
		
		mTarget = target;
		
		mDim.x = 84;
		mDim.y = 42;
		
		mBoss = boss;
		
		mAgainstHero = true;
		
		mDamage = 10;
		
		mGravity = 0;
		
		mExplode = true;
		
		addAnimation("fly", new Animation(new SpriteSheet("Boss/puppie_fly", 84, 42)));
		addAnimation("flyb", new Animation(new SpriteSheet("Boss/puppie_fly_flip", 84, 42)));
		setAnimation("fly");
	}
	
	override public function onCollide(actor:Actor) 
	{
		if (Std.is(actor, Weapon)){
			bounce();
			return;
		}
		
		if (actor == mTarget) 
			if(mTarget.isAttacking() && mTarget.isFacingRight()) {
				bounce();
				return;
			}
			
		super.onCollide(actor);
	}
	
	function bounce() {
		if (mAgainstHero) {
			setAnimation("flyb");
			vel.mul( -1.5);
			mZVel = 0;
			
			mAgainstHero = false;
			startAltitude = 70;
			mFalled = 0;
			worldPos.x = mTarget.worldPos.x + 50;
			worldPos.y = mTarget.worldPos.y;
		}
	}
	
	override public function launch(dir : Int) {
		mUseWorldCoord = true;
		
		var a = Vec2.Sub(worldPos, mTarget.worldPos);
		var aLength = Math.sqrt(a.x * a.x + a.y * a.y + startAltitude * startAltitude);
		var zComp = startAltitude / aLength;
		a = Vec2.Norm(a);
		a.mul(-1000);
		
		vel.copy(a);
		mFalled = 0;
		mZVel = zComp * 1000;
	}
	
}