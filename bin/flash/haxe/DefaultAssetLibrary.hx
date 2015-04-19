package;


import haxe.Timer;
import haxe.Unserializer;
import lime.app.Preloader;
import lime.audio.AudioSource;
import lime.audio.openal.AL;
import lime.audio.AudioBuffer;
import lime.graphics.Image;
import lime.text.Font;
import lime.utils.ByteArray;
import lime.utils.UInt8Array;
import lime.Assets;

#if sys
import sys.FileSystem;
#end

#if flash
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.media.Sound;
import flash.net.URLLoader;
import flash.net.URLRequest;
#end


class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("img/Hero/franky_cac.png", __ASSET__img_hero_franky_cac_png);
		type.set ("img/Hero/franky_cac.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_cac_flip.png", __ASSET__img_hero_franky_cac_flip_png);
		type.set ("img/Hero/franky_cac_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_catch.png", __ASSET__img_hero_franky_catch_png);
		type.set ("img/Hero/franky_catch.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_catch_flip.png", __ASSET__img_hero_franky_catch_flip_png);
		type.set ("img/Hero/franky_catch_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_iddle.png", __ASSET__img_hero_franky_iddle_png);
		type.set ("img/Hero/franky_iddle.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_iddle_flip.png", __ASSET__img_hero_franky_iddle_flip_png);
		type.set ("img/Hero/franky_iddle_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_kickD.png", __ASSET__img_hero_franky_kickd_png);
		type.set ("img/Hero/franky_kickD.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_kickD_flip.png", __ASSET__img_hero_franky_kickd_flip_png);
		type.set ("img/Hero/franky_kickD_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_kickL.png", __ASSET__img_hero_franky_kickl_png);
		type.set ("img/Hero/franky_kickL.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_kickL_flip.png", __ASSET__img_hero_franky_kickl_flip_png);
		type.set ("img/Hero/franky_kickL_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_run.png", __ASSET__img_hero_franky_run_png);
		type.set ("img/Hero/franky_run.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_run_flip.png", __ASSET__img_hero_franky_run_flip_png);
		type.set ("img/Hero/franky_run_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_slip.png", __ASSET__img_hero_franky_slip_png);
		type.set ("img/Hero/franky_slip.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_slip_flip.png", __ASSET__img_hero_franky_slip_flip_png);
		type.set ("img/Hero/franky_slip_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_strip.png", __ASSET__img_hero_franky_strip_png);
		type.set ("img/Hero/franky_strip.png", AssetType.IMAGE);
		className.set ("img/Hero/franky_strip_flip.png", __ASSET__img_hero_franky_strip_flip_png);
		type.set ("img/Hero/franky_strip_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/pants_cac.png", __ASSET__img_hero_pants_cac_png);
		type.set ("img/Hero/pants_cac.png", AssetType.IMAGE);
		className.set ("img/Hero/pants_cac_flip.png", __ASSET__img_hero_pants_cac_flip_png);
		type.set ("img/Hero/pants_cac_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/pants_iddle.png", __ASSET__img_hero_pants_iddle_png);
		type.set ("img/Hero/pants_iddle.png", AssetType.IMAGE);
		className.set ("img/Hero/pants_iddle_flip.png", __ASSET__img_hero_pants_iddle_flip_png);
		type.set ("img/Hero/pants_iddle_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/pants_kickD.png", __ASSET__img_hero_pants_kickd_png);
		type.set ("img/Hero/pants_kickD.png", AssetType.IMAGE);
		className.set ("img/Hero/pants_kickD_flip.png", __ASSET__img_hero_pants_kickd_flip_png);
		type.set ("img/Hero/pants_kickD_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/pants_kickL.png", __ASSET__img_hero_pants_kickl_png);
		type.set ("img/Hero/pants_kickL.png", AssetType.IMAGE);
		className.set ("img/Hero/pants_kickL_flip.png", __ASSET__img_hero_pants_kickl_flip_png);
		type.set ("img/Hero/pants_kickL_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/pants_run.png", __ASSET__img_hero_pants_run_png);
		type.set ("img/Hero/pants_run.png", AssetType.IMAGE);
		className.set ("img/Hero/pants_run_flip.png", __ASSET__img_hero_pants_run_flip_png);
		type.set ("img/Hero/pants_run_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/pants_strip.png", __ASSET__img_hero_pants_strip_png);
		type.set ("img/Hero/pants_strip.png", AssetType.IMAGE);
		className.set ("img/Hero/pants_strip_flip.png", __ASSET__img_hero_pants_strip_flip_png);
		type.set ("img/Hero/pants_strip_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/pull_cac.png", __ASSET__img_hero_pull_cac_png);
		type.set ("img/Hero/pull_cac.png", AssetType.IMAGE);
		className.set ("img/Hero/pull_cac_flip.png", __ASSET__img_hero_pull_cac_flip_png);
		type.set ("img/Hero/pull_cac_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/pull_iddle.png", __ASSET__img_hero_pull_iddle_png);
		type.set ("img/Hero/pull_iddle.png", AssetType.IMAGE);
		className.set ("img/Hero/pull_iddle_flip.png", __ASSET__img_hero_pull_iddle_flip_png);
		type.set ("img/Hero/pull_iddle_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/pull_kickL.png", __ASSET__img_hero_pull_kickl_png);
		type.set ("img/Hero/pull_kickL.png", AssetType.IMAGE);
		className.set ("img/Hero/pull_kickL_flip.png", __ASSET__img_hero_pull_kickl_flip_png);
		type.set ("img/Hero/pull_kickL_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/pull_kickR.png", __ASSET__img_hero_pull_kickr_png);
		type.set ("img/Hero/pull_kickR.png", AssetType.IMAGE);
		className.set ("img/Hero/pull_kickR_flip.png", __ASSET__img_hero_pull_kickr_flip_png);
		type.set ("img/Hero/pull_kickR_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/pull_run.png", __ASSET__img_hero_pull_run_png);
		type.set ("img/Hero/pull_run.png", AssetType.IMAGE);
		className.set ("img/Hero/pull_run_flip.png", __ASSET__img_hero_pull_run_flip_png);
		type.set ("img/Hero/pull_run_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/pull_strip.png", __ASSET__img_hero_pull_strip_png);
		type.set ("img/Hero/pull_strip.png", AssetType.IMAGE);
		className.set ("img/Hero/pull_strip_flip.png", __ASSET__img_hero_pull_strip_flip_png);
		type.set ("img/Hero/pull_strip_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeL_cac.png", __ASSET__img_hero_shoel_cac_png);
		type.set ("img/Hero/shoeL_cac.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeL_cac_flip.png", __ASSET__img_hero_shoel_cac_flip_png);
		type.set ("img/Hero/shoeL_cac_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeL_iddle.png", __ASSET__img_hero_shoel_iddle_png);
		type.set ("img/Hero/shoeL_iddle.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeL_iddle_flip.png", __ASSET__img_hero_shoel_iddle_flip_png);
		type.set ("img/Hero/shoeL_iddle_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeL_kickL.png", __ASSET__img_hero_shoel_kickl_png);
		type.set ("img/Hero/shoeL_kickL.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeL_kickL_flip.png", __ASSET__img_hero_shoel_kickl_flip_png);
		type.set ("img/Hero/shoeL_kickL_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeL_kickR.png", __ASSET__img_hero_shoel_kickr_png);
		type.set ("img/Hero/shoeL_kickR.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeL_kickR_flip.png", __ASSET__img_hero_shoel_kickr_flip_png);
		type.set ("img/Hero/shoeL_kickR_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeL_run.png", __ASSET__img_hero_shoel_run_png);
		type.set ("img/Hero/shoeL_run.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeL_run_flip.png", __ASSET__img_hero_shoel_run_flip_png);
		type.set ("img/Hero/shoeL_run_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeL_strip.png", __ASSET__img_hero_shoel_strip_png);
		type.set ("img/Hero/shoeL_strip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeL_strip_flip.png", __ASSET__img_hero_shoel_strip_flip_png);
		type.set ("img/Hero/shoeL_strip_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeR_cac.png", __ASSET__img_hero_shoer_cac_png);
		type.set ("img/Hero/shoeR_cac.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeR_cac_flip.png", __ASSET__img_hero_shoer_cac_flip_png);
		type.set ("img/Hero/shoeR_cac_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeR_iddle.png", __ASSET__img_hero_shoer_iddle_png);
		type.set ("img/Hero/shoeR_iddle.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeR_iddle_flip.png", __ASSET__img_hero_shoer_iddle_flip_png);
		type.set ("img/Hero/shoeR_iddle_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeR_kickL.png", __ASSET__img_hero_shoer_kickl_png);
		type.set ("img/Hero/shoeR_kickL.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeR_kickL_flip.png", __ASSET__img_hero_shoer_kickl_flip_png);
		type.set ("img/Hero/shoeR_kickL_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeR_kickR.png", __ASSET__img_hero_shoer_kickr_png);
		type.set ("img/Hero/shoeR_kickR.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeR_kickR_flip.png", __ASSET__img_hero_shoer_kickr_flip_png);
		type.set ("img/Hero/shoeR_kickR_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeR_run.png", __ASSET__img_hero_shoer_run_png);
		type.set ("img/Hero/shoeR_run.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeR_run_flip.png", __ASSET__img_hero_shoer_run_flip_png);
		type.set ("img/Hero/shoeR_run_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeR_strip.png", __ASSET__img_hero_shoer_strip_png);
		type.set ("img/Hero/shoeR_strip.png", AssetType.IMAGE);
		className.set ("img/Hero/shoeR_strip_flip.png", __ASSET__img_hero_shoer_strip_flip_png);
		type.set ("img/Hero/shoeR_strip_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/slip_iddle.png", __ASSET__img_hero_slip_iddle_png);
		type.set ("img/Hero/slip_iddle.png", AssetType.IMAGE);
		className.set ("img/Hero/slip_iddle_flip.png", __ASSET__img_hero_slip_iddle_flip_png);
		type.set ("img/Hero/slip_iddle_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/slip_kickD.png", __ASSET__img_hero_slip_kickd_png);
		type.set ("img/Hero/slip_kickD.png", AssetType.IMAGE);
		className.set ("img/Hero/slip_kickD_flip.png", __ASSET__img_hero_slip_kickd_flip_png);
		type.set ("img/Hero/slip_kickD_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/slip_kickL.png", __ASSET__img_hero_slip_kickl_png);
		type.set ("img/Hero/slip_kickL.png", AssetType.IMAGE);
		className.set ("img/Hero/slip_kickL_flip.png", __ASSET__img_hero_slip_kickl_flip_png);
		type.set ("img/Hero/slip_kickL_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/slip_run.png", __ASSET__img_hero_slip_run_png);
		type.set ("img/Hero/slip_run.png", AssetType.IMAGE);
		className.set ("img/Hero/slip_run_flip.png", __ASSET__img_hero_slip_run_flip_png);
		type.set ("img/Hero/slip_run_flip.png", AssetType.IMAGE);
		className.set ("img/Hero/slip_strip.png", __ASSET__img_hero_slip_strip_png);
		type.set ("img/Hero/slip_strip.png", AssetType.IMAGE);
		className.set ("img/Hero/slip_strip_flip.png", __ASSET__img_hero_slip_strip_flip_png);
		type.set ("img/Hero/slip_strip_flip.png", AssetType.IMAGE);
		className.set ("img/hud/GO.png", __ASSET__img_hud_go_png);
		type.set ("img/hud/GO.png", AssetType.IMAGE);
		
		
		#elseif html5
		
		var id;
		id = "img/Hero/franky_cac.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_cac_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_catch.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_catch_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_iddle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_iddle_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_kickD.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_kickD_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_kickL.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_kickL_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_run.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_run_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_slip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_slip_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_strip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/franky_strip_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pants_cac.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pants_cac_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pants_iddle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pants_iddle_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pants_kickD.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pants_kickD_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pants_kickL.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pants_kickL_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pants_run.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pants_run_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pants_strip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pants_strip_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pull_cac.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pull_cac_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pull_iddle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pull_iddle_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pull_kickL.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pull_kickL_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pull_kickR.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pull_kickR_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pull_run.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pull_run_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pull_strip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/pull_strip_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeL_cac.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeL_cac_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeL_iddle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeL_iddle_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeL_kickL.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeL_kickL_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeL_kickR.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeL_kickR_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeL_run.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeL_run_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeL_strip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeL_strip_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeR_cac.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeR_cac_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeR_iddle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeR_iddle_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeR_kickL.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeR_kickL_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeR_kickR.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeR_kickR_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeR_run.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeR_run_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeR_strip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/shoeR_strip_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/slip_iddle.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/slip_iddle_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/slip_kickD.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/slip_kickD_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/slip_kickL.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/slip_kickL_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/slip_run.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/slip_run_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/slip_strip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/Hero/slip_strip_flip.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		id = "img/hud/GO.png";
		path.set (id, id);
		
		type.set (id, AssetType.IMAGE);
		
		
		var assetsPrefix = ApplicationMain.config.assetsPrefix;
		if (assetsPrefix != null) {
			for (k in path.keys()) {
				path.set(k, assetsPrefix + path[k]);
			}
		}
		
		#else
		
		#if openfl
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		#end
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("img/Hero/franky_cac.png", __ASSET__img_hero_franky_cac_png);
		type.set ("img/Hero/franky_cac.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_cac_flip.png", __ASSET__img_hero_franky_cac_flip_png);
		type.set ("img/Hero/franky_cac_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_catch.png", __ASSET__img_hero_franky_catch_png);
		type.set ("img/Hero/franky_catch.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_catch_flip.png", __ASSET__img_hero_franky_catch_flip_png);
		type.set ("img/Hero/franky_catch_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_iddle.png", __ASSET__img_hero_franky_iddle_png);
		type.set ("img/Hero/franky_iddle.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_iddle_flip.png", __ASSET__img_hero_franky_iddle_flip_png);
		type.set ("img/Hero/franky_iddle_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_kickD.png", __ASSET__img_hero_franky_kickd_png);
		type.set ("img/Hero/franky_kickD.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_kickD_flip.png", __ASSET__img_hero_franky_kickd_flip_png);
		type.set ("img/Hero/franky_kickD_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_kickL.png", __ASSET__img_hero_franky_kickl_png);
		type.set ("img/Hero/franky_kickL.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_kickL_flip.png", __ASSET__img_hero_franky_kickl_flip_png);
		type.set ("img/Hero/franky_kickL_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_run.png", __ASSET__img_hero_franky_run_png);
		type.set ("img/Hero/franky_run.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_run_flip.png", __ASSET__img_hero_franky_run_flip_png);
		type.set ("img/Hero/franky_run_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_slip.png", __ASSET__img_hero_franky_slip_png);
		type.set ("img/Hero/franky_slip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_slip_flip.png", __ASSET__img_hero_franky_slip_flip_png);
		type.set ("img/Hero/franky_slip_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_strip.png", __ASSET__img_hero_franky_strip_png);
		type.set ("img/Hero/franky_strip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/franky_strip_flip.png", __ASSET__img_hero_franky_strip_flip_png);
		type.set ("img/Hero/franky_strip_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pants_cac.png", __ASSET__img_hero_pants_cac_png);
		type.set ("img/Hero/pants_cac.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pants_cac_flip.png", __ASSET__img_hero_pants_cac_flip_png);
		type.set ("img/Hero/pants_cac_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pants_iddle.png", __ASSET__img_hero_pants_iddle_png);
		type.set ("img/Hero/pants_iddle.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pants_iddle_flip.png", __ASSET__img_hero_pants_iddle_flip_png);
		type.set ("img/Hero/pants_iddle_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pants_kickD.png", __ASSET__img_hero_pants_kickd_png);
		type.set ("img/Hero/pants_kickD.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pants_kickD_flip.png", __ASSET__img_hero_pants_kickd_flip_png);
		type.set ("img/Hero/pants_kickD_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pants_kickL.png", __ASSET__img_hero_pants_kickl_png);
		type.set ("img/Hero/pants_kickL.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pants_kickL_flip.png", __ASSET__img_hero_pants_kickl_flip_png);
		type.set ("img/Hero/pants_kickL_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pants_run.png", __ASSET__img_hero_pants_run_png);
		type.set ("img/Hero/pants_run.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pants_run_flip.png", __ASSET__img_hero_pants_run_flip_png);
		type.set ("img/Hero/pants_run_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pants_strip.png", __ASSET__img_hero_pants_strip_png);
		type.set ("img/Hero/pants_strip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pants_strip_flip.png", __ASSET__img_hero_pants_strip_flip_png);
		type.set ("img/Hero/pants_strip_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pull_cac.png", __ASSET__img_hero_pull_cac_png);
		type.set ("img/Hero/pull_cac.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pull_cac_flip.png", __ASSET__img_hero_pull_cac_flip_png);
		type.set ("img/Hero/pull_cac_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pull_iddle.png", __ASSET__img_hero_pull_iddle_png);
		type.set ("img/Hero/pull_iddle.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pull_iddle_flip.png", __ASSET__img_hero_pull_iddle_flip_png);
		type.set ("img/Hero/pull_iddle_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pull_kickL.png", __ASSET__img_hero_pull_kickl_png);
		type.set ("img/Hero/pull_kickL.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pull_kickL_flip.png", __ASSET__img_hero_pull_kickl_flip_png);
		type.set ("img/Hero/pull_kickL_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pull_kickR.png", __ASSET__img_hero_pull_kickr_png);
		type.set ("img/Hero/pull_kickR.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pull_kickR_flip.png", __ASSET__img_hero_pull_kickr_flip_png);
		type.set ("img/Hero/pull_kickR_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pull_run.png", __ASSET__img_hero_pull_run_png);
		type.set ("img/Hero/pull_run.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pull_run_flip.png", __ASSET__img_hero_pull_run_flip_png);
		type.set ("img/Hero/pull_run_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pull_strip.png", __ASSET__img_hero_pull_strip_png);
		type.set ("img/Hero/pull_strip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/pull_strip_flip.png", __ASSET__img_hero_pull_strip_flip_png);
		type.set ("img/Hero/pull_strip_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeL_cac.png", __ASSET__img_hero_shoel_cac_png);
		type.set ("img/Hero/shoeL_cac.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeL_cac_flip.png", __ASSET__img_hero_shoel_cac_flip_png);
		type.set ("img/Hero/shoeL_cac_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeL_iddle.png", __ASSET__img_hero_shoel_iddle_png);
		type.set ("img/Hero/shoeL_iddle.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeL_iddle_flip.png", __ASSET__img_hero_shoel_iddle_flip_png);
		type.set ("img/Hero/shoeL_iddle_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeL_kickL.png", __ASSET__img_hero_shoel_kickl_png);
		type.set ("img/Hero/shoeL_kickL.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeL_kickL_flip.png", __ASSET__img_hero_shoel_kickl_flip_png);
		type.set ("img/Hero/shoeL_kickL_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeL_kickR.png", __ASSET__img_hero_shoel_kickr_png);
		type.set ("img/Hero/shoeL_kickR.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeL_kickR_flip.png", __ASSET__img_hero_shoel_kickr_flip_png);
		type.set ("img/Hero/shoeL_kickR_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeL_run.png", __ASSET__img_hero_shoel_run_png);
		type.set ("img/Hero/shoeL_run.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeL_run_flip.png", __ASSET__img_hero_shoel_run_flip_png);
		type.set ("img/Hero/shoeL_run_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeL_strip.png", __ASSET__img_hero_shoel_strip_png);
		type.set ("img/Hero/shoeL_strip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeL_strip_flip.png", __ASSET__img_hero_shoel_strip_flip_png);
		type.set ("img/Hero/shoeL_strip_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeR_cac.png", __ASSET__img_hero_shoer_cac_png);
		type.set ("img/Hero/shoeR_cac.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeR_cac_flip.png", __ASSET__img_hero_shoer_cac_flip_png);
		type.set ("img/Hero/shoeR_cac_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeR_iddle.png", __ASSET__img_hero_shoer_iddle_png);
		type.set ("img/Hero/shoeR_iddle.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeR_iddle_flip.png", __ASSET__img_hero_shoer_iddle_flip_png);
		type.set ("img/Hero/shoeR_iddle_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeR_kickL.png", __ASSET__img_hero_shoer_kickl_png);
		type.set ("img/Hero/shoeR_kickL.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeR_kickL_flip.png", __ASSET__img_hero_shoer_kickl_flip_png);
		type.set ("img/Hero/shoeR_kickL_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeR_kickR.png", __ASSET__img_hero_shoer_kickr_png);
		type.set ("img/Hero/shoeR_kickR.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeR_kickR_flip.png", __ASSET__img_hero_shoer_kickr_flip_png);
		type.set ("img/Hero/shoeR_kickR_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeR_run.png", __ASSET__img_hero_shoer_run_png);
		type.set ("img/Hero/shoeR_run.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeR_run_flip.png", __ASSET__img_hero_shoer_run_flip_png);
		type.set ("img/Hero/shoeR_run_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeR_strip.png", __ASSET__img_hero_shoer_strip_png);
		type.set ("img/Hero/shoeR_strip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/shoeR_strip_flip.png", __ASSET__img_hero_shoer_strip_flip_png);
		type.set ("img/Hero/shoeR_strip_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/slip_iddle.png", __ASSET__img_hero_slip_iddle_png);
		type.set ("img/Hero/slip_iddle.png", AssetType.IMAGE);
		
		className.set ("img/Hero/slip_iddle_flip.png", __ASSET__img_hero_slip_iddle_flip_png);
		type.set ("img/Hero/slip_iddle_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/slip_kickD.png", __ASSET__img_hero_slip_kickd_png);
		type.set ("img/Hero/slip_kickD.png", AssetType.IMAGE);
		
		className.set ("img/Hero/slip_kickD_flip.png", __ASSET__img_hero_slip_kickd_flip_png);
		type.set ("img/Hero/slip_kickD_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/slip_kickL.png", __ASSET__img_hero_slip_kickl_png);
		type.set ("img/Hero/slip_kickL.png", AssetType.IMAGE);
		
		className.set ("img/Hero/slip_kickL_flip.png", __ASSET__img_hero_slip_kickl_flip_png);
		type.set ("img/Hero/slip_kickL_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/slip_run.png", __ASSET__img_hero_slip_run_png);
		type.set ("img/Hero/slip_run.png", AssetType.IMAGE);
		
		className.set ("img/Hero/slip_run_flip.png", __ASSET__img_hero_slip_run_flip_png);
		type.set ("img/Hero/slip_run_flip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/slip_strip.png", __ASSET__img_hero_slip_strip_png);
		type.set ("img/Hero/slip_strip.png", AssetType.IMAGE);
		
		className.set ("img/Hero/slip_strip_flip.png", __ASSET__img_hero_slip_strip_flip_png);
		type.set ("img/Hero/slip_strip_flip.png", AssetType.IMAGE);
		
		className.set ("img/hud/GO.png", __ASSET__img_hud_go_png);
		type.set ("img/hud/GO.png", AssetType.IMAGE);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var assetType = this.type.get (id);
		
		if (assetType != null) {
			
			if (assetType == requestedType || ((requestedType == SOUND || requestedType == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if (requestedType == BINARY && (assetType == BINARY || assetType == TEXT || assetType == IMAGE)) {
				
				return true;
				
			} else if (requestedType == null || path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (requestedType == BINARY || requestedType == null || (assetType == BINARY && requestedType == TEXT)) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getAudioBuffer (id:String):AudioBuffer {
		
		#if flash
		
		var buffer = new AudioBuffer ();
		buffer.src = cast (Type.createInstance (className.get (id), []), Sound);
		return buffer;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return AudioBuffer.fromBytes (cast (Type.createInstance (className.get (id), []), ByteArray));
		else return AudioBuffer.fromFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if flash
		
		switch (type.get (id)) {
			
			case TEXT, BINARY:
				
				return cast (Type.createInstance (className.get (id), []), ByteArray);
			
			case IMAGE:
				
				var bitmapData = cast (Type.createInstance (className.get (id), []), BitmapData);
				return bitmapData.getPixels (bitmapData.rect);
			
			default:
				
				return null;
			
		}
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);
		
		#elseif html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if flash
		
		var src = Type.createInstance (className.get (id), []);
		
		var font = new Font (src.fontName);
		font.src = src;
		return font;
		
		#elseif html5
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Font);
			
		} else {
			
			return Font.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	public override function getImage (id:String):Image {
		
		#if flash
		
		return Image.fromBitmapData (cast (Type.createInstance (className.get (id), []), BitmapData));
		
		#elseif html5
		
		return Image.fromImageElement (Preloader.images.get (path.get (id)));
		
		#else
		
		if (className.exists (id)) {
			
			var fontClass = className.get (id);
			return cast (Type.createInstance (fontClass, []), Image);
			
		} else {
			
			return Image.fromFile (path.get (id));
			
		}
		
		#end
		
	}
	
	
	/*public override function getMusic (id:String):Dynamic {
		
		#if flash
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		//var sound = new Sound ();
		//sound.__buffer = true;
		//sound.load (new URLRequest (path.get (id)));
		//return sound;
		return null;
		
		#elseif html5
		
		return null;
		//return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		return null;
		//if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		//else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}*/
	
	
	public override function getPath (id:String):String {
		
		//#if ios
		
		//return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		//#else
		
		return path.get (id);
		
		//#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if html5
		
		var bytes:ByteArray = null;
		var data = Preloader.loaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:String):Bool {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		
		#if flash
		
		//if (requestedType != AssetType.MUSIC && requestedType != AssetType.SOUND) {
			
			return className.exists (id);
			
		//}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:String):Array<String> {
		
		var requestedType = type != null ? cast (type, AssetType) : null;
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (requestedType == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadAudioBuffer (id:String, handler:AudioBuffer -> Void):Void {
		
		#if (flash)
		if (path.exists (id)) {
			
			var soundLoader = new Sound ();
			soundLoader.addEventListener (Event.COMPLETE, function (event) {
				
				var audioBuffer:AudioBuffer = new AudioBuffer();
				audioBuffer.src = event.currentTarget;
				handler (audioBuffer);
				
			});
			soundLoader.load (new URLRequest (path.get (id)));
			
		} else {
			handler (getAudioBuffer (id));
			
		}
		#else
		handler (getAudioBuffer (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadImage (id:String, handler:Image -> Void):Void {
		
		#if flash
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bitmapData = cast (event.currentTarget.content, Bitmap).bitmapData;
				handler (Image.fromBitmapData (bitmapData));
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getImage (id));
			
		}
		
		#else
		
		handler (getImage (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#elseif (mac && java)
			var bytes = ByteArray.readFile ("../Resources/manifest");
			#elseif ios
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								#if ios
								path.set (asset.id, "assets/" + asset.path);
								#else
								path.set (asset.id, asset.path);
								#end
								type.set (asset.id, cast (asset.type, AssetType));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	/*public override function loadMusic (id:String, handler:Dynamic -> Void):Void {
		
		#if (flash || html5)
		
		//if (path.exists (id)) {
			
		//	var loader = new Loader ();
		//	loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
		//		handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
		//	});
		//	loader.load (new URLRequest (path.get (id)));
			
		//} else {
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}*/
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		//#if html5
		
		/*if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}*/
		
		//#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		//#end
		
	}
	
	
}


#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__img_hero_franky_cac_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_cac_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_catch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_catch_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_iddle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_iddle_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_kickd_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_kickd_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_kickl_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_kickl_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_run_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_run_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_slip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_slip_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_strip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_franky_strip_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pants_cac_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pants_cac_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pants_iddle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pants_iddle_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pants_kickd_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pants_kickd_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pants_kickl_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pants_kickl_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pants_run_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pants_run_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pants_strip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pants_strip_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pull_cac_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pull_cac_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pull_iddle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pull_iddle_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pull_kickl_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pull_kickl_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pull_kickr_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pull_kickr_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pull_run_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pull_run_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pull_strip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_pull_strip_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoel_cac_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoel_cac_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoel_iddle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoel_iddle_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoel_kickl_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoel_kickl_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoel_kickr_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoel_kickr_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoel_run_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoel_run_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoel_strip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoel_strip_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoer_cac_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoer_cac_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoer_iddle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoer_iddle_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoer_kickl_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoer_kickl_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoer_kickr_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoer_kickr_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoer_run_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoer_run_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoer_strip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_shoer_strip_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_slip_iddle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_slip_iddle_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_slip_kickd_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_slip_kickd_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_slip_kickl_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_slip_kickl_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_slip_run_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_slip_run_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_slip_strip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hero_slip_strip_flip_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__img_hud_go_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }


#elseif html5














































































#else



#if (windows || mac || linux)


@:image("assets/img/Hero/franky_cac.png") #if display private #end class __ASSET__img_hero_franky_cac_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_cac_flip.png") #if display private #end class __ASSET__img_hero_franky_cac_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_catch.png") #if display private #end class __ASSET__img_hero_franky_catch_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_catch_flip.png") #if display private #end class __ASSET__img_hero_franky_catch_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_iddle.png") #if display private #end class __ASSET__img_hero_franky_iddle_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_iddle_flip.png") #if display private #end class __ASSET__img_hero_franky_iddle_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_kickD.png") #if display private #end class __ASSET__img_hero_franky_kickd_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_kickD_flip.png") #if display private #end class __ASSET__img_hero_franky_kickd_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_kickL.png") #if display private #end class __ASSET__img_hero_franky_kickl_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_kickL_flip.png") #if display private #end class __ASSET__img_hero_franky_kickl_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_run.png") #if display private #end class __ASSET__img_hero_franky_run_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_run_flip.png") #if display private #end class __ASSET__img_hero_franky_run_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_slip.png") #if display private #end class __ASSET__img_hero_franky_slip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_slip_flip.png") #if display private #end class __ASSET__img_hero_franky_slip_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_strip.png") #if display private #end class __ASSET__img_hero_franky_strip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/franky_strip_flip.png") #if display private #end class __ASSET__img_hero_franky_strip_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pants_cac.png") #if display private #end class __ASSET__img_hero_pants_cac_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pants_cac_flip.png") #if display private #end class __ASSET__img_hero_pants_cac_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pants_iddle.png") #if display private #end class __ASSET__img_hero_pants_iddle_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pants_iddle_flip.png") #if display private #end class __ASSET__img_hero_pants_iddle_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pants_kickD.png") #if display private #end class __ASSET__img_hero_pants_kickd_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pants_kickD_flip.png") #if display private #end class __ASSET__img_hero_pants_kickd_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pants_kickL.png") #if display private #end class __ASSET__img_hero_pants_kickl_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pants_kickL_flip.png") #if display private #end class __ASSET__img_hero_pants_kickl_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pants_run.png") #if display private #end class __ASSET__img_hero_pants_run_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pants_run_flip.png") #if display private #end class __ASSET__img_hero_pants_run_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pants_strip.png") #if display private #end class __ASSET__img_hero_pants_strip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pants_strip_flip.png") #if display private #end class __ASSET__img_hero_pants_strip_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pull_cac.png") #if display private #end class __ASSET__img_hero_pull_cac_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pull_cac_flip.png") #if display private #end class __ASSET__img_hero_pull_cac_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pull_iddle.png") #if display private #end class __ASSET__img_hero_pull_iddle_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pull_iddle_flip.png") #if display private #end class __ASSET__img_hero_pull_iddle_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pull_kickL.png") #if display private #end class __ASSET__img_hero_pull_kickl_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pull_kickL_flip.png") #if display private #end class __ASSET__img_hero_pull_kickl_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pull_kickR.png") #if display private #end class __ASSET__img_hero_pull_kickr_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pull_kickR_flip.png") #if display private #end class __ASSET__img_hero_pull_kickr_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pull_run.png") #if display private #end class __ASSET__img_hero_pull_run_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pull_run_flip.png") #if display private #end class __ASSET__img_hero_pull_run_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pull_strip.png") #if display private #end class __ASSET__img_hero_pull_strip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/pull_strip_flip.png") #if display private #end class __ASSET__img_hero_pull_strip_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeL_cac.png") #if display private #end class __ASSET__img_hero_shoel_cac_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeL_cac_flip.png") #if display private #end class __ASSET__img_hero_shoel_cac_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeL_iddle.png") #if display private #end class __ASSET__img_hero_shoel_iddle_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeL_iddle_flip.png") #if display private #end class __ASSET__img_hero_shoel_iddle_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeL_kickL.png") #if display private #end class __ASSET__img_hero_shoel_kickl_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeL_kickL_flip.png") #if display private #end class __ASSET__img_hero_shoel_kickl_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeL_kickR.png") #if display private #end class __ASSET__img_hero_shoel_kickr_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeL_kickR_flip.png") #if display private #end class __ASSET__img_hero_shoel_kickr_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeL_run.png") #if display private #end class __ASSET__img_hero_shoel_run_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeL_run_flip.png") #if display private #end class __ASSET__img_hero_shoel_run_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeL_strip.png") #if display private #end class __ASSET__img_hero_shoel_strip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeL_strip_flip.png") #if display private #end class __ASSET__img_hero_shoel_strip_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeR_cac.png") #if display private #end class __ASSET__img_hero_shoer_cac_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeR_cac_flip.png") #if display private #end class __ASSET__img_hero_shoer_cac_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeR_iddle.png") #if display private #end class __ASSET__img_hero_shoer_iddle_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeR_iddle_flip.png") #if display private #end class __ASSET__img_hero_shoer_iddle_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeR_kickL.png") #if display private #end class __ASSET__img_hero_shoer_kickl_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeR_kickL_flip.png") #if display private #end class __ASSET__img_hero_shoer_kickl_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeR_kickR.png") #if display private #end class __ASSET__img_hero_shoer_kickr_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeR_kickR_flip.png") #if display private #end class __ASSET__img_hero_shoer_kickr_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeR_run.png") #if display private #end class __ASSET__img_hero_shoer_run_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeR_run_flip.png") #if display private #end class __ASSET__img_hero_shoer_run_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeR_strip.png") #if display private #end class __ASSET__img_hero_shoer_strip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/shoeR_strip_flip.png") #if display private #end class __ASSET__img_hero_shoer_strip_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/slip_iddle.png") #if display private #end class __ASSET__img_hero_slip_iddle_png extends lime.graphics.Image {}
@:image("assets/img/Hero/slip_iddle_flip.png") #if display private #end class __ASSET__img_hero_slip_iddle_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/slip_kickD.png") #if display private #end class __ASSET__img_hero_slip_kickd_png extends lime.graphics.Image {}
@:image("assets/img/Hero/slip_kickD_flip.png") #if display private #end class __ASSET__img_hero_slip_kickd_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/slip_kickL.png") #if display private #end class __ASSET__img_hero_slip_kickl_png extends lime.graphics.Image {}
@:image("assets/img/Hero/slip_kickL_flip.png") #if display private #end class __ASSET__img_hero_slip_kickl_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/slip_run.png") #if display private #end class __ASSET__img_hero_slip_run_png extends lime.graphics.Image {}
@:image("assets/img/Hero/slip_run_flip.png") #if display private #end class __ASSET__img_hero_slip_run_flip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/slip_strip.png") #if display private #end class __ASSET__img_hero_slip_strip_png extends lime.graphics.Image {}
@:image("assets/img/Hero/slip_strip_flip.png") #if display private #end class __ASSET__img_hero_slip_strip_flip_png extends lime.graphics.Image {}
@:image("assets/img/hud/GO.png") #if display private #end class __ASSET__img_hud_go_png extends lime.graphics.Image {}



#end

#if openfl

#end

#end
#end

