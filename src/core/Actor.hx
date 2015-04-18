package core ;
import core.Actor;
import core.Level.HitDirection;
import entities.Hero;
import entities.Laser;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Thomas BAUDON
 */
class Actor extends Entity
{
	
	var mLevel : Level;
	
	var mNextPos : Vec2;
	var mNextPosBL : Vec2;
	var mNextPosTR : Vec2;
	var mNextPosBR : Vec2;
	
	var mOnFloor : Bool;
	var mBlockedRight : Bool;
	var mBlockedLeft : Bool;
	
	var mTopCollisionSensor : Array<Vec2>;
	
	var mSpriteSheet : SpriteSheet;
	var mAnimation : Animation;
	var mCurrentFrame : Int;
	var mFloorFriction : Float;
	var mAirFriction : Float;
	
	var mSolid : Bool;
	var mStatic : Bool;
	
	var mTimeMutiplier : Float;
	var mSlowDownTimeCounter : Float;
	
	var mTopCollision:Actor;
	var mLeftCollision : Actor;
	var mRightCollision : Actor;
	var mDownCollition : Actor;
	var mDead : Bool;
	
	var mAirTime : Float;
	var mMinAirTimeToLand : Float;
	
	public static var AllActors : Array<Actor>;

	public function new(spriteSheet : String = null) 
	{
		super();
		
		if (AllActors == null)
			AllActors = new Array<Actor>();
		AllActors.push(this);
		
		mNextPos = new Vec2();
		mNextPosBL = new Vec2();
		mNextPosTR = new Vec2();
		mNextPosBR = new Vec2();
		collidable = true;
		if(spriteSheet != null)
			mSpriteSheet = new SpriteSheet(spriteSheet, 16, 16);
		mCurrentFrame = 0;
		mDim.set(10, 10);
		mFloorFriction = 0.75;
		mAirFriction = 0.98;
		mTimeMutiplier = 1;
		mAirTime = 0;
		mMinAirTimeToLand = 0.2;
	}
	
	public function setStatic(s : Bool) {
		mStatic = s;
	}
	
	public function setLevel(level : Level) {
		mLevel = level;
	}
	
	override function draw(buffer:BitmapData, dest:Vec2) 
	{
		super.draw(buffer, dest);
		if(mSpriteSheet != null){
			dest.x -= mSpriteSheet.offsetX;
			dest.y -= mSpriteSheet.offsetY;
			buffer.copyPixels(mSpriteSheet.getBitmap(), mSpriteSheet.getFrame(mCurrentFrame), dest.toPoint());
		}
	}
	
	public function setProperties(props : Dynamic) {
		
	}
	
	override function update(delta:Float) 
	{
		delta *= mTimeMutiplier;
		super.update(delta);
		if(!mStatic){
			vel.x += mLevel.getGravity().x * delta;
			vel.y += mLevel.getGravity().y * delta;
			
			if (vel.y * delta > mLevel.getTileHeight()-1)
				vel.y = (mLevel.getTileHeight()-1) / delta;
			
			if(mOnFloor)
				vel.x *= mFloorFriction;
			else{
				vel.x *= mAirFriction;
				mAirTime += delta;
			}
			
			mOnFloor = false;
			mBlockedLeft = false;
			mBlockedRight = false;
		}else {
			vel.x = 0;
			vel.y = 0;
		}
				
		mNextPos.x = pos.x + vel.x * delta;
		mNextPos.y = pos.y + vel.y * delta;		
		
		move(delta);
		
		if (mAnimation != null)
			mCurrentFrame = mAnimation.getNextFrame(delta);
		else
			mCurrentFrame = 0;
			
		if(mTimeMutiplier < 1){
			mSlowDownTimeCounter += delta / mTimeMutiplier;
			if (mSlowDownTimeCounter >= 5)
				mTimeMutiplier = 1;
		}
		
		if (mTopCollision != null) 
			onCollideOtherFromTop(mTopCollision);
		
		if (mLeftCollision != null) 
			onCollideOtherFromLeft(mLeftCollision);
		
		if (mRightCollision != null) 
			onCollideOtherFromRight(mRightCollision);

		if (mDownCollition != null) 
			onCollideOtherFromBottom(mDownCollition);
			
		mDownCollition = null;
		mTopCollision = null;
		mLeftCollision = null;
		mRightCollision = null;
	}
	
