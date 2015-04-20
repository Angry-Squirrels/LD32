package core;
import geom.Vec2;
import haxe.Timer;

/**
 * ...
 * @author Thomas BAUDON
 */
class Camera
{
	
	var mTargetEntity : Entity;
	var mShakeIntensity:Int;
	var mShakeTime:Int;
	var mShakePhase : Int;
	var mShaking : Bool;
	var mGame : Game;
	
	public var shakeOffsetX : Int;
	public var shakeOffsetY : Int;
	
	var mLastOffsetXSent : Int;
	var mLastOffsetYSent : Int;
	
	var totalShakeXOffset : Int;
	var totalShakeYOffset : Int;
	
	var mShakeTimeF : Float;
	var mScreenDivision : Int = 2;
	
	public var pos : Vec2;
	
	public static var instance : Camera;

	public function new() 
	{
		pos = new Vec2();
		mGame = Game.getInstance();
		instance = this;
	}
	
	public function setTarget(ent : Entity) {
		mTargetEntity = ent;
	}
	
	public function update(delta : Float) {
		if (mTargetEntity != null) {
			var targetx = mTargetEntity.pos.x + (mTargetEntity.getDim().x - mGame.getWidth()) / mScreenDivision;
			var targety = mTargetEntity.pos.y + (mTargetEntity.getDim().y - mGame.getHeight()) / 2;
			
			pos.x += (targetx - pos.x) / 2;
			pos.y += (targety - pos.y) / 2;
		}
		
		if (mShaking || mShakePhase == 1) {
		
			mShakeTimeF += delta;
			
			if (mShakeTimeF > 0.025){
			
				if (mShakePhase == 0) {
					shakeOffsetX = cast Math.random() * mShakeIntensity * 2 - mShakeIntensity;
					shakeOffsetY = cast Math.random() * mShakeIntensity * 2 - mShakeIntensity;
					
					totalShakeXOffset += shakeOffsetX;
					totalShakeYOffset += shakeOffsetY;
					
					mShakePhase = 1;
				}else {
					shakeOffsetX = -shakeOffsetX;
					shakeOffsetY = -shakeOffsetY;
					
					totalShakeXOffset += shakeOffsetX;
					totalShakeYOffset += shakeOffsetY;
					
					mShakePhase = 0;
				}	
				
				mShakeTimeF = 0;
			}
		}else {
			shakeOffsetX = 0;
			shakeOffsetY = 0;
		}
		
	}
	
	public function setBossMode() {
		mScreenDivision = 8;
	}
	
	public function setNormalMode() {
		mScreenDivision = 2;
	}
	
	public function getShakeOffsetX():Int {
		if (shakeOffsetX == mLastOffsetXSent)
			return 0;
		else {
			mLastOffsetXSent = shakeOffsetX;
			return shakeOffsetX;
		}
	}
	
	public function getShakeOffsetY():Int {
		if (shakeOffsetY == mLastOffsetYSent)
			return 0;
		else {
			mLastOffsetYSent = shakeOffsetY;
			return shakeOffsetY;
		}
	}
	
	public function shake(intensity : Int, time : Int) {
		startShake(intensity);
		Timer.delay(stopShake, time);
	}
	
	public function isShaking() : Bool {
		return mShaking;
	}
	
	public function startShake(intensity : Int) {
		mShaking = true;
		
		shakeOffsetX = 0;
		shakeOffsetY = 0;
		
		mShakeTime = 0;
		mShakeTimeF = 0;
		
		totalShakeXOffset = 0;
		totalShakeYOffset = 0;
		
		mLastOffsetXSent = 0;
		mLastOffsetYSent = 0;
		
		mShakePhase = 0;
		mShakeIntensity = intensity;
	}
	
	public function stopShake() {
		mShaking = false;
		
	}
	
}