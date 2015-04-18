package core;
import geom.Vec2;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.geom.Matrix;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * ...
 * @author Thomas B
 */
class Dialog extends Entity
{
	
	var mDialogTxt : TextField;
	var mCurrentCharPos : UInt;
	
	var mTimeToNext : Float;
	var mCarretCounter : Float;
	var mCarretPos : Int;
	var mText : String;
	var mMat : Matrix;
	var mFormat : TextFormat;
	var mWidth : Float;
	
	var mBg : Shape;
	
	var mEnded : Bool;
	var mTimeToDisapear : Float;
	var mEndedTime : Float;
	
	var mOnEnded : Dynamic;
	
	static inline var TEXT_SPEED : Float = 0.035;

	public function new(text : String, onEnded : Dynamic = null) 
	{
		super("Dialog");
		mOnEnded = onEnded;
		mText = text;
		mDialogTxt = new TextField();
		
		mFormat = new TextFormat(Assets.getFont('fonts/nokiafc22.ttf').fontName, 8, 0xffffff);
		mDialogTxt.wordWrap = true;
		mDialogTxt.multiline = true;
		mDialogTxt.embedFonts = true;
		mDialogTxt.selectable = false;
		mDialogTxt.antiAliasType = AntiAliasType.NORMAL;
		mDialogTxt.sharpness = 100;
		mWidth = Game.getInstance().getWidth() / 2;
		mDialogTxt.width = mWidth;
		mDialogTxt.height = 34;
		mTimeToNext = 0;
		mCarretCounter = 0;
		mCarretPos = 0;
		mMat = new Matrix();
		mEndedTime = 0;
		mTimeToDisapear = 1;
		
		mBg = new Shape();
		mBg.graphics.beginFill(0, 0.5);
		mBg.graphics.drawRect( -2, -2, mWidth + 4, mDialogTxt.height + 4);
		mBg.graphics.endFill();
		mBg.graphics.lineStyle(1, 0xffffff);
		mBg.graphics.drawRect( -2, -2, mWidth + 4, mDialogTxt.height + 4);
	}
	
	override public function update(delta:Float) {
		if (mEnded) return;
		mCarretCounter += delta;
		if (mCarretCounter >= mTimeToNext && mCarretPos < mText.length) {
			mDialogTxt.text += mText.charAt(mCarretPos);
			mDialogTxt.setTextFormat(mFormat);
			puaseToNext(mText.charAt(mCarretPos));
			mCarretPos++;
			mCarretCounter = 0;
			mDialogTxt.scrollV = mDialogTxt.numLines + 1;
		}
		
		if (mCarretPos >= mText.length) {
			mEndedTime += delta;
			if(mEndedTime >= mTimeToDisapear){
				mEnded = true;
				if (mOnEnded != null)
					mOnEnded();
			}
		}
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		if(!mEnded){
			super.draw(buffer, dest);
			mMat.identity();
			mMat.translate((Game.getInstance().getWidth() - mWidth) / 2, 10);
			buffer.draw(mBg, mMat);
			buffer.draw(mDialogTxt, mMat);
		}
	}
	
	function puaseToNext(char : String) 
	{
		switch(char) {
			case '.' :
				mTimeToNext = TEXT_SPEED * 15;
			case ',' :
				mTimeToNext = TEXT_SPEED * 10;
			case '!' :
				mTimeToNext = TEXT_SPEED * 15;
			case '?' :
				mTimeToNext = TEXT_SPEED * 20;
			default :
				mTimeToNext = TEXT_SPEED;
		}
	}
	
}