package entities;
import core.Animation;
import core.SpriteSheet;

/**
 * ...
 * @author TBaudon
 */
class Thorn extends AnimatedActor
{

	public function new(actor : Actor) 
	{
		super("Thorn");
		
		mDim.x = 140;
		mDim.y = 250;
		
		solid = false;
		
		worldPos.copy(actor.worldPos);
		worldPos.y += mDim.y / 2;
		
		pos.x = worldPos.x;
		pos.y = worldPos.y * Actor.fakeZCoef - mDim.y;
		
		var anim = new Animation(new SpriteSheet("FX/torn", 140, 180), null, 12, false);
		addAnimation("explode", anim);
		anim.onFinished = destroy;
		setAnimation("explode");
	}
	
}