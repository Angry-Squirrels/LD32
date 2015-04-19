package entities.ennemies;
import core.Animation;
import core.SpriteSheet;

/**
 * ...
 * @author TBaudon
 */
class Punk extends Ennemy
{

	public function new() 
	{
		super("Punk");
		
		initAnimations();
	}
	
	function initAnimations() 
	{
		addAnimation("walkR", new Animation(new SpriteSheet("Punk/punk_walk", 140, 180, 35, 0)));
		addAnimation("walkL", new Animation(new SpriteSheet("Punk/punk_walk_flip", 140, 180, 35, 0)));
		
		addAnimation("iddleR", new Animation(new SpriteSheet("Punk/punk_iddle", 140, 180, 35, 0)));
		addAnimation("iddleL", new Animation(new SpriteSheet("Punk/punk_iddle_flip", 140, 180, 35, 0)));
		
		addAnimation("deathR", new Animation(new SpriteSheet("Punk/punk_death", 140, 180, 35, 0), null, 12, false));
		addAnimation("deathL", new Animation(new SpriteSheet("Punk/punk_death_flip", 140, 180, 35, 0), null, 12, false));
		
		var hitR = new Animation(new SpriteSheet("Punk/punk_hit", 140, 180, 35, 0), null, 20, false);
		hitR.onFinished = normalAnim;
		addAnimation("hitR", hitR);
		
		var hitL = new Animation(new SpriteSheet("Punk/punk_hit_flip", 140, 180, 35, 0), null, 20, false);
		hitL.onFinished = normalAnim;
		addAnimation("hitL", hitL);
		
		var attackRAnim = new Animation(new SpriteSheet("Punk/punk_attack", 140, 180, 35, 0), null, 12, false);
		addAnimation("attackR", attackRAnim);
		attackRAnim.onFinished = normalAnim;
		
		var attackLAnim = new Animation(new SpriteSheet("Punk/punk_attack_flip", 140, 180, 35, 0), null, 12, false);
		addAnimation("attackL", attackLAnim);
		attackLAnim.onFinished = normalAnim;
	}
	
}