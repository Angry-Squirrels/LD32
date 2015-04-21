package screens;
import core.Camera;
import core.Entity;
import core.Game;
import core.Screen;
import entities.hero.Hero;
import entities.hud.BossLife;
import entities.hud.HUD;
import entities.Human;
import entities.ennemies.Ennemy;
import entities.ennemies.EnnemyManager;
import entities.World;
import geom.Vec2;
import openfl.Assets;
import openfl.display.Shape;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;
import screens.GameOver;

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
	
	var mVictoryTimer : Float;
	var mVictoryTimerStarted : Bool;
	
	var mMusic : Sound;
	static var mMusicSoundChannel : SoundChannel;
	
	var mBossBar : BossLife;
	
	var mFadeSquare : Shape;
	var mNextScreen:Screen;
	var mEndReached:Bool;

	public function new() 
	{
		super();
		
		Main.score = 0;
		
		mWorld = new World();
		mHero = new Hero(mWorld);
		mEnnemyManager = new EnnemyManager(mHero, mWorld);
		mMaxScroll = 0;
		
		if (mMusicSoundChannel != null)
			mMusicSoundChannel.stop();
		
		mVictoryTimer = 0;
		
		mGameOverTimer = 0;
		
		#if html5
		mMusic = Assets.getSound("sounds/Blown Away.ogg");
		#elseif flash
		mMusic = Assets.getSound("sounds/Blown Away.mp3");
		#end
		var soundTransform = new SoundTransform();
		soundTransform.volume = 0.05;
		mMusicSoundChannel = mMusic.play(0, 10000000, soundTransform);
		
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
			
		if (mEnnemyManager.hasBoss() && mHero.worldPos.x > mMaxScroll-800){
			Camera.instance.setBossMode();
			if (mBossBar == null) {
				mBossBar = new BossLife(mEnnemyManager.getBoss());
				add(mBossBar);
			}
		}else{
			Camera.instance.setNormalMode();
		}
		
		if (mHero.worldPos.x + mHero.getDim().x> mMaxScroll )
			mHero.worldPos.x = mMaxScroll - mHero.getDim().x;
			
		if (mHero.isCaught() && !mGameOverTimerStarted) {
			mNextScreen = new GameOver();
			mGameOverTimerStarted = true;
		}
		
		if (mEnnemyManager.getBoss() != null && mEnnemyManager.getBoss().isDead() && !mVictoryTimerStarted){
			mNextScreen = new Victory();
			mVictoryTimerStarted = true;
		}
		
		if (mEnnemyManager.hasBoss() && mEnnemyManager.getBoss().phase == 1 && !mEndReached){
			mMaxScroll += 330;
			mEndReached = true;
		}
		
		if (mVictoryTimerStarted){
			mVictoryTimer += delta;
			if (mVictoryTimer > 3)
				mGameOverTimerStarted = true;
		}
		
		if (mGameOverTimerStarted) {
			mGameOverTimer += delta;
			mMusicSoundChannel.stop();
			if (mGameOverTimer > mGameOverDelay) {
				Game.getInstance().flash(0x000000, 1.0);	
				mGame.gotoScreen(mNextScreen);
			}
		}
	}
	
	function nextWave() {
		unlockZone(mMaxScroll + mZonoeSize);
		mEnnemyManager.spawnPunk(mCurrentWave);
		mCurrentWave++;
	}
	
	function unlockZone(scroll : Float) {
		if(scroll > mMaxScroll){
			mMaxScroll = scroll;
			mWorld.generateBuilding(cast mMaxScroll);
		}
	}
	
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