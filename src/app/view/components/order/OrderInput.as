package app.view.components.order 
{
	import consts.Fonts;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public final class OrderInput extends TextField 
	{
		private var _pointer:Point;
		public function get pointer():Point {
			return _pointer;
		}
		
		public function OrderInput(i:uint, j:uint) 
		{
			_pointer = new Point(i, j);
			super();
			
			const fontSize:uint = 32;
			
			var textformat:TextFormat = new TextFormat(Fonts.LATO_REGULAR, fontSize, 0xf1f1f1);
			textformat.align = TextFormatAlign.CENTER;
			
			width = 200;
			height = fontSize * 1.5;
			type = TextFieldType.INPUT;
			x = 250 * i;
			y = 80 * j;
			autoSize = TextFieldAutoSize.NONE
			defaultTextFormat = textformat;
			multiline = false;
			maxChars = 15;
			
			backgroundColor = 0x121212;
			background = true;
			borderColor = 0x666666;
			border = true;
		}
	}
}