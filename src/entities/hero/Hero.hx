package entities.hero;
import core.Animation;
import core.Entity;
import core.SpriteSheet;
import entities.Actor;
import entities.Human;
import entities.World;
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
	var mXDown:Bool;
	
	public var mShoes : Array<Shoe>;
	
	public var mPant : Actor;
	public var mCalbut : Callbut;
	public var mShirts : Array<Actor>;
	
	var mHeading : Int;
	var mWorld : World;
	var mShoeLaunched = false;
	
	var mCurrentState : Float -> Void;
	var mLastStripableBody:Actor;
	
	public static inline var HERO : String = "Hero";

	public function new(world : World) 
	{
		super(HERO);
		
		mDim.x = 65; 
		mDim.y = 170;
		
		mWorld = world;
		
		mHeading = 1;
		
		initClothes();
		giveClothes();
		
		initAnimations();
		
		mShirts = new Array<Actor>();
		
		addListeners();
		
		mCurrentState = normalState;
	}
	
	///// clothes
	
	function initClothes() 
	{
		mShoes = new Array<Shoe>();
	}
	
	function giveClothes() : Void {
		giveShoe();
		giveShoe();
		giveCallbut();
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
	
	public function giveCallbut() {
		if (mCalbut != null) return;
		else {
			mCalbut = new Callbut();
			add(mCalbut);
		}
	}
	
	///// end clothes
	
	function addListeners() 
	{
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	function playAnim(name : String) {
		if (mHeading > 0)
			name += "R";
		else
			name += "L";
			
		setAnimation(name);
		
		if (mCalbut != null) 
			mCalbut.setAnimation(name);
		
	}
	
	function onKeyUp(e:KeyboardEvent):Void 
	{
		switch (e.keyCode) {
			case Keyboard.X :
				mXDown = false;
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
			case Keyboard.X : 
				if (!mXDown) {
					onXPressed();
					mXDown = true;
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
	
	function onXPressed(){
		if (mLastStripableBody != null && 
			hitTest(this, mLastStripableBody) &&
			worldPos.y <= mLastStripableBody.worldPos.y)
			stripBody();
		else {
			attack();
		}
	}
	
	function attack() {
		
	}
	
	function stripBody() {
		setStripState();
	}
	
	function stripEnded() {
		giveClothes();
		setNormalState();
		mLastStripableBody.destroy();
		mLastStripableBody = null;
	}
	
	override function update(delta:Float) 
	{
		super.update(delta);
		
		if (vel.x < 0)
			mHeading = -1;
		else
			mHeading = 1;
		
		if (mCurrentState != null)
			mCurrentState(delta);
		
	}
	
	function normalState(delta : Float) {
		playAnim("idle");
		
		mMoveSpeed = 100;
		
		if (vel.length() > 15)
			setWalkState();
	}
	
	function kickState(delta : Float) {
		
		mMoveSpeed = 0;
		
		if(!mShoeLaunched){
			if(mShoes.length > 1)
				playAnim("kickL");
			else 
				playAnim("kickD");
		}
			
		if (mAnimation.getCurrentFrame() == 3 && !mShoeLaunched)
		{
			var shoe : Shoe = mShoes.pop();
			remove(shoe);
			shoe.launch(mHeading);
			mWorld.addActor(shoe);
			shoe.worldPos.x = worldPos.x + 70 * mHeading;
			shoe.worldPos.y = worldPos.y;
			mShoeLaunched = true;
		}
	}
	
	function walkState(delta : Float) {
		playAnim("walk");
		
		if (vel.length() < 15)
			setNormalState();
	}
	
	function stripState(delta : Float) {
		playAnim("strip");
		
		mMoveSpeed = 0;
	}
	
	function setNormalState() {
		mCurrentState = normalState;
	}
	
	function setKickState() {
		mShoeLaunched = false;
		mCurrentState = kickState;
	}
	
	function setWalkState() {
		mCurrentState = walkState;
	}
	
	function setStripState() {
		mCurrentState = stripState;
	}
	
	
	function throwShoe() 
	{
		if (mShoes.length > 0) 
			setKickState();
	}
	
	override public function onCollide(actor:Actor) 
	{
		super.onCollide(actor);
		
		if (Std.is(actor, Punk) && actor.isDead()) {
			if (worldPos.y < actor.worldPos.y)
				mLastStripableBody = actor;
		}
	}
	
	function initAnimations():Void 
	{
		addAnimation("idleR", new Animation(new SpriteSheet("Hero/franky_iddle", 140, 180, 35, 0))); 
		addAnimation("idleL", new Animation(new SpriteSheet("Hero/franky_iddle_flip", 140, 180, 35, 0))); 
		
		addAnimation("walkR", new Animation(new SpriteSheet("Hero/franky_run", 140, 180, 35, 0), null, 16)); 
		addAnimation("walkL", new Animation(new SpriteSheet("Hero/franky_run_flip", 140, 180, 35, 0), null, 16)); 
		
		var kickLRAnim = new Animation(new SpriteSheet("Hero/franky_kickL", 140, 180, 35, 0), null, 12, false); 
		kickLRAnim.onFinished = setNormalState;
		addAnimation("kickLR", kickLRAnim);
		
		var kickLLAnim = new Animation(new SpriteSheet("Hero/franky_kickL_flip", 140, 180, 35, 0), null, 12, false); 
		kickLLAnim.onFinished = setNormalState;
		addAnimation("kickLL", kickLLAnim);
		
		var kickLRAnim = new Animation(new SpriteSheet("Hero/franky_kickD", 140, 180, 35, 0), null, 12, false); 
		kickLRAnim.onFinished = setNormalState;
		addAnimation("kickDR", kickLRAnim);
		
		var kickLLAnim = new Animation(new SpriteSheet("Hero/franky_kickD_flip", 140, 180, 35, 0), null, 12, false); 
		kickLLAnim.onFinished = setNormalState;
		addAnimation("kickDL", kickLLAnim);
		
		var stripRAnim = new Animation(new SpriteSheet("Hero/franky_strip", 140, 180, 35, 0), null, 12, false);
		stripRAnim.onFinished = stripEnded;
		addAnimation("stripR", stripRAnim);
		
		var stripLAnim = new Animation(new SpriteSheet("Hero/franky_strip_flip", 140, 180, 35, 0), [7,6,5,4,3,2,1,0,15,14,13,12,11,10,9,8], 12, false);
		stripLAnim.onFinished = stripEnded;
		addAnimation("stripL", stripLAnim);
		
		
	}
	
}