package screens;

import core.Game;
import core.Screen;
import geom.Vec2;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.events.KeyboardEvent;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.Lib;
import openfl.ui.Keyboard;

/**
 * ...
 * @author TBaudon
 */
class GameOver extends Screen
{
	
	var credits : BitmapData;

	public function new() 
	{
		super();
		
		credits = Assets.getBitmapData("img/hud/credits.png");
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	private function onKeyDown(e:KeyboardEvent):Void 
	{
		if (e.keyCode == Keyboard.R)
			Game.getInstance().gotoScreen(new GameScreen());
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		buffer.copyPixels(credits, new Rectangle(0, 0, 800, 480), new Point(0, 0));
	}
	
}