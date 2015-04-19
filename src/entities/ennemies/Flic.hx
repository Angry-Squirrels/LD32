package entities.ennemies;
import core.Animation;
import core.SpriteSheet;
import entities.Actor;
import geom.Vec2;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;

/**
 * ...
 * @author TBaudon
 */
class Flic extends Ennemy
{

	public function new() 
	{
		super("Flic");
		
		mMoveSpeed = 40;
		
		initAnimations();
	}
	
	public function pursuit(delta : Float) {
		mMoveSpeed = 70;
		attacking(delta);
	}
	
	function initAnimations() 
	{
		addAnimation("walkR", new Animation(new SpriteSheet("Flic/flic_walk", 140, 180, 35, 0)));
		addAnimation("walkL", new Animation(new SpriteSheet("Flic/flic_walk_flip", 140, 180, 35, 0)));
		
		var attackRAnim = new Animation(new SpriteSheet("Flic/flic_attack", 140, 180, 35, 0), null, 12, false);
		addAnimation("attackR", attackRAnim);
		attackRAnim.onFinished = normalAnim;
		
		var attackLAnim = new Animation(new SpriteSheet("Flic/flic_attack_flip", 140, 180, 35, 0), null, 12, false);
		addAnimation("attackL", attackLAnim);
		attackLAnim.onFinished = normalAnim;
	}
	
	override public function takeDamage(amount:Int, source:Actor) 
	{
		//super.takeDamage(amount, source);
	}
	
	/*override function draw(buffer:BitmapData, dest:Vec2) 
	{
		//super.draw(buffer, dest);
		buffer.fillRect(new Rectangle(dest.x, dest.y, mDim.x, mDim.y), 0xff0000);
	}*/
	
}