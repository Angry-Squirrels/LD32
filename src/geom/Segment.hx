package geom;

/**
 * ...
 * @author Thomas BAUDON
 */
class Segment
{
	
	public var a : Vec2;
	public var b : Vec2;

	public function new(ax : Float, ay : Float, bx : Float, by : Float) 
	{
		a = new Vec2(ax, ay);
		b = new Vec2(bx, by);
	}
	
	/**
	 * @param	s other segment
	 * @return intersection point, null is no intersection
	 */
	public function intersect(s : Segment) : Vec2 {
		
		var a = this.a;
		var b = this.b;
		var c = s.a;
		var d = s.b;
		
		var distAB:Float, cos:Float, sin:Float, newX:Float, ABpos:Float;
		
		if ((a.x == b.x && a.y == b.y) || (c.x == d.x && c.y == d.y)) return null;
	 
		if ( a == c || a == d || b == c || b == d ) return null;
		
		b = b.clone();
		c = c.clone();
		d = d.clone();
		
		b.offset( -a.x, -a.y);
		c.offset( -a.x, -a.y);
		d.offset( -a.x, -a.y);
		// a is now considered to be (0,0)
		
		distAB = b.length();
		cos = b.x / distAB;
		sin = b.y / distAB;
		
		c = new Vec2(c.x * cos + c.y * sin, c.y * cos - c.x * sin);
		d = new Vec2(d.x * cos + d.y * sin, d.y * cos - d.x * sin);
		
		if ((c.y < 0 && d.y < 0) || (c.y >= 0 && d.y >= 0)) return null;
	 
		ABpos = d.x + (c.x - d.x) * d.y / (d.y - c.y); // what.
		if (ABpos < 0 || ABpos > distAB) return null;
	 
		return new Vec2(a.x + ABpos * cos, a.y + ABpos * sin);			
	}
	
	public function getNormal(pos : Vec2) : Vec2 {
		return null;
	}
}