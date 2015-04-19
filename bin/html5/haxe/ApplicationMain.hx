#if !macro


@:access(lime.Assets)


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	
	public static function create ():Void {
		
		var app = new lime.app.Application ();
		app.create (config);
		openfl.Lib.application = app;
		
		#if !flash
		var stage = new openfl.display.Stage (app.window.width, app.window.height, config.background);
		stage.addChild (openfl.Lib.current);
		app.addModule (stage);
		#end
		
		var display = new NMEPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		preloader.onComplete = init;
		preloader.create (config);
		
		#if (js && html5)
		var urls = [];
		var types = [];
		
		
		urls.push ("img/Boss/boss_attack1.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Boss/boss_attack2.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Boss/boss_attack2_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Boss/boss_death.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Boss/boss_death_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Boss/boss_hit.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Boss/boss_hit_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Boss/boss_iddle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Boss/boss_iddle_anim.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Boss/boss_walk.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Boss/boss_walk_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Flic/flic_attack.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Flic/flic_attack_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Flic/flic_iddle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Flic/flic_iddle_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Flic/flic_walk.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Flic/flic_walk_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/FX/boom/booom0001.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/FX/boom/booom0002.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/FX/boom/booom0003.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/FX/boom/booom0004.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/FX/boom/booom0005.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/FX/boom/booom0006.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/FX/boom/booom0007.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/FX/boom/booom0008.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/FX/boom/booom0009.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/FX/boom/booom0010.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/FX/boom/booom0011.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/FX/boom.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/FX/booom.fla");
		types.push (lime.Assets.AssetType.BINARY);
		
		
		urls.push ("img/Hero/franky_cac.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_cac_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_catch.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_catch_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_iddle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_iddle_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_kickD.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_kickD_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_kickL.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_kickL_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_run.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_run_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_slip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_slip_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_strip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/franky_strip_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pants_cac.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pants_cac_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pants_iddle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pants_iddle_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pants_kickD.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pants_kickD_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pants_kickL.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pants_kickL_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pants_run.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pants_run_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pants_strip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pants_strip_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pull_cac.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pull_cac_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pull_iddle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pull_iddle_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pull_kickL.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pull_kickL_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pull_kickR.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pull_kickR_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pull_run.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pull_run_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pull_strip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/pull_strip_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoe.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeL_cac.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeL_cac_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeL_iddle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeL_iddle_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeL_kickL.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeL_kickL_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeL_kickR.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeL_kickR_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeL_run.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeL_run_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeL_strip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeL_strip_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeR_cac.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeR_cac_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeR_iddle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeR_iddle_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeR_kickL.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeR_kickL_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeR_kickR.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeR_kickR_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeR_run.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeR_run_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeR_strip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoeR_strip_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/shoe_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/slip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/slip_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/slip_iddle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/slip_iddle_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/slip_kickD.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/slip_kickD_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/slip_kickL.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/slip_kickL_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/slip_run.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/slip_run_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/slip_strip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Hero/slip_strip_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/hud/credits.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/hud/GO.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Punk/punk_attack.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Punk/punk_attack_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Punk/punk_death.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Punk/punk_death_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Punk/punk_hit.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Punk/punk_hit_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Punk/punk_iddle.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Punk/punk_iddle_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Punk/punk_walk.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("img/Punk/punk_walk_flip.png");
		types.push (lime.Assets.AssetType.IMAGE);
		
		
		urls.push ("sounds/Blown Away.ogg");
		types.push (lime.Assets.AssetType.MUSIC);
		
		
		
		if (config.assetsPrefix != null) {
			
			for (i in 0...urls.length) {
				
				if (types[i] != lime.Assets.AssetType.FONT) {
					
					urls[i] = config.assetsPrefix + urls[i];
					
				}
				
			}
			
		}
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if (sys && !nodejs && !emscripten)
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (__) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		preloader = null;
		
		
		
		if (loaded == total) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			antialiasing: Std.int (0),
			background: Std.int (0),
			borderless: false,
			company: "TBaudon",
			depthBuffer: false,
			file: "LD32",
			fps: Std.int (60),
			fullscreen: false,
			height: Std.int (480),
			orientation: "",
			packageName: "LD32",
			resizable: true,
			stencilBuffer: true,
			title: "LD32",
			version: "1.0.0",
			vsync: false,
			width: Std.int (800),
			
		}
		
		#if (js && html5)
		#if (munit || utest)
		openfl.Lib.embed (null, 800, 480, "000000");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		var hasMain = false;
		var entryPoint = Type.resolveClass ("Main");
		
		for (methodName in Type.getClassFields (entryPoint)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		lime.Assets.initialize ();
		
		if (hasMain) {
			
			Reflect.callMethod (entryPoint, Reflect.field (entryPoint, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			/*if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}*/
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		
	}
	
	
	#if neko
	@:noCompletion public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


@:build(DocumentClass.build())
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					openfl.Lib.current.addChild (this);
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end
