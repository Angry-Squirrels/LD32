package screens;
import core.Camera;
import core.Game;
import core.Screen;
import entities.hero.Hero;
import entities.Human;
import entities.Punk;
import entities.World;

/**
 * ...
 * @author TBaudon
 */
class GameScreen extends Screen
{
	
	var mWorld : World;
	var mHero : Hero;
	
	var mMaxScroll : Float;
	
	var mGame : Game;

	public function new() 
	{
		super();
		
		mWorld = new World();
		mHero = new Hero(mWorld);
		mMaxScroll = 0;
		
		add(mWorld);
		
		mGame = Game.getInstance();
		
		mWorld.addActor(mHero);
		
		for(i in 0 ... 1){
			var peon = new Punk();
			peon.pos.x = Math.random() * 1000;
			peon.pos.y = Math.random() * 1000;
			mWorld.addActor(peon);
		}
		
		mWorld.focus(mHero);
		
		unlockZone(1000);
	}
	
	override function update(delta:Float) 
	{
		if (mHero.worldPos.x < 0)
			mHero.worldPos.x = 0;
		
		if (mHero.worldPos.x + mHero.getDim().x> mMaxScroll )
			mHero.worldPos.x = mMaxScroll - mHero.getDim().x;
	}
	
	function unlockZone(scroll : Float) {
		if(scroll > mMaxScroll){
			mWorld.setMaxScroll(-scroll);
			mMaxScroll = scroll;
		}
	}
	
}