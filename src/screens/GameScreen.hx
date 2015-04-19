package screens;
import core.Camera;
import core.Entity;
import core.Game;
import core.Screen;
import entities.hero.Hero;
import entities.hud.HUD;
import entities.Human;
import entities.Punk;
import entities.PunkManager;
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
	
	var mPunkManager : PunkManager;
	
	var mZonoeSize : Int = 1000;
	
	var mCurrentWave : Int = 1;
	
	var mHud : HUD;

	public function new() 
	{
		super();
		
		
		mWorld = new World();
		mHero = new Hero(mWorld);
		mPunkManager = new PunkManager(mHero, mWorld);
		mMaxScroll = 0;
		
		mHud = new HUD();
		
		add(mWorld);
		
		mGame = Game.getInstance();
		
		mWorld.addActor(mHero);
		
		add(mHud);
		
		mWorld.focus(mHero);
		
		unlockZone(mZonoeSize);
	}
	
	override function update(delta:Float) 
	{
		mPunkManager.update();
		
		if (mPunkManager.getPunkAlive() <= 0 && mHero.worldPos.x >= mMaxScroll - 250){
			nextWave();
			mHud.stopShowNext();
		}else if(mPunkManager.getPunkAlive() <= 0){
			mHud.showNext();
		}
		
		if (mHero.worldPos.x < 0)
			mHero.worldPos.x = 0;
		
		if (mHero.worldPos.x + mHero.getDim().x> mMaxScroll )
			mHero.worldPos.x = mMaxScroll - mHero.getDim().x;
	}
	
	function nextWave() {
		mPunkManager.spawnPunk(mCurrentWave);
		mCurrentWave++;
		unlockZone(mMaxScroll + mZonoeSize);
	}
	
	function unlockZone(scroll : Float) {
		if(scroll > mMaxScroll){
			mMaxScroll = scroll;
			mWorld.generateBuilding(cast mMaxScroll);
		}
	}
	
}