/**
 * ...
 * @author Vladimir Minkin
 */

package app.view.mediators 
{
	import app.view.components.Header;
	import consts.notifications.ApplicationNotification;
	import consts.notifications.HeaderNotification;
	import consts.notifications.OrderNotification;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import starling.events.Event;
	
	/**
	 * A Mediator for interacting with the ...
	 */
	public final class HeaderMediator extends Mediator implements IMediator 
	{
		// Cannonical name of the Mediator
		public static const NAME:String = "HudHeaderMediator";
		
		public function HeaderMediator( viewComponent:Object ) {
			// pass the viewComponent to the superclass where 
			// it will be stored in the inherited viewComponent property
			super( NAME, viewComponent );
		}
		
		override public function onRegister():void {
			this.sendNotification( ApplicationNotification.ADD_VIEW_COMPONENT, this.viewComponent );
			header.addEventListener( Event.TRIGGERED, Handler_TriggerEvent);
		}
		
		private function Handler_TriggerEvent(e:Event):void {
			switch(e.target) {
					case header.orderButton:
						this.sendNotification( OrderNotification.SHOW_ORDER );
						break;
			}
		}
        
		/**
		 * List all notifications this Mediator is interested in.
		 * <P>
		 * Automatically called by the framework when the mediator
		 * is registered with the view.</P>
		 * 
		 * @return Array the list of Nofitication names
		 */
		override public function listNotificationInterests():Array {
			return [
				HeaderNotification.SET_SCORE
			,	HeaderNotification.SET_GAMES_PLAYED
			,	HeaderNotification.ENABLE_ORDER_BUTTON
			,	HeaderNotification.DISABLE_ORDER_BUTTON
			];
		}
		
		/**
		 * Handle all notifications this Mediator is interested in.
		 * <P>
		 * Called by the framework when a notification is sent that
		 * this mediator expressed an interest in when registered
		 * (see <code>listNotificationInterests</code>.</P>
		 * 
		 * @param INotification a notification 
		 */
		override public function handleNotification( note:INotification ):void {
			switch ( note.getName() ) 
			{    
				case HeaderNotification.SET_SCORE: 				header.setScore( uint(note.getBody()) ); 		break;
				case HeaderNotification.SET_GAMES_PLAYED: 		header.setGamesPlayed( uint(note.getBody()) ); 	break;
				case HeaderNotification.ENABLE_ORDER_BUTTON: 	header.orderButton.enabled = true; 				break;
				case HeaderNotification.DISABLE_ORDER_BUTTON: 	header.orderButton.enabled = false; 			break;
			}
		}
		
		private function get header():Header { return this.viewComponent as Header } 
	}
}