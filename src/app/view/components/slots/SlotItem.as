package app.view.components.slots 
{
	import consts.Fonts;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import utils.DisplayUtils;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public final class SlotItem extends Sprite 
	{
		private var _index			:uint = 0;
		private var _type			:String = "";
		private var _predefined		:Boolean = false;
		
		//private const _tf			:TextField  = new TextField(50, 50, "", Fonts.LATO_REGULAR, 32)
		
		public function SlotItem(type:String, texture:Texture, predefined:Boolean = false) 
		{
			var image:Image = new Image(texture)
			this.addChild(image);
			
			//_tf.x = (image.width - _tf.width) * 0.5;
			//_tf.y = (image.height - _tf.height) * 0.5;
			//this.addChild(_tf);
			
			this._predefined = predefined;
			this._type = type;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function get index():uint 
		{
			return _index;
		}
		
		public function set index(value:uint):void 
		{
			_index = value;
			//_tf.text = String(value);
		}
		
		public function get predefined():Boolean 
		{
			return _predefined;
		}
		
		public function set predefined(value:Boolean):void 
		{
			_predefined = value;
		}
		

	}
}