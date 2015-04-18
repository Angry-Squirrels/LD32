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
class Pull extends Weapon
{
	
	var mLifeTime : Float;
	var mLifeSpan : Float = 0.2;
	var mLaunched:Bool;

	public function new() 
	{
		super("Pull");
		
		mDamage = 2;
		mGravity = 0;
		
		mDim.x = 60;
		mDim.y = 30;
		
		mLifeTime = 0;
		
		initAnimations();
	}
	
	override public function launch(dir:Int) 
	{
		super.launch(dir);
		mZVel = 0;
		vel.x = 0;
		mMoveSpeed = 0;
		mLaunched = true;
	}
	
	override function update(delta:Float) 
	{
		super.update(delta);
		
		vel.x = 0;
		vel.y = 0;
		
		if(mLaunched){
			mLifeTime += delta;
			if (mLifeTime >= mLifeSpan){
				trace("destroy");
				destroy();
			}
		}
	}
	
	function initAnimations() {
		
		addAnimation("idleR", new Animation(new SpriteSheet("Hero/pull_iddle", 140, 180, 35, 0)));
		addAnimation("idleL", new Animation(new SpriteSheet("Hero/pull_iddle_flip", 140, 180, 35, 0)));
		
		addAnimation("walkR", new Animation(new SpriteSheet("Hero/pull_run", 140, 180, 35, 0), null, 16));
		addAnimation("walkL", new Animation(new SpriteSheet("Hero/pull_run_flip", 140, 180, 35, 0), null, 16));
		
		var kickLRAnim = new Animation(new SpriteSheet("Hero/pull_kickL", 140, 180, 35, 0), null, 12, false); 
		addAnimation("kickLR", kickLRAnim);
		
		var kickLLAnim = new Animation(new SpriteSheet("Hero/pull_kickL_flip", 140, 180, 35, 0), null, 12, false); 
		addAnimation("kickLL", kickLLAnim);
		
		var kickLRAnim = new Animation(new SpriteSheet("Hero/pull_kickR", 140, 180, 35, 0), null, 12, false); 
		addAnimation("kickDR", kickLRAnim);
		
		var kickLLAnim = new Animation(new SpriteSheet("Hero/pull_kickR_flip", 140, 180, 35, 0), null, 12, false); 
		addAnimation("kickDL", kickLLAnim);
		
		var stripRAnim = new Animation(new SpriteSheet("Hero/pull_strip", 140, 180, 35, 0), null, 12, false);
		addAnimation("stripR", stripRAnim);
		
		var stripLAnim = new Animation(new SpriteSheet("Hero/pull_strip_flip", 140, 180, 35, 0), [7,6,5,4,3,2,1,0,15,14,13,12,11,10,9,8], 12, false);
		addAnimation("stripL", stripLAnim);
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		if(!mUseWorldCoord)
			super.draw(buffer, dest);
		else
			buffer.fillRect(new Rectangle(dest.x, dest.y, mDim.x, mDim.y), 0xffff00);
	}
	
	
	
}