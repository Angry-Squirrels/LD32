package screens;
import core.Camera;
import core.Screen;
import entities.Hero;
import entities.World;

/**
 * ...
 * @author TBaudon
 */
class GameScreen extends Screen
{
	
	var mWorld : World;
	var mHero : Hero;

	public function new() 
	{
		super();
		
		mHero = new Hero();
		mWorld = new World();
		
		add(mWorld);
		
		mWorld.add(mHero);
		
		mWorld.focus(mHero);
		
	}
	
	override function update(delta:Float) 
	{
	}
	
}