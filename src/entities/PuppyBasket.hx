package entities;
import core.Animation;
import core.Entity;
import core.SpriteSheet;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class PuppyBasket extends AnimatedActor
{

	public function new() 
	{
		super("Puppies");
		
		mDim.x = 120;
		mDim.y = 95;
		
		solid = false;
		unpushable = true;
		
		mUseWorldCoord = true;
		
		addAnimation("normal", new Animation(new SpriteSheet("Boss/puppies", 120, 95), [0]));
		setAnimation("normal");
		
	}

	
}