package geom;
import openfl.geom.Point;

/**
 * ...
 * @author Thomas BAUDON
 */
class Vec2
{
	
	public var x : Float;
	public var y : Float;
	
	public static var mSPoint : Point;

	public function new(x:Float = 0, y : Float = 0) 
	{
		if (mSPoint == null) mSPoint = new Point();
		this.x = x;
		this.y = y;
	}
	
	public function add(v : Vec2) : Vec2 {
		x += v.x;
		y += v.y;
		return this;
	}
	
	public static function Add(a : Vec2, b : Vec2) : Vec2 {
		return new Vec2(a.x + b.x, a.y + b.y);
	}
	
	public function sub(v : Vec2) : Vec2 {
		x -= v.x;
		y -= v.y;
		return this;
	}
	
	public static function Sub(a : Vec2, b : Vec2) : Vec2 {
		return new Vec2(a.x - b.x, a.y - b.y);
	}
	
	public function mul(f : Float) : Vec2 {
		x *= f;
		y *= f;
		return this;
	}
	
	public static function Mul(a : Vec2, f : Float) : Vec2 {
		return new Vec2(a.x * f, a.y * f);
	}
	
	public function length() : Float {
		return Math.sqrt(x * x + y * y);
	}
	
	public static function Norm(v : Vec2) : Vec2 {
		return new Vec2(v.x / v.length(), v.y / v.length());
		
	}
	
	public function set(x : Float, y : Float) {
		this.x = x;
		this.y = y;
	}
	
	public function copy(v : Vec2) {
		x = v.x;
		y = v.y;
	}
	
	public function clone() : Vec2 {
		return new Vec2(x, y);
	}
	
	public function offset(x : Float, y : Float) {
		this.x += x;
		this.y += y;
	}
	
	public function getNormals() : Array<Vec2> {
		var normA = new Vec2( -y, x);
		var normB = new Vec2( y, -x);
		return [normA, normB];
	}
	
	public function getAngle() : Float {
		return Math.atan2(y, x);
	}
	
	public function toString() : String {
		return "(" + x + ";" + y + ")";
	}

	inline public function toPoint() : Point {
		mSPoint.x = x;
		mSPoint.y = y;
		return mSPoint;
	}
	
	inline public static function interpolate(a : Vec2, b : Vec2, f : Float) : Vec2{
		return new Vec2(a.x + (b.x-a.x)*(1 - f),a.y + (b.y-a.y)*(1 - f));
	}
	
	inline public static function Dist(a : Vec2, b : Vec2) : Float {
		var distX = b.x - a.x;
		var distY = b.y - a.y;
		return Math.sqrt(distX * distX + distY * distY);
	}
}