package app.view {
	
	import consts.commands.ApplicationCommand;
	import consts.events.ApplicationEvent;
	import consts.notifications.ApplicationNotification;
	import flash.display.Sprite;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public class ApplicationMediator extends Mediator implements IMediator 
	{
		static public const NAME:String = "ApplicationMediator";
		
		public function ApplicationMediator(viewComponent:Object) { 
			super( NAME, viewComponent ); 
		}
		
		//==================================================================================================
		override public function listNotificationInterests():Array {
		//==================================================================================================
			return [ 
				ApplicationNotification.PREPARE
			,	ApplicationNotification.INITIALIZED
			,	ApplicationNotification.ADD_VIEW_COMPONENT
			,	ApplicationNotification.ADD_FLASH_COMPONENT
			,	ApplicationNotification.REMOVE_VIEW_COMPONENT
			,	ApplicationNotification.REMOVE_FLASH_COMPONENT
			];
		}
		
		//==================================================================================================
		override public function handleNotification( note:INotification ):void {
		//==================================================================================================
			var name:String = note.getName();
			var body:Object = note.getBody();
			switch (name) {
				case ApplicationNotification.PREPARE: 					break;
				case ApplicationNotification.INITIALIZED: 	 			application.initialized(); break;
				
				case ApplicationNotification.ADD_VIEW_COMPONENT: 		application.addChild(body as DisplayObject); 		break;
				case ApplicationNotification.REMOVE_VIEW_COMPONENT: 	application.removeChild(body as DisplayObject); 	break;

				case ApplicationNotification.ADD_FLASH_COMPONENT: 		Starling.current.nativeOverlay.addChild(body as Sprite); 	break;
				case ApplicationNotification.REMOVE_FLASH_COMPONENT: 	Starling.current.nativeOverlay.removeChild(body as Sprite); 	break;
			}
		}
		
		
		//==================================================================================================
		override public function onRegister():void {
		//==================================================================================================
			application.addEventListener( ApplicationEvent.READY, ApplicationReadyHandler );
		}
		
		//==================================================================================================
		private function ApplicationReadyHandler():void {
		//==================================================================================================
			this.sendNotification( ApplicationCommand.READY );
			application.removeEventListener( ApplicationEvent.READY, ApplicationReadyHandler );
		}
		
		//==================================================================================================
		override public function onRemove():void {
		//==================================================================================================
			
		}
		
		private function get application():Application { return Application(this.viewComponent); }
	}
}
