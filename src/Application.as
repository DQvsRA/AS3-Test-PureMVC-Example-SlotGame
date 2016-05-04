package 
{
	import consts.events.ApplicationEvent;
	import flash.system.Capabilities;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public class Application extends Sprite 
	{
		static public const isIOS		: Boolean = (Capabilities.manufacturer.indexOf("iOS") != -1);
		static public const isAndroid	: Boolean = (Capabilities.manufacturer.indexOf("Android") != -1);
		static public const
			SCALEFACTOR			: Number 	= Capabilities.isDebugger ? 1 : (Capabilities.screenDPI < Main.DEFAULT_DPI ? Capabilities.screenDPI / Main.DEFAULT_DPI : Capabilities.screenResolutionY / Main.DEFAULT_HEIGHT)
		,	SCREEN_WIDTH		: uint 		= Capabilities.isDebugger ? Main.DEFAULT_WIDTH : Capabilities.screenResolutionX
		,	SCREEN_HEIGHT		: uint 		= Capabilities.isDebugger ? Main.DEFAULT_HEIGHT : Capabilities.screenResolutionY
		,	PROPORTION_X		: Number 	= SCREEN_WIDTH / Main.DEFAULT_WIDTH
		,	PROPORTION_Y		: Number 	= SCREEN_HEIGHT / Main.DEFAULT_HEIGHT
		;
		
		[Embed(source="../assets/fonts/Lato/Lato-Light.ttf", 	embedAsCFF="false", fontFamily="LatoThin", fontStyle="normal", fontWeight = "normal", unicodeRange = "U+0020-U+0022, U+0026-U+0029, U+002c, U+002e-U+005a, U+0061-U+007a, U+0401, U+0410-U+044f, U+0451")]
		private static const LatoThin:Class;
		[Embed(source="../assets/fonts/Lato/Lato-Regular.ttf", 	embedAsCFF="false", fontFamily="Lato", fontStyle="normal", fontWeight = "normal", unicodeRange = "U+0020-U+0022, U+0026-U+0029, U+002c, U+002e-U+005a, U+0061-U+007a, U+0401, U+0410-U+044f, U+0451")]
		private static const LatoRegular:Class;
		[Embed(source="../assets/fonts/Lato/Lato-Bold.ttf", 	embedAsCFF="false", fontFamily="Lato", fontStyle="normal", fontWeight = "bold", unicodeRange = "U+0020-U+0022, U+0026-U+0029, U+002c, U+002e-U+005a, U+0061-U+007a, U+0401, U+0410-U+044f, U+0451")]
		private static const LatoBold:Class;
		[Embed(source="../assets/fonts/Lato/Lato-Heavy.ttf", 	embedAsCFF="false", fontFamily="LatoHeavy", fontStyle="normal", fontWeight = "bold", unicodeRange = "U+0020-U+0022, U+0026-U+0029, U+002c, U+002e-U+005a, U+0061-U+007a, U+0401, U+0410-U+044f, U+0451")]
		private static const LatoBlack:Class;
		
		public function Application() 
		{
			super();
		}
		
		public function initialized():void 
		{
			this.dispatchEventWith(ApplicationEvent.READY);
		}
	}
}