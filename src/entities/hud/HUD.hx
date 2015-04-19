package entities.hud;
import core.Entity;
import core.Game;

/**
 * ...
 * @author TBaudon
 */
class HUD extends Entity
{
	
	var mGo : Go;
	
	var mGoAdded : Bool;

	public function new() 
	{
		super("HUD");
		
		mGo = new Go();
		mGo.pos.x = Game.getInstance().getWidth() - 250;
		mGo.pos.y = Game.getInstance().getHeight() / 4 - 50;
	}
	
	public function stopShowNext() 
	{
		if(mGoAdded){
			remove(mGo);
			mGoAdded = false;
		}
	}
	
	public function showNext() 
	{
		if(!mGoAdded){
			add(mGo);
			mGoAdded = true;
		}
	}
	
}