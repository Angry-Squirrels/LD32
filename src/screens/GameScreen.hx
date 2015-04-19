package screens;
import core.Camera;
import core.Entity;
import core.Game;
import core.Screen;
import entities.hero.Hero;
import entities.hud.HUD;
import entities.Human;
import entities.ennemies.Ennemy;
import entities.ennemies.EnnemyManager;
import entities.World;
import geom.Vec2;
import openfl.display.Shape;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;

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
	
	var mEnnemyManager : EnnemyManager;
	
	var mZonoeSize : Int = 1000;
	
	var mCurrentWave : Int = 1;
	
	var mHud : HUD;
	var mGameOverTimer:Float;
	var mGameOverDelay : Float = 1.0;
	var mGameOverTimerStarted:Bool;

	public function new() 
	{
		super();
		
		
		mWorld = new World();
		mHero = new Hero(mWorld);
		mEnnemyManager = new EnnemyManager(mHero, mWorld);
		mMaxScroll = 0;
		
		mGameOverTimer = 0;
		
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
		mEnnemyManager.update();
		
		if (mEnnemyManager.getEnnemiesAlive() <= 0 && mHero.worldPos.x >= mMaxScroll - 250){
			nextWave();
			mHud.stopShowNext();
		}else if(mEnnemyManager.getEnnemiesAlive() <= 0){
			mHud.showNext();
		}
		
		if (mHero.worldPos.x < 0)
			mHero.worldPos.x = 0;
		
		if (mHero.worldPos.x + mHero.getDim().x> mMaxScroll )
			mHero.worldPos.x = mMaxScroll - mHero.getDim().x;
			
		if (mHero.isCaught() && !mGameOverTimerStarted) {
			mGameOverTimerStarted = true;
		}
		
		if (mGameOverTimerStarted) {
			mGameOverTimer += delta;
			if (mGameOverTimer > mGameOverDelay)
				mGame.gotoScreen(new GameOver());
		}
	}
	
	function nextWave() {
		mEnnemyManager.spawnPunk(mCurrentWave);
		mCurrentWave++;
		unlockZone(mMaxScroll + mZonoeSize);
	}
	
	function unlockZone(scroll : Float) {
		if(scroll > mMaxScroll){
			mMaxScroll = scroll;
			mWorld.generateBuilding(cast mMaxScroll);
		}
	}
	
	var mFadeSquare : Shape;
	
	override public function _draw(buffer:BitmapData, dest:Vec2) 
	{
		super._draw(buffer, dest);
		
		if (mFadeSquare == null) 
			mFadeSquare = new Shape();
		
		mFadeSquare.graphics.clear();
		mFadeSquare.graphics.beginFill(0x000000, mGameOverTimer);
		mFadeSquare.graphics.drawRect(0, 0, 800, 480);
		buffer.draw(mFadeSquare);
	}
	
}