package core;

/**
 * ...
 * @author Thomas BAUDON
 */
class Utils
{

	public static inline function fastAbs(v:Int) : Int {
		return (v ^ (v >> 31)) - (v >> 31);
	}

	public static inline function fastFloor(v:Float) : Int {
		return Std.int(v); // actually it’s more "truncate" than "round to 0"
	}
	
	static public function getLine(x0 : Int, y0 : Int, x1 : Int, y1 : Int) : Array<{x : Int, y : Int}> {

		var result = new Array<{x : Int, y : Int}>();

		var steep : Bool = fastAbs(y1 - y0) > fastAbs(x1 - x0);
		if (steep) {
			var t = x0; x0 = y0; y0 = t;
			var t2 = x1; x1 = y1; y1 = t2;
		}
		if (x0 > x1) {
			var t = x0; x0 = x1; x1 = t;
			var t2 = y0; y0 = y1; y1 = t2;
		}

		var deltax : Int = x1 - x0;
		var deltay : Int = fastAbs(y1 - y0);
		var error : Int = 0;
		var ystep : Int;
		var y : Int = y0;
		if (y0 < y1) ystep = 1; else ystep = -1;
		var x = x0;
		while(x <= x1){
			if (steep) result.push({x :y , y: x});
			else result.push({x :x, y : y});
			error += deltay;
			if (2 * error >= deltax) {
				y += ystep;
				error -= deltax;
			}
			if (error < 0) {
				if(steep)
					result.push( { x : y, y: x } );
				else
					result.push( { x : x , y: y } );
			}
			x++;
		}

		return result;
	}
	
}