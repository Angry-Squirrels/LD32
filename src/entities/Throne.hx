package entities;
import core.Animation;
import core.SpriteSheet;

/**
 * ...
 * @author TBaudon
 */
class Throne extends AnimatedActor
{

	public function new() 
	{
		super("Throne");
		
		mDim.x = 0;
		mDim.y = 0;
		
		addAnimation("locked", new Animation(new SpriteSheet("Decors/throne1",  874, 480)));
		addAnimation("opened", new Animation(new SpriteSheet("Decors/throne2",  874, 480)));
		
		setAnimation("locked");
		
		mUseWorldCoord = false;
	}
	
	override function update(delta:Float) 
	{
		super.update(delta);
	}
	
	public function casse() {
		setAnimation("opened");
	}
	
}