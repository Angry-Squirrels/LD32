package entities.hero;
import core.Animation;
import core.SpriteSheet;
import entities.Weapon;
import geom.Vec2;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;

/**
 * ...
 * @author TBaudon
 */
class Callbut extends Weapon
{

	public function new() 
	{
		super("Callbut");
		
		mDamage = 5;
		
		initAnimations();
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		if(!mUseWorldCoord)
			super.draw(buffer, dest);
		else
			buffer.fillRect(new Rectangle(dest.x, dest.y, 20, 20), 0x0000ff);
	}
	
	function initAnimations() 
	{
		addAnimation("idleR", new Animation(new SpriteSheet("Hero/slip_iddle", 140, 180, 35, 0)));
		addAnimation("idleL", new Animation(new SpriteSheet("Hero/slip_iddle_flip", 140, 180, 35, 0)));
		
		addAnimation("walkR", new Animation(new SpriteSheet("Hero/slip_run", 140, 180, 35, 0),null,16));
		addAnimation("walkL", new Animation(new SpriteSheet("Hero/slip_run_flip", 140, 180, 35, 0), null, 16));
		
		var kickLRAnim = new Animation(new SpriteSheet("Hero/slip_kickL", 140, 180, 35, 0), null, 12, false); 
		addAnimation("kickLR", kickLRAnim);
		
		var kickLLAnim = new Animation(new SpriteSheet("Hero/slip_kickL_flip", 140, 180, 35, 0), null, 12, false); 
		addAnimation("kickLL", kickLLAnim);
		
		var kickLRAnim = new Animation(new SpriteSheet("Hero/slip_kickD", 140, 180, 35, 0), null, 12, false); 
		addAnimation("kickDR", kickLRAnim);
		
		var kickLLAnim = new Animation(new SpriteSheet("Hero/slip_kickD_flip", 140, 180, 35, 0), null, 12, false); 
		addAnimation("kickDL", kickLLAnim);
		
		var stripRAnim = new Animation(new SpriteSheet("Hero/slip_strip", 140, 180, 35, 0), [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16], 12, false);
		addAnimation("stripR", stripRAnim);
		
		var stripLAnim = new Animation(new SpriteSheet("Hero/slip_strip_flip", 140, 180, 35, 0), [8,7,6,5,4,3,2,1,0,16,15,14,13,12,11,10,9], 12, false);
		addAnimation("stripL", stripLAnim);
	}
	
}