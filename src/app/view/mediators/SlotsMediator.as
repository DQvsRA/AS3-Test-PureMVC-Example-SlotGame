/**
 * ...
 * @author Vladimir Minkin
 */

package app.view.mediators 
{
	import app.model.proxy.GameProxy;
	import app.view.components.Slots;
	import app.view.components.slots.SlotSpinner;
	import consts.commands.GameCommands;
	import consts.notifications.ApplicationNotification;
	import consts.notifications.SlotsNotification;
	import starling.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * A Mediator for interacting with the ...
	 */
	public class SlotsMediator extends Mediator implements IMediator 
	{
		public static const NAME:String = "SlotsMediator";
		
		private var _gameProxy:GameProxy;
		
		public function SlotsMediator( viewComponent:Object ) {
			super( NAME, viewComponent );
		}
		
		override public function onRegister():void {
			this.sendNotification( ApplicationNotification.ADD_VIEW_COMPONENT, this.viewComponent );
			_gameProxy = facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			
			CreateSlots();
			
			slots.addEventListener(SlotSpinner.SPIN_COMPLETE, Handle_SpinnerComplete);
		}
		
		private function CreateSlots():void {
			slots.init(
				_gameProxy.slotsCount, 
				_gameProxy.itemsPerSlot, 
				_gameProxy.maxItemsPerSlot
			);
			
			const slotsItems:XMLList = _gameProxy.slotsItems;
			for each (var item:XML in slotsItems) {
				slots.appendSlotItem(item.@type); 
			}
			
			slots.fillSlotsWithItemsIfNeeded();
			slots.shuffle();
			
			slots.setupSpeed(_gameProxy.slotsSpeed);
			slots.setupSpinTime(_gameProxy.slotsSpinTime);
			slots.setupSpinTimeOffset(_gameProxy.slotsSpinTimeOffset);
		}
		
		private function Handle_SpinnerComplete(event:Event, index:int):void {
			_gameProxy.finishedSlots++;
			if (_gameProxy.allSlotsFinished) {
				this.sendNotification ( GameCommands.END_GAME );
			}
			event.stopImmediatePropagation();
		}
        
		override public function listNotificationInterests():Array {
			return [ 
				SlotsNotification.SPIN 
			,	SlotsNotification.RESET
			,	SlotsNotification.SHUFFLE
			];
		}

		override public function handleNotification( note:INotification ):void {
			switch ( note.getName() ) 
			{           
				case SlotsNotification.SPIN: 
					//trace("predefinedResults", _gameProxy.predefinedResults);
					if (_gameProxy.predefinedResults) {
						const changed:Boolean = _gameProxy.predefinedResultsChanged;
						//trace("predefinedResultsChanged", changed);
						if(changed)	slots.setupPredefineResult(_gameProxy.gameGridResults());
						slots.spinToResults(changed);
					} else {
						slots.spin();
					}
					break;
				case SlotsNotification.RESET:
					slots.reset();
					CreateSlots();
					break;
				case SlotsNotification.SHUFFLE:
					slots.shuffle();
					break;
			}
		}
		
		private function get slots():Slots { return this.viewComponent as Slots; }
	}
}