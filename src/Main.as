package
{
	import Application;
	import app.ApplicationFacade;
	import com.greensock.TweenNano;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Graphics;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	[SWF(frameRate="60")]
	public class Main extends Sprite
	{
		private const ROOT_CREATED:String = "rootCreated";
		
		static private var console:TextField;
		
		static public const
			DEFAULT_WIDTH			: uint = 1024
		,	DEFAULT_HEIGHT			: uint = 768
		,	DEFAULT_DPI 			: uint = 132
		;

		private var _splash:Sprite;
		
		//==================================================================================================
		public static function log(message:String):void { if(console) console.text = "\n> " + message + console.text; }
		public function Main() {
		//==================================================================================================
			if(this.stage) Initialize(null)
			else this.addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		//==================================================================================================
		private function SetupConsole():void {
		//==================================================================================================
			console = new TextField();
			console.textColor = 0xff0000;
			console.width = DEFAULT_WIDTH;
			console.height = DEFAULT_HEIGHT;
			stage.addChild(console);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, function (e:KeyboardEvent):void 
			{
				switch (e.keyCode) 
				{
					case Keyboard.C:
						console.text = "";
						break;
				}
			})
			log("Console Initialized");
		}
		
		//==================================================================================================
		private function Initialize(e:Event):void {
		//==================================================================================================
			if(this.hasEventListener(Event.ADDED_TO_STAGE)) removeEventListener(Event.ADDED_TO_STAGE, Initialize);
			
			SetupStage();
			SetupSplash();
			//SetupConsole();
			SetupStarling();
		}
		
		//==================================================================================================
		private function SetupStage():void {
		//==================================================================================================
			Multitouch.inputMode 	= MultitouchInputMode.TOUCH_POINT;
			stage.align 			= StageAlign.BOTTOM_LEFT;
			stage.scaleMode 		= StageScaleMode.NO_SCALE;
			stage.autoOrients 		= true;
			stage.color				= 0xf1f1f1;
			stage.displayState		= StageDisplayState.FULL_SCREEN;
			stage.setAspectRatio('landscape');
			stage.quality			= StageQuality.HIGH;
			stage.addEventListener(Event.DEACTIVATE, HandlerDeactivate);
			
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
			NativeApplication.nativeApplication.autoExit = true;
		}
		
		//==================================================================================================
		private function SetupSplash():void {
		//==================================================================================================
			_splash = new Sprite();
			const gr:Graphics = _splash.graphics;
			const landscape:Boolean = stage.stageWidth > stage.stageHeight;
			const sw:uint = landscape ? stage.stageWidth : stage.stageHeight;
			const sh:uint = landscape ? stage.stageHeight : stage.stageWidth ;
			gr.beginFill(0x232323);
			gr.drawRect(0, 0, sw, sh);
			gr.endFill();
			
			showSplash();
		}
		
		/**
		 * Called from PrepareCompleteCommand
		 */
		//==================================================================================================
		public function hideSplash():void {
		//==================================================================================================
			TweenNano.to(_splash, 0.3, {alpha:0, onComplete:removeChild, onCompleteParams:[_splash] })
		}
		
		/**
		 * Called from SetupSplash
		 */
		//==================================================================================================
		public function showSplash():void {
		//==================================================================================================
			this.addChild(_splash);
		}
		
		//==================================================================================================
		private function SetupStarling():void {
		//==================================================================================================
			Starling.multitouchEnabled = true;
			const viewport:Rectangle = new Rectangle(0,0, Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			const starling:Starling = new Starling(Application, stage, viewport);
			
			starling.stage.stageWidth = viewport.width;
			starling.stage.stageHeight = viewport.height;
			starling.addEventListener(ROOT_CREATED, StartApplication);
			starling.start();
		}
		
		//==================================================================================================
		private function StartApplication(e:*):void {
		//==================================================================================================
			Starling.current.removeEventListener(ROOT_CREATED, StartApplication);
			ApplicationFacade.getInstance().startup(this);
		}
		
		//==================================================================================================
		private function HandlerDeactivate(e:Event):void {
		//==================================================================================================
//			NativeApplication.nativeApplication.exit();
		}
	}
}