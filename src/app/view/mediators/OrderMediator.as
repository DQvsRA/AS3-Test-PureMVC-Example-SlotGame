/**
 * ...
 * @author Vladimir Minkin
 */

package app.view.mediators 
{
	import app.model.proxy.GameProxy;
	import app.view.components.Order;
	import app.view.components.order.OrderInput;
	import consts.entities.SlotItems;
	import consts.notifications.ApplicationNotification;
	import consts.notifications.HeaderNotification;
	import consts.notifications.OrderNotification;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.INotifier;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import starling.core.Starling;
	
	/**
	 * A Mediator for interacting with the ...
	 */
	public class OrderMediator extends Mediator implements IMediator 
	{
		
		static private const PRESETS_MODEL:Array = [
			[	
				[ SlotItems.BANANA, SlotItems.BELL, 	SlotItems.APPLE ]
			,	[ SlotItems.CHERRY, SlotItems.APPLE, 	SlotItems.LEMON ]
			,	[ SlotItems.BELL, 	SlotItems.BELL, 	SlotItems.CHERRY ]
			],
			[
				[ SlotItems.CHERRY, SlotItems.LEMON, SlotItems.BANANA ]
			,	[ SlotItems.BELL, SlotItems.LEMON, SlotItems.BELL ]
			,	[ SlotItems.BANANA, SlotItems.CHERRY, SlotItems.APPLE ]
			],
			[
				[ SlotItems.LEMON, SlotItems.CHERRY, SlotItems.BELL ]
			,	[ SlotItems.LEMON, SlotItems.BANANA, SlotItems.APPLE ]
			,	[ SlotItems.CHERRY, SlotItems.APPLE, SlotItems.BANANA ]
			],
			[
				[ SlotItems.CHERRY, SlotItems.LEMON, SlotItems.BANANA ]
			,	[ SlotItems.LEMON, SlotItems.BANANA, SlotItems.BELL ]
			,	[ SlotItems.APPLE, SlotItems.APPLE, SlotItems.APPLE ]
			],
			[
				[ SlotItems.LEMON, SlotItems.APPLE, SlotItems.BELL ]
			,	[ SlotItems.CHERRY, SlotItems.CHERRY, SlotItems.CHERRY ]
			,	[ SlotItems.BANANA, SlotItems.BELL, SlotItems.LEMON ]
			]
		]
			
		// Cannonical name of the Mediator
		public static const NAME:String = "OrderMediator";
		
		private var _gameProxy:GameProxy;
		
		public function OrderMediator( viewComponent:Object ) {
			// pass the viewComponent to the superclass where 
			// it will be stored in the inherited viewComponent property
			super( NAME, viewComponent );
		}
		
		override public function onRegister():void {
			_gameProxy = facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_UP, function (e:KeyboardEvent):void 
			{
				switch (e.keyCode) 
				{
					case Keyboard.NUMBER_0:
						order.clearPreset();
						break;
					case Keyboard.NUMBER_1:
					case Keyboard.NUMBER_2:
					case Keyboard.NUMBER_3:
					case Keyboard.NUMBER_4:
					case Keyboard.NUMBER_5:
						order.applyPreset(PRESETS_MODEL[e.keyCode - 49]);
					break;
					default:
				}
			})
			
			order.init(_gameProxy.slotsCount, _gameProxy.itemsPerSlot);
			
			order.addEventListener(MouseEvent.CLICK, Handle_MouseClickEvent);
			order.addEventListener(Event.CHANGE, Handle_ChangeEvent);
		}
		
		private function Handle_ChangeEvent(e:Event):void {
			var orderInput:OrderInput = e.target as OrderInput;
			_gameProxy.setGameGridValue(orderInput.pointer, orderInput.text);
			e.stopImmediatePropagation();
		}
		
		private function Handle_MouseClickEvent(e:Event):void {
			switch (e.target) 
			{
				case order.closeButton: RemoveViewComponentFromScreen(); break;
			}
		}
        
		override public function listNotificationInterests():Array {
			return [
				OrderNotification.SHOW_ORDER
			,	OrderNotification.HIDE_ORDER	
			];
		}
		
		override public function handleNotification( note:INotification ):void {
			switch ( note.getName() ) 
			{           
				case OrderNotification.SHOW_ORDER: AddViewComponentFromScreen();  break;
				case OrderNotification.HIDE_ORDER: RemoveViewComponentFromScreen(); break;
				case OrderNotification.LOCK_ORDER:  break;
				case OrderNotification.UNLOCK_ORDER:  break;
			}
		}
		
		private function AddViewComponentFromScreen():void {
			if(order.parent == null) {
				this.sendNotification( HeaderNotification.DISABLE_ORDER_BUTTON );
				this.sendNotification( ApplicationNotification.ADD_FLASH_COMPONENT, this.viewComponent );
			}
		}
		
		private function RemoveViewComponentFromScreen():void {
			var that:OrderMediator = this;
			order.close(function():void {
				that.sendNotification( ApplicationNotification.REMOVE_FLASH_COMPONENT, that.viewComponent );
				that.sendNotification( HeaderNotification.ENABLE_ORDER_BUTTON );
				that = null;
			})
		}
		
		public function get order():Order { return this.viewComponent as Order; }
	}
}