package entities.hud;
import core.Entity;
import entities.ennemies.Boss;
import geom.Vec2;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.Assets;
import openfl.display.BitmapData;

/**
 * ...
 * @author TBaudon
 */
class BossLife extends Entity
{
	
	var mBoss : Boss;
	
	var mBossTxt : BitmapData;

	public function new(boss : Boss) 
	{
		super("bossLife");
		
		mBoss = boss;
		mBossTxt = Assets.getBitmapData("img/hud/Boss.png");
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		
		var lifePercent = mBoss.getLife() / mBoss.getMaxLife();
		
		buffer.fillRect(new Rectangle(10, 450, 780, 20), 0x000000);
		buffer.fillRect(new Rectangle(13, 453, cast 774 * lifePercent, 14), 0xcc3399);
		buffer.copyPixels(mBossTxt, new Rectangle(0, 0, mBossTxt.width, mBossTxt.height), new Point(13, 427));
		
	}
	
}