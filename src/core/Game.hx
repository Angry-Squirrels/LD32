package core ;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.BlendMode;
import openfl.display.PixelSnapping;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.geom.Rectangle;
import openfl.Lib;
import openfl.events.Event;
import openfl.system.System;

/**
 * ...
 * @author Thomas BAUDON
 */
class Game extends Sprite
{
	var mLastTime : UInt;
	
	// rendering
	var mPixelSize : UInt;
	var mBuffer : BitmapData;
	var mClearRect : Rectangle;
	var mCanvas : Bitmap;
	
	var mFlash : Shape;
	var mFlashFadeTime : Float;
	var mFlashCounter : Float;
	
	var mDeltas : Array<Float>;
	var mCurrentDelta : Int;
	var mDelta : Float;
	var mDeltaSample : Int = 10;
	
	// screen
	var mCurrentScreen : Screen;
	
	static var mInstance : Game;
	
	public static function init(pixelSize : UInt = 3) : Game {
		if (mInstance == null)
			mInstance = new Game(pixelSize);
		return mInstance;
	}
	
	public static function getInstance() : Game {
		return mInstance;
	}

	function new(pixelSize : UInt = 2) 
	{
		super();
		
		mDeltas = new Array<Float>();
		for (i in 0 ... mDeltaSample)
			mDeltas.push(0.016);
		mCurrentDelta = mDeltas.length - 1;
		
		initRender(pixelSize);
		
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, update);
		mLastTime = Lib.getTimer();
	}
	
	public function gotoScreen(screen : Screen) {
		if (mCurrentScreen != null)
			mCurrentScreen.destroy();
			
		mCurrentScreen = screen;
	}
	
	function initRender(pixelSize:UInt) 
	{
		mPixelSize = pixelSize;
		var bW : Int = Std.int(Lib.current.stage.stageWidth / mPixelSize);
		var bH : Int = Std.int(Lib.current.stage.stageHeight / mPixelSize);
		mBuffer = new BitmapData(bW, bH, false, 0);
		mClearRect = new Rectangle(0, 0, bW, bH);
		
		mCanvas = new Bitmap(mBuffer, PixelSnapping.ALWAYS, false);
		mCanvas.scaleX = mPixelSize;
		mCanvas.scaleY = mPixelSize;
		
		addChild(mCanvas);
		
		initFlash();
		
		#if flash
		var bevel = new Bitmap(new BitmapData(cast mCanvas.width,cast mCanvas.height,false,0x808080));
		bevel.blendMode = BlendMode.OVERLAY; 
		addChild(bevel);
		
		for (i in 0 ... cast bevel.height) 
			for (j in 0 ... cast bevel.width) 
				if (j % pixelSize== 0 && i % pixelSize == 0) {
					bevel.bitmapData.setPixel(j, i, 0);
					bevel.bitmapData.setPixel(j-1, i-1, 0);
					bevel.bitmapData.setPixel(j-2, i-2, 0);
				}
		#end
	}
	
	function update(e :Event) {
		var time = Lib.getTimer();
		var delta = (time - mLastTime) / 1000;
		mLastTime = time;
		
		updateFlash(delta);
		mCurrentDelta++;
		if (mCurrentDelta == mDeltas.length) {
			mCurrentDelta = 0;
			mDelta = 0;
			for (d in mDeltas)
				mDelta += d;
			mDelta = mDelta / mDeltas.length;
		}
		
		mDeltas[mCurrentDelta] = delta;
		
		if (mCurrentScreen != null){
			mCurrentScreen._update(mDelta);
			render();
		}
	}
	
	function render() : Void 
	{
		mBuffer.lock();
		mBuffer.fillRect(mClearRect, 0);
		mCurrentScreen._draw(mBuffer, mCurrentScreen.pos);
		mBuffer.unlock();
	}
	
	public function flash(color : UInt, fadeTime : Float) {
		mFlash.graphics.beginFill(color);
		mFlash.graphics.drawRect(0, 0, mCanvas.width, mCanvas.height);
		mFlash.graphics.endFill();
		mFlash.alpha = 1;
		mFlashCounter = fadeTime;
		mFlashFadeTime = fadeTime;
	}
	
	function initFlash():Void 
	{
		mFlash = new Shape();
		addChild(mFlash);
		mFlash.alpha = 0;
		mFlashFadeTime = 0;
		mFlashCounter = 0;
	}
	
	function updateFlash(delta:Float) {
		if (mFlashCounter > 0) {
			mFlashCounter -= delta;
			if (mFlashCounter < 0)
				mFlashCounter = 0;
			mFlash.alpha = mFlashCounter / mFlashFadeTime;
		}
	}
	
	public function getPixelsSize() : UInt {
		return mPixelSize;
	}
	
	public function getWidth() : Int {
		return mBuffer.width;
	}
	
	public function getHeight() : Int {
		return mBuffer.height;
	}
	
}