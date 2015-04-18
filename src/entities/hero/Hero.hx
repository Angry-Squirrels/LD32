package entities.hero;
import core.Entity;
import entities.Human;
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
class Hero extends Human
{
	var mCDown:Bool;
	
	public var mShoes : Array<Shoe>;
	
	public var mPant : Actor;
	public var mCalbut : Actor;
	public var mShirts : Array<Actor>;
	
	public static inline var HERO : String = "Hero";

	public function new() 
	{
		super(HERO);
		
		initShoes();
		
		mShirts = new Array<Actor>();
		
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
			case Keyboard.C :
				mCDown = false;
			case Keyboard.UP :
				if(mYAxis == -1)
					mYAxis = 0;
			case Keyboard.DOWN :
				if(mYAxis == 1)
					mYAxis = 0;
			case Keyboard.LEFT :
				if(mXAxis == -1)
					mXAxis = 0;
			case Keyboard.RIGHT :
				if(mXAxis == 1)
					mXAxis = 0;
		}
	}
	
	function onKeyDown(e:KeyboardEvent):Void 
	{
		switch (e.keyCode) {
			case Keyboard.C :
				if(!mCDown){
					throwShoe();
					mCDown = true;
				}
			case Keyboard.UP :
				mYAxis = -1;
			case Keyboard.DOWN :
				mYAxis = 1;
			case Keyboard.LEFT :
				mXAxis = -1;
			case Keyboard.RIGHT :
				mXAxis = 1;
		}
	}
	
	function throwShoe() 
	{
		var shoe = mShoes.pop();
		if (shoe != null)
			remove(shoe);
	}
	
	public function giveShoe() {
		var shoe : Shoe;
		if (mShoes.length == 0){
			shoe = new Shoe("left");
			shoe.pos.x = 1;
		}
		else if (mShoes.length == 1) {
			shoe = new Shoe("right");
			shoe.pos.x = mDim.x - shoe.getDim().x - 1;
		}
		else
			return;
			
		shoe.pos.y = mDim.y - shoe.getDim().y - 1;
		add(shoe);
		mShoes.push(shoe);
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		buffer.fillRect(new Rectangle(dest.x, dest.y, mDim.x, mDim.y), 0xff0000);
	}
	
	function initShoes():Void 
	{
		mShoes = new Array<Shoe>();
		giveShoe();
		giveShoe();
	}
	
}