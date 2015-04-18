package;

import core.Game;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.Lib;
import screens.GameScreen;

/**
 * ...
 * @author TBaudon
 */

class Main extends Sprite 
{

	public function new() 
	{
		super();
		
		var game = Game.init(1);
		game.gotoScreen(new GameScreen());
		addChild(game);
		
		addChild(new FPS(0,0,0xffffff));
	}
}
