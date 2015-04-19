package screens;

import core.Game;
import core.Screen;
import geom.Vec2;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

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
		
		Game.getInstance().flash(0x000000, 1.0);
		credits = Assets.getBitmapData("img/hud/credits.png");
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		buffer.copyPixels(credits, new Rectangle(0, 0, 800, 480), new Point(0, 0));
	}
	
}