	function getOutOfWall() {
		var testX = pos.x + mDim.x / 2;
		var testY = pos.y;
		
		var info = mLevel.getTileInfoAt(testX, testY);
		if (info != null && info.block) {
			pos.y = Std.int(pos.y / mLevel.getTileHeight()+1) * mLevel.getTileHeight();
		}
			
		testX = pos.x + mDim.x;
		testY = pos.y + mDim.y / 2;
		
		info = mLevel.getTileInfoAt(testX, testY);
		if (info != null && info.block) {
			pos.x = Std.int(pos.x / mLevel.getTileWidth() +1) * mLevel.getTileWidth() - mDim.x;
		}
			
		testX = pos.x + mDim.x / 2;
		testY = pos.y + mDim.y;
		
		info = mLevel.getTileInfoAt(testX, testY);
		if (info != null && info.block) {
			pos.y = Std.int(pos.y / mLevel.getTileHeight() +1) * mLevel.getTileHeight() - mDim.y;
		}
			
		var testX = pos.x;
		testY = pos.y + mDim.y / 2;
		
		var info = mLevel.getTileInfoAt(testX, testY);
		if (info != null && info.block) {
			pos.x = Std.int(pos.x / mLevel.getTileWidth()+1) * mLevel.getTileWidth();
		}
	}
	
	function resolveCollisionWithOthers(delta : Float) 
	{
		for (actor in AllActors) {
			if (actor != this) {
				if (mNextPos.x < actor.pos.x + actor.getDim().x &&
					mNextPos.x + mDim.x > actor.pos.x &&
					mNextPos.y < actor.pos.y + actor.getDim().y &&
					mNextPos.y + mDim.y > actor.pos.y) {
						onCollideOther(actor, delta);
					}
			}
		}
	}
	
	public function onCollideOther(actor : Actor, delta : Float) {
		
		if (actor.pos.y >= pos.y + mDim.y ) {
			if(actor.isSolid() && mSolid){
				mOnFloor = true;
				vel.y = 0 + actor.vel.y;
				mNextPos.x = pos.x + (vel.x + actor.vel.x) * delta * mFloorFriction;
				mNextPos.y = actor.pos.y - mDim.y + vel.y * delta;
				if (mAirTime > mMinAirTimeToLand)
					onLand();
				mAirTime = 0;
				if (Std.is(actor, Hero)){
					mNextPos.x = actor.pos.x + (actor.getDim().x - mDim.x) / 2;
				}
			}
			if(mSolid) actor.setTopCollisionWith(this);
		}
		else if (actor.pos.y + actor.getDim().y <= pos.y ) {
			if (actor.isSolid() && mSolid) {
				onHeadHit();
				vel.y = 0;
				mNextPos.y = actor.pos.y + actor.getDim().y;
				if (Std.is(actor, Hero))
					mNextPos.x = actor.pos.x + (actor.getDim().x - mDim.x) / 2;
			}
			if(mSolid) actor.setDownCollisionWith(this);
		}
		
		if (actor.pos.x >= pos.x + mDim.x ) {
			if(actor.isSolid() && mSolid){
				if (actor.isStatic()) {
					vel.x = 0;
					mNextPos.x = actor.pos.x - mDim.x;
				}else {
					var acNextPosX = mNextPos.x + mDim.x;
					actor.getNextPos().x = acNextPosX;
					actor.move(delta);
					vel.x *= 0.7;
					mNextPos.x = actor.pos.x - mDim.x;
				}
			}
			if(mSolid) actor.setLeftCollisionWith(this);
		}
		else if (actor.pos.x + actor.getDim().x <= pos.x ) {
			if(actor.isSolid() && mSolid){
				if (actor.isStatic()) {
					vel.x = 0;
					mNextPos.x = actor.pos.x + actor.getDim().x;
				}else {
					var acNextPosX = mNextPos.x - actor.getDim().x;
					actor.getNextPos().x = acNextPosX;
					actor.move(delta);
					vel.x *= 0.7;
					mNextPos.x = actor.pos.x + actor.getDim().x;
				}
			}
			if(mSolid) actor.setRightCollisionWith(this);
		}
		
		
	}
	
