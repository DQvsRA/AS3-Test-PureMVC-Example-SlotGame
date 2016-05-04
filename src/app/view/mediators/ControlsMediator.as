/**
 * ...
 * @author Vladimir Minkin
 */

package app.view.mediators 
{
	import app.view.components.Controls;
	import consts.commands.GameCommands;
	import consts.notifications.ApplicationNotification;
	import consts.notifications.ControlsNotification;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import starling.events.Event;
	
	/**
	 * A Mediator for interacting with the ...
	 */
	public class ControlsMediator extends Mediator implements IMediator 
	{
		// Cannonical name of the Mediator
		public static const NAME:String = "ControlsMediator";
		
		public function ControlsMediator( viewComponent:Object ) {
			// pass the viewComponent to the superclass where 
			// it will be stored in the inherited viewComponent property
			super( NAME, viewComponent );
		}
		
        override public function onRegister():void {
			this.sendNotification( ApplicationNotification.ADD_VIEW_COMPONENT, this.viewComponent );
			
			controls.addEventListener(Event.TRIGGERED, Handle_TriggerEvent);
		}
		
		private function Handle_TriggerEvent(e:Event):void {
			switch (e.target) 
			{
				case controls.spinButton:
					controls.lockControls();
					this.sendNotification( GameCommands.START_GAME );
				break;
				case controls.resetButton:
					this.sendNotification ( GameCommands.RESET_SLOTS );
				break;
				case controls.shuffleButton:
					this.sendNotification ( GameCommands.SHUFFLE_SLOTS );
				break
			}
		}
        
		override public function listNotificationInterests():Array {
			return [
				ControlsNotification.UNLOCK_CONTROLS
			];
		}
		
		override public function handleNotification( note:INotification ):void {
			switch ( note.getName() ) 
			{           
				case ControlsNotification.UNLOCK_CONTROLS:
					controls.unlockControls();
					break;
			}
		}
		
		private function get controls():Controls { return this.viewComponent as Controls; }
	}
}