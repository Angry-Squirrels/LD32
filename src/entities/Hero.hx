package entities;
import core.Entity;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.events.KeyboardEvent;
import openfl.geom.Rectangle;
import openfl.Lib;
import openfl.ui.Keyboard;

/**
 * ...
 * @author TBaudon
 */
class Hero extends Walker
{

	public function new() 
	{
		super("Hero");
		
		mDim.x = 76;
		mDim.y = 162;
		
		addListeners();
	}
	
	function addListeners() 
	{
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	function onKeyUp(e:KeyboardEvent):Void 
	{
		switch (e.keyCode) {
			case Keyboard.Z :
				if(mYAxis == -1)
					mYAxis = 0;
			case Keyboard.S :
				if(mYAxis == 1)
					mYAxis = 0;
			case Keyboard.Q :
				if(mXAxis == -1)
					mXAxis = 0;
			case Keyboard.D :
				if(mXAxis == 1)
					mXAxis = 0;
		}
	}
	
	function onKeyDown(e:KeyboardEvent):Void 
	{
		switch (e.keyCode) {
			case Keyboard.Z :
				mYAxis = -1;
			case Keyboard.S :
				mYAxis = 1;
			case Keyboard.Q :
				mXAxis = -1;
			case Keyboard.D :
				mXAxis = 1;
		}
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		buffer.fillRect(new Rectangle(dest.x, dest.y, mDim.x, mDim.y), 0xff0000);
		
	}
	
}