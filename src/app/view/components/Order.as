package app.view.components 
{
	import app.view.components.order.OrderInput;
	import com.greensock.TweenNano;
	import consts.Colors;
	import consts.Fonts;
	import consts.entities.SlotItems;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public final class Order extends Sprite 
	{
		private const sf:Number = Application.SCALEFACTOR;
		
		private const BTN_CLOSE_OFFSET:uint = 16 * sf;

		private const _tfContainer:Sprite = new Sprite();
		
		private var _orderInput:OrderInput;
		
		public var closeButton:SimpleButton;
		
		public function Order()
		{
			super();
			graphics.beginFill(0x232323, 0.95);
			graphics.drawRect(0, 0, Application.SCREEN_WIDTH, Application.SCREEN_HEIGHT * 0.5);
			graphics.endFill();
			
			closeButton =  new CloseButton();
			closeButton.x = this.width - BTN_CLOSE_OFFSET - closeButton.width;
			closeButton.y = BTN_CLOSE_OFFSET;
			this.addChild(closeButton);
			
			this.addChild(_tfContainer);
			
			this.addEventListener(Event.ADDED_TO_STAGE, Handler_AddedToStage);
			
			var message:TextField = new TextField();
			message.defaultTextFormat = new TextFormat(Fonts.LATO_REGULAR, 16, 0x777777);
			message.text = "User keyboard 1,2,3,4,5 buttons to switch presets, or press 0 to reset";
			message.autoSize = TextFieldAutoSize.CENTER;
			message.x = ( this.width - message.width )  * 0.5;
			message.y = this.height  - message.height - 32;
			this.addChild(message);
			
			this.y = -this.height;
		}
		
		private function Handler_AddedToStage(e:Event):void {
			closeButton.enabled = false;
			
			TweenNano.to(this, 0.25, { y:0, onComplete:function():void 
			{
				closeButton.enabled = true;
			} } );
		}
		
		public function close(callback:Function):void 
		{
			closeButton.enabled = false;
			TweenNano.to(this, 0.25, { y:-this.height, onComplete:callback } );
		}
		
		public function init(gridXSize:uint, gridYSize:uint):void 
		{
			for (var i:int = 0; i < gridXSize; i++) {
				for (var j:int = 0; j < gridYSize; j++) {
					_orderInput = new OrderInput(j, i);
					_tfContainer.addChild(_orderInput);
				}
			}
			
			_tfContainer.x = (this.width - _tfContainer.width) * 0.5;
			_tfContainer.y = (this.height - _tfContainer.height) * 0.5;
		}
		
		public function applyPreset(preset:Array):void 
		{
			var inner:Array;
			var count:uint = _tfContainer.numChildren-1;
			for (var i:int = 0; i < preset.length; i++) {
				inner = preset[i];
				for (var j:int = 0; j < inner.length; j++) {
					_orderInput = (_tfContainer.getChildAt(count--) as OrderInput);
					_orderInput.text = inner[j];
					_orderInput.dispatchEvent(new Event(Event.CHANGE, true));
				}
			}
		}
		
		public function clearPreset():void 
		{
			var childsCount:uint = _tfContainer.numChildren;
			while (childsCount--) {
				_orderInput = _tfContainer.getChildAt(childsCount) as OrderInput;
				_orderInput.text = "";
				_orderInput.dispatchEvent(new Event(Event.CHANGE, true));
			}
		}
	}

}