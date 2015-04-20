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
		
		var walkR = new Animation(new SpriteSheet("Punk/punk_walk", 140, 180, 35, 0));
		addAnimation("walkR", walkR);
		walkR.addSound(2, "sounds/stepA.mp3",0.1);
		walkR.addSound(9, "sounds/stepB.mp3",0.1);
		
		var walkL = new Animation(new SpriteSheet("Punk/punk_walk_flip", 140, 180, 35, 0));
		addAnimation("walkL", walkL);
		walkL.addSound(2, "sounds/stepA.mp3",0.1);
		walkL.addSound(9, "sounds/stepB.mp3",0.1);
		
		addAnimation("iddleR", new Animation(new SpriteSheet("Punk/punk_iddle", 140, 180, 35, 0)));
		addAnimation("iddleL", new Animation(new SpriteSheet("Punk/punk_iddle_flip", 140, 180, 35, 0)));
		
		var deathR =  new Animation(new SpriteSheet("Punk/punk_death", 140, 180, 35, 0), null, 12, false);
		addAnimation("deathR", deathR);
		deathR.addSound(1, "sounds/punchB.mp3");
		
		var deathL = new Animation(new SpriteSheet("Punk/punk_death_flip", 140, 180, 35, 0), null, 12, false);
		addAnimation("deathL", deathL);
		deathL.addSound(1, "sounds/punchB.mp3");
		
		var hitR = new Animation(new SpriteSheet("Punk/punk_hit", 140, 180, 35, 0), null, 20, false);
		hitR.onFinished = normalAnim;
		hitR.addSound(1, "sounds/punchA.mp3");
		addAnimation("hitR", hitR);
		
		var hitL = new Animation(new SpriteSheet("Punk/punk_hit_flip", 140, 180, 35, 0), null, 20, false);
		hitL.onFinished = normalAnim;
		hitL.addSound(1, "sounds/punchA.mp3");
		addAnimation("hitL", hitL);
		
		var attackRAnim = new Animation(new SpriteSheet("Punk/punk_attack", 140, 180, 35, 0), null, 12, false);
		addAnimation("attackR", attackRAnim);
		attackRAnim.addSound(1, "sounds/woosh.mp3");
		attackRAnim.onFinished = normalAnim;
		
		var attackLAnim = new Animation(new SpriteSheet("Punk/punk_attack_flip", 140, 180, 35, 0), null, 12, false);
		addAnimation("attackL", attackLAnim);
		attackLAnim.addSound(1, "sounds/woosh.mp3");
		attackLAnim.onFinished = normalAnim;
	}
	
}