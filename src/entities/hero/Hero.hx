package entities.hero;
import core.Animation;
import core.Entity;
import core.SpriteSheet;
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
	
	var mHeading : Int;
	var mSpecialMove:Bool;
	
	public static inline var HERO : String = "Hero";

	public function new() 
	{
		super(HERO);
		
		mDim.x = 65; 
		mDim.y = 170;
		
		mHeading = 1;
		
		initShoes();
		
		mAnimations["idleR"] = new Animation(new SpriteSheet("Hero/franky_iddle", 140, 180, 35, 0),null,20); 
		mAnimations["walkR"] = new Animation(new SpriteSheet("Hero/franky_run", 140, 180, 35, 0)); 
		
		var kickLRAnim = new Animation(new SpriteSheet("Hero/franky_kickL", 140, 180, 35, 0), null, 12, false); 
		kickLRAnim.onFinished = backToIdle;
		mAnimations["kickLR"] = kickLRAnim;
		
		mShirts = new Array<Actor>();
		
		addListeners();
	}
	
	function addListeners() 
	{
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	function backToIdle() {
		mSpecialMove = false;
		if (mHeading > 0)
			setAnimation("idleR");
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
				if (mXAxis == 1) 
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
	
	override function update(delta:Float) 
	{
		super.update(delta);
		
		if (vel.x < 0)
			mHeading = -1;
		else
			mHeading = 1;
		
		if(!mSpecialMove){
			if (vel.length() < 15)
				backToIdle();
			else {
				if (mHeading > 0)
					setAnimation("walkR");
			}
		}
		
	}
	
	function throwShoe() 
	{
		var shoe = mShoes.pop();
		if (shoe != null) {
			mSpecialMove = true;
			setAnimation("kickLR");
			remove(shoe);
		}
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
		if (mAnimation != null) {
			var p = new Vec2();
			p.x = dest.x;
			p.y = dest.y;
			p.x -= mAnimation.getSpriteSheet().offsetX;
			p.y -= mAnimation.getSpriteSheet().offsetY;
			buffer.copyPixels(mAnimation.getSource(), mAnimation.getFrame(), p.toPoint());
		}else
			buffer.fillRect(new Rectangle(dest.x, dest.y, mDim.x, mDim.y), 0xff0000);
	}
	
	function initShoes():Void 
	{
		mShoes = new Array<Shoe>();
		giveShoe();
		giveShoe();
	}
	
}