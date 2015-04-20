package entities.ennemies;
import core.Animation;
import core.SpriteSheet;

/**
 * ...
 * @author TBaudon
 */
class Boss extends Ennemy
{

	public function new() 
	{
		super("Boss");
		
		mLife = 50;
		
		mDim.x = 196;
		mDim.y = 336;
		
		mMoveSpeed = 30;
		
		initAnimations();
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
	}
	
}