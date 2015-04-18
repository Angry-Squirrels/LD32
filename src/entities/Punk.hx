package entities;
import entities.Actor;
import entities.hero.Hero;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author TBaudon
 */
class Punk extends Human
{
	
	var mTarget : Actor;
	
	var mRange : Float = 100;

	public function new() 
	{
		super("Punk");
		
		mMoveSpeed = 40;
	}
	
	override public function setOthersActors(actors:Array<Actor>) 
	{
		super.setOthersActors(actors);
		
		for (actor in actors)
			if (actor.name == Hero.HERO)
				mTarget = actor;
	}
	
	override function update(delta:Float) 
	{
		super.update(delta);
		if (isDead()) {
			mDim.x = 120;
			mDim.y = 72;
			vel.x = 0;
			vel.y = 0;
			mXAxis = 0;
			mYAxis = 0;
			return;
		}
		if (mTarget != null && Vec2.Dist(mTarget.worldPos, worldPos) > mRange)
			moveTowardTarget();
		else {
			mXAxis = 0;
			mYAxis = 0;
		}
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		if(!isDead())
			super.draw(buffer, dest);
		else
			buffer.fillRect(new Rectangle(dest.x, dest.y, 162, 72), 0x006699);
	}
	
	function moveTowardTarget() 
	{
		var targetPos = mTarget.pos.clone();
		targetPos.x += mTarget.getDim().x / 2;
		targetPos.y += mTarget.getDim().y;
		
		var destPos = pos.clone();
		destPos.x += getDim().x / 2;
		destPos.y += getDim().y;
		
		var axis = Vec2.Sub(targetPos, destPos);
		axis = Vec2.Norm(axis);
		
		mYAxis = axis.y;
		mXAxis = axis.x;
	}
	
	
	
}