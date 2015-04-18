package core ;
import geom.Vec2;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.Lib;
import core.Level.MapLayerData;
import core.TileSet.TileStamp;

/**
 * ...
 * @author Thomas BAUDON
 */
class TileMapLayer extends Entity
{
	
	var mLevel : Level;
	var mData : Array<Int>;
	
	var mNbCol : Int;
	var mNbLine : Int;
	
	var mTileWidth : Int;
	var mTileHeight : Int;
	
	var mScrollWidth : Int;
	var mScrollHeight : Int;
	
	var mRectStamp : Rectangle;
	var mPointStamp : Point;
	
	public function new(level : Level, tileWidth : Int, tileHeight : Int, layerData : MapLayerData) 
	{
		super();
		
		mRectStamp = new Rectangle();
		mPointStamp = new Point();
		
		mLevel = level;
		mData = layerData.data;
		mNbCol = layerData.width;
		mNbLine = layerData.height;
		
		mTileWidth = tileWidth;
		mTileHeight = tileHeight;
		
		name = layerData.name;
	}
	
	override function draw(buffer : BitmapData, dest : Vec2) 
	{
		super.draw(buffer, dest);
		
		var scrollX : Float = -dest.x;
		var scrollY : Float = -dest.y;
		
		mScrollWidth = Std.int(buffer.width / mTileWidth)+1;
		mScrollHeight = Std.int(buffer.height / mTileHeight)+1;
		
		var startI : Int = Std.int(scrollY / mTileHeight);
		var startJ : Int = Std.int(scrollX / mTileWidth);
		
		if (startI < 0)
			startI = 0;
			
		if (startJ < 0)
			startJ = 0;
		
		var endI : Int;
		var endJ : Int;
		
		if (startI + mScrollHeight < mNbLine)
			endI = startI + mScrollHeight;
		else
			endI = mNbLine;
			
		if (startJ + mScrollWidth < mNbCol)
			endJ = startJ + mScrollWidth;
		else
			endJ = mNbCol;
			
		for (i in startI ... endI) 
			for (j in startJ ... endJ) {
				var tileId = mData[i * mNbCol + j];
				if (tileId == 0) continue;
				
				var stamp : TileStamp = getStamp(tileId);
				if (stamp != null && stamp.bitmap != null) {
					mRectStamp.x = stamp.x;
					mRectStamp.y = stamp.y;
					mRectStamp.width = stamp.w;
					mRectStamp.height = stamp.h;
					
					var destX = j * mTileWidth;
					destX -= Std.int(scrollX);
					var destY = i * mTileHeight;
					destY -= Std.int(scrollY);
					
					mPointStamp.x = Std.int(destX);
					mPointStamp.y = Std.int(destY);
					
					buffer.copyPixels(stamp.bitmap, mRectStamp, mPointStamp,null,null,true);
				}
			}
	}
	
	public function getData() : Array<Int> {
		return mData;
	}
	
	public function getWidth() : Int {
		return mNbCol;
	}
	
	public function getHeight() : Int {
		return mNbLine;
	}
	
	public function getScrollWidth() : Int {
		return mScrollWidth;
	}
	
	public function getScrollHeight() : Int {
		return mScrollHeight;
	}
	
	function getStamp(tile : Int) : TileStamp {
		var tileSet = mLevel.getTileTileset(tile);
		if (tileSet == null) return null;
		
		var stamp = tileSet.getStamp(tile);
		if (stamp != null) return stamp;
		return null;
	}
	
}