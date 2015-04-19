package entities;
import core.Animation;
import core.SpriteSheet;
import geom.Vec2;
import openfl.display.BitmapData;

/**
 * ...
 * @author TBaudon
 */
class Explosion extends AnimatedActor
{

	public function new(actor : Actor) 
	{
		super("Explosion");
		
		mDim.x = 267;
		mDim.y = 282;
		
		solid = false;
		
		worldPos.copy(actor.worldPos);
		worldPos.y += mDim.y / 2;
		
		pos.x = worldPos.x;
		pos.y = worldPos.y * Actor.fakeZCoef - mDim.y;
		
		var anim = new Animation(new SpriteSheet("FX/boom", 267, 282), null, 12, false);
		addAnimation("explode", anim);
		anim.onFinished = destroy;
		setAnimation("explode");
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		super.draw(buffer, dest);
	}
	
}