package entities.hero;
import core.Animation;
import core.Camera;
import core.SpriteSheet;
import entities.Actor;
import entities.Weapon;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class Shoe extends Weapon
{
	
	var mSide : String;
	
	public function new(side : String) 
	{
		super("shoe");
		
		mDim.x = 20;
		mDim.y = 20;
		
		mDamage = 3;
		
		mSide = side;
		
		initAnimations();
	}
	
	function initAnimations() 
	{
		addAnimation("idleR", new Animation(new SpriteSheet("Hero/shoe" + mSide + "_iddle", 140, 180, 35, 0))); 
		addAnimation("idleL", new Animation(new SpriteSheet("Hero/shoe" + mSide + "_iddle_flip", 140, 180, 35, 0))); 
		
		addAnimation("walkR", new Animation(new SpriteSheet("Hero/shoe" + mSide + "_run", 140, 180, 35, 0), null, 16)); 
		addAnimation("walkL", new Animation(new SpriteSheet("Hero/shoe" + mSide + "_run_flip", 140, 180, 35, 0), null, 16)); 
		
		var kickLRAnim = new Animation(new SpriteSheet("Hero/shoe" + mSide + "_kickL", 140, 180, 35, 0), null, 12, false); 
		addAnimation("kickLR", kickLRAnim);
		
		var kickLLAnim = new Animation(new SpriteSheet("Hero/shoe" + mSide + "_kickL_flip", 140, 180, 35, 0), null, 12, false); 
		addAnimation("kickLL", kickLLAnim);
		
		var kickLRAnim = new Animation(new SpriteSheet("Hero/shoe" + mSide + "_kickR", 140, 180, 35, 0), null, 12, false); 
		addAnimation("kickDR", kickLRAnim);
		
		var kickLLAnim = new Animation(new SpriteSheet("Hero/shoe" + mSide + "_kickR_flip", 140, 180, 35, 0), null, 12, false); 
		addAnimation("kickDL", kickLLAnim);
		
		var stripRAnim = new Animation(new SpriteSheet("Hero/shoe" + mSide + "_strip", 140, 180, 35, 0), [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16], 12, false);
		addAnimation("stripR", stripRAnim);
		
		var stripLAnim = new Animation(new SpriteSheet("Hero/shoe" + mSide + "_strip_flip", 140, 180, 35, 0), [8,7,6,5,4,3,2,1,0,16,15,14,13,12,11,10,9], 12, false);
		addAnimation("stripL", stripLAnim);
		
		var cacRAnim = new Animation(new SpriteSheet("Hero/shoe" + mSide + "_cac", 140, 180, 35, 0), null, 12, false);
		addAnimation("cacR", cacRAnim);
		
		var cacLAnim = new Animation(new SpriteSheet("Hero/shoe" + mSide + "_cac_flip", 140, 180, 35, 0), null, 12, false);
		addAnimation("cacL", cacLAnim);
		
		addAnimation("launchedR", new Animation(new SpriteSheet("Hero/shoe", 34, 36 )));
		addAnimation("launchedL", new Animation(new SpriteSheet("Hero/shoe_flip", 34, 36 )));
	}
	
}