	public function setTopCollisionWith(actor : Actor) {
		mTopCollision = actor;
	}
	
	public function setRightCollisionWith(actor : Actor) {
		mRightCollision = actor;
	}
	
	public function setLeftCollisionWith(actor : Actor) {
		mLeftCollision = actor;
	}
	
	public function setDownCollisionWith(actor : Actor) {
		mDownCollition = actor;
	}
	
	function onCollideOtherFromRight(actor:Actor) 
	{
		onCollideOtherFromAnyWhere(actor);
	}
	
	function onCollideOtherFromLeft(actor:Actor) 
	{
		onCollideOtherFromAnyWhere(actor);
	}
	
	function onCollideOtherFromBottom(actor:Actor) 
	{
		onCollideOtherFromAnyWhere(actor);
	}
	
	function onCollideOtherFromTop(actor:Actor) 
	{
		onCollideOtherFromAnyWhere(actor);
	}
	
	function onCollideOtherFromAnyWhere(actor:Actor) 
	{
	}
	
	function onLand() {
		
	}
	
	public function setAnimation(animation : Animation) {
		if(mAnimation != animation){
			mAnimation = animation;
			animation.reset();
		}
	}
	
	public function isStatic() : Bool {
		return mStatic;
	}
	
	public function isSolid() : Bool {
		return mSolid;
	}
	
	function resolveCollisionWithMap():Void 
	{
		resolveYCollision();
		resolveXCollision();	
	}
	
	override public function destroy() 
	{
		super.destroy();
		AllActors.remove(this);
	}
	
	public function onLaserHit(laser : Laser, delta : Float) {
		if (laser.getLastColor() == 0xff0000 && !mStatic) {
			vel.add(Vec2.Mul(laser.getDir(), 0.2 * delta));
		}else if (laser.getLastColor() == 0x0000ff) {
			slowDown(0.2,delta);
		}else if (laser.getLastColor() == 0x00ff00) {
			vel.add(Vec2.Mul(laser.getDir(), - 0.2 * delta));
		}
		move(delta);
	}
	
	function slowDown(coef : Float, time : Float) {
		mSlowDownTimeCounter = 0;
		mTimeMutiplier = coef;
	}
	
	function resolveYCollision():Void 
	{
		if (vel.y > 0) {
			var tileInfoBL = mLevel.getTileInfoAt(pos.x, mNextPos.y + mDim.y );
			var tileInfoBR = mLevel.getTileInfoAt(pos.x + mDim.x - 1, mNextPos.y + mDim.y);
			
			var tileAtBottomLeft  = tileInfoBL != null ? tileInfoBL.block : false;
			var tileAtBottomRight  = tileInfoBR != null ? tileInfoBR.block : false;
			
			var mNextTileCoord = mLevel.getTileCoordinate(mNextPos.x, mNextPos.y + mDim.y);
			if (tileAtBottomLeft || tileAtBottomRight) {
				mNextPos.y = (mNextTileCoord.y) * mLevel.getTileHeight() - mDim.y;
				vel.y = 0;
				mOnFloor = true;
				if (mAirTime > mMinAirTimeToLand)
					onLand();
				mAirTime = 0;
			}
			
			if ((tileInfoBL != null && tileInfoBL.hurt) ||
			    (tileInfoBR != null && tileInfoBR.hurt)) {
					onHurt();
				}
		}else if (vel.y < 0) {
			var tileInfoTL = mLevel.getTileInfoAt(pos.x, mNextPos.y);
			var tileInfoTR = mLevel.getTileInfoAt(pos.x + mDim.x - 1, mNextPos.y);
			
			var tileAtTopLeft = tileInfoTL != null ? tileInfoTL.block : false;
			var tileAtTopRight = tileInfoTR != null ? tileInfoTR.block : false;
			
			var mNextTileCoord = mLevel.getTileCoordinate(mNextPos.x, mNextPos.y);
			if (tileAtTopLeft || tileAtTopRight) {
				mNextPos.y = (mNextTileCoord.y+1) * mLevel.getTileHeight();
				vel.y = 0;
				onHeadHit();
			}
			
			if ((tileInfoTL != null && tileInfoTL.hurt) ||
			    (tileInfoTR != null && tileInfoTR.hurt)) {
					onHurt();
				}
		}
	}
	
	function onHeadHit() 
	{
		
	}
	
	function onHurt() 
	{
		
	}
	
	function resolveXCollision():Void 
	{
		if (vel.x > 0) {
			var tileInfoTR = mLevel.getTileInfoAt(mNextPos.x + mDim.x, pos.y);
			var tileInfoBR = mLevel.getTileInfoAt(mNextPos.x + mDim.x, pos.y + mDim.y - 1);
			
			var tileAtTopRight = tileInfoTR != null ? tileInfoTR.block : false;
			var tileAtBottomRight = tileInfoBR != null ? tileInfoBR.block : false;
			
			var mNextTileCoord = mLevel.getTileCoordinate(mNextPos.x + mDim.x, mNextPos.y);
			if (tileAtTopRight || tileAtBottomRight) {
				mNextPos.x = (mNextTileCoord.x) * mLevel.getTileWidth() - mDim.x;
				vel.x = 0;
				mBlockedRight = true;
			}
			
			if ((tileInfoTR != null && tileInfoTR.hurt) ||
			    (tileInfoBR != null && tileInfoBR.hurt)) {
					onHurt();
				}
		}else if (vel.x < 0) {
			var tileInfoTL = mLevel.getTileInfoAt(mNextPos.x, mNextPos.y);
			var tileInfoBL = mLevel.getTileInfoAt(mNextPos.x, mNextPos.y + mDim.y - 1);
			
			var tileAtTopLeft = tileInfoTL != null ? tileInfoTL.block : false;
			var tileAtBottomLeft = tileInfoBL != null ? tileInfoBL.block : false;
			
			var mNextTileCoord = mLevel.getTileCoordinate(mNextPos.x, mNextPos.y);
			if (tileAtTopLeft || tileAtBottomLeft ) {
				mNextPos.x = (mNextTileCoord.x+1) * mLevel.getTileWidth();
				vel.x = 0;
				mBlockedLeft = true;
			}
			
			if ((tileInfoTL != null && tileInfoTL.hurt) ||
			    (tileInfoBL != null && tileInfoBL.hurt)) {
					onHurt();
				}
		}
	}
	
	public function die() {
		if (!mDead){
			mDead = true;
			onDie();
		}
	}
	
	function onDie() 
	{
		
	}
	
	public function isBlockedRight() : Bool {
		return mBlockedRight;
	}
	
	public function isBlockedLeft() : Bool {
		return mBlockedLeft;
	}
	
	public function getNextPos() : Vec2 {
		return mNextPos;
	}
	
	public function move(delta : Float):Void 
	{
		if (!mStatic) {
			resolveCollisionWithMap();
			resolveCollisionWithOthers(delta);
			pos.copy(mNextPos);
		}
		
		if(!mStatic && mSolid)
			getOutOfWall();
	}
}