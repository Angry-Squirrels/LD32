package core ;

import geom.Vec2;
import haxe.crypto.BaseCode;
import openfl.display.BitmapData;

/**
 * ...
 * @author Thomas BAUDON
 */
class Entity
{
	
	public var pos : Vec2;
	public var vel : Vec2;
	public var scale : Vec2;
	public var rot : Float;
	
	public var parent : Entity;
	public var children : Array<Entity>;
	
	public var collidable : Bool;
	
	public var name : String;
	
	public var visible : Bool;
	
	var mDim : Vec2;
	var mPaused : Bool;

	public function new(name : String = "") {
		this.name = name;
		
		pos = new Vec2();
		scale = new Vec2(1, 1);
		vel = new Vec2(0, 0);
		rot = 0;
		mDim = new Vec2(0, 0);
		visible = true;
		
		children = new Array<Entity>();
	}
	
	public function _update(delta : Float) {
		if (mPaused) return;
		for (child in children)
			child._update(delta);
		
		update(delta);
	}
	
	function update(delta : Float) {
		
	}
	
	public function _draw(buffer : BitmapData, dest : Vec2) {
		if(visible){
			draw(buffer, dest);
			
			for(child in children)
				child._draw(buffer, Vec2.Add(dest, child.pos));
		}
	}
	
	function draw(buffer : BitmapData, dest : Vec2) {
		
	}
	
	public function swap(a : Entity, b : Entity) {
		var temp = a;
		var i = children.indexOf(a);
		var j = children.indexOf(b);
		
		children[i] = children[j];
		children[j] = temp;
	}
	
	public function pause() {
		mPaused = true;
	}
	
	public function play() {
		mPaused = false;
	}
	
	public function add(child : Entity) {
		children.push(child);
		child.onAdded(this);
	}
	
	public function onAdded(p : Entity) {
		parent = p;
	}
	
	public function remove(child : Entity) {
		children.remove(child);
		child.onRemoved(this);
	}
	
	public function onRemoved(p : Entity) {
		parent = null;
	}
	
	public function setDim(x : Int, y : Int) {
		mDim.set(x, y);
	}
	
	public function getDim() : Vec2 {
		return mDim;
	}
	
	public function destroy() {
		if (parent != null)
			parent.remove(this);
	}
	
}