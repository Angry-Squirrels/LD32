package entities.ennemies;
import core.Animation;
import core.SpriteSheet;
import entities.Actor;
import entities.Puppy;
import entities.World;
import geom.Vec2;

/**
 * ...
 * @author TBaudon
 */
class Boss extends Ennemy
{
	
	public var phase : Int;
	
	var mEnnemyManager : EnnemyManager;
	
	var mIdleTimer : Float;
	var mIdleToDoSomething : Float;
	var mPuppyThrown:Bool;
	var mWorld:World;
	public var spawnX : Float;

	public function new(ennemyManager : EnnemyManager, world : World) 
	{
		super("Boss");
		
		mEnnemyManager = ennemyManager;
		mWorld = world;
		
		mMaxLife = 50;
		mLife = 50;
		
		mDim.x = 196;
		mDim.y = 336;
		
		mMoveSpeed = 30;
		
		mIdleTimer = 5;
		mIdleToDoSomething = 5;
		
		mAttackFrameToDammage = 6;
		
		phase = 0;
		
		unpushable = true;
		
		mInvincible = true;
		
		initAnimations();
		
		mCurrentState = iddleState;
	}
	
	public function getMaxLife() : Int {
		return mMaxLife;
	}
	
	public function getLife() : Int{
		return mLife;
	}
	
	function iddleState(delta : Float) {
		
		if (mLife < mMaxLife / 2){
			phase = 1;
			mInvincible = false;
		}
		
		if (isPlaying("hit"))
			return;
		
		mNormalAnim = true;
		
		if (Vec2.Dist(worldPos, mTarget.worldPos) < 1000) {
			
			if (worldPos.x > spawnX) 
				vel.x = - mMoveSpeed;
			else {
				vel.x = 0;
				mIdleTimer += delta;
				if (mIdleTimer >= mIdleToDoSomething) {
					mIdleTimer = 0;
					
					if (mEnnemyManager.getEnnemiesAlive() == 1)
						mCurrentState = growl;
					else {
						mPuppyThrown = false;	
						mCurrentState = throwPuppy;
					}
				}
			}
			
		}
	}
	
	function growl(delta : Float) {
		setAnimation("growl");
		mNormalAnim = false;
		
		if (mAnimation.getCurrentFrame() == 9)
			if(mEnnemyManager.getEnnemiesAlive() == 1)
				mEnnemyManager.spawnPunk(2);
	}
	
	function throwPuppy(delta : Float) {
		mNormalAnim = false;
		setAnimation("puppyAttack");
		if (mAnimation.getCurrentFrame() == 14 && !mPuppyThrown) {
			mPuppyThrown = true;
			
			var pup = new Puppy(cast mTarget, this);
			pup.startAltitude = 250;
			pup.worldPos.x = worldPos.x - 150;
			pup.worldPos.y = worldPos.y;
			pup.launch( -1);
			
			mWorld.addActor(pup);
		}
	}
	
	function setIddleState() {
		mCurrentState = iddleState;
	}
	
	function initAnimations() 
	{
		addAnimation("walkR", new Animation(new SpriteSheet("Boss/boss_walk_flip", 326, 336, 65, 0), [4,3,2,1,0,9,8,7,6,5,14,13,12,11,10]));
		addAnimation("walkL", new Animation(new SpriteSheet("Boss/boss_walk", 326, 336, 65, 0)));
		
		addAnimation("iddleR", new Animation(new SpriteSheet("Boss/boss_iddle_flip", 326, 336, 65, 0)));
		addAnimation("iddleL", new Animation(new SpriteSheet("Boss/boss_iddle", 326, 336, 65, 0)));
		
		addAnimation("deathR", new Animation(new SpriteSheet("Boss/boss_death_flip", 326, 336, 65, 0), null, 12, false));
		addAnimation("deathL", new Animation(new SpriteSheet("Boss/boss_death", 326, 336, 65, 0), null, 12, false));
		
		var hitR = new Animation(new SpriteSheet("Boss/boss_hit_flip", 326, 336, 65, 0), null, 20, false);
		hitR.onFinished = normalAnim;
		addAnimation("hitR", hitR);
		
		var hitL = new Animation(new SpriteSheet("Boss/boss_hit", 326, 336, 65, 0), null, 20, false);
		hitL.onFinished = normalAnim;
		addAnimation("hitL", hitL);
		
		var attackRAnim = new Animation(new SpriteSheet("Boss/boss_attack2_flip", 326, 336, 65, 0), [2,1,0,5,4,3,8,7,6], 12, false);
		addAnimation("attackR", attackRAnim);
		attackRAnim.onFinished = normalAnim;
		
		var attackLAnim = new Animation(new SpriteSheet("Boss/boss_attack2", 326, 336, 65, 0), null, 12, false);
		addAnimation("attackL", attackLAnim);
		attackLAnim.onFinished = normalAnim;
		
		var puppyAttack = new Animation(new SpriteSheet("Boss/boss_attack1", 326, 336, 65, 0), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], 12, false);
		addAnimation("puppyAttack", puppyAttack);
		puppyAttack.onFinished = setIddleState;
		
		var growlAnim = new Animation(new SpriteSheet("Boss/boss_iddle_anim", 326, 336, 65, 0), null, 12, false);
		addAnimation("growl", growlAnim);
		growlAnim.onFinished = setIddleState;
	}
	
	override public function takeDamage(amount:Int, source:Actor) 
	{
		if (Std.is(source, Puppy)){
			mInvincible = false;
			super.takeDamage(10, source);
			mInvincible = true;
		}else {
			super.takeDamage(amount, source);
		}
		
	
	}
	
}