package entities;

/**
 * ...
 * @author TBaudon
 */
class Weapon extends Actor
{
	
	var mDamage : Int;

	public function new(name : String) 
	{
		super(name);
		
		mDamage = 1;
	}
	
	public function getDamage() : Int {
		return mDamage;
	}
	
}