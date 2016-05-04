/**
 * ...
 * @author Vladimir Minkin
 */
	
package app 
{
	import app.controller.commands.ReadyCommand;
	import app.controller.StartupCommand;
	import app.view.ApplicationMediator;
	import consts.commands.ApplicationCommand;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	import starling.core.Starling;
	
	public class ApplicationFacade extends Facade implements IFacade 
	{
		public static function getInstance():ApplicationFacade { 
			return ApplicationFacade( instance ? instance : instance = new ApplicationFacade() );
		}
		
		//==================================================================================================
		override protected function initializeView():void {
		//==================================================================================================
			super.initializeView();
			this.registerMediator(new ApplicationMediator(Starling.current.root));
		}
		
		//==================================================================================================
		override protected function initializeModel():void {
		//==================================================================================================
			super.initializeModel();
		}
		
		//==================================================================================================
		override protected function initializeController():void {
		//==================================================================================================
			super.initializeController();
			this.registerCommand( ApplicationCommand.READY, 	ReadyCommand 		);
			this.registerCommand( ApplicationCommand.STARTUP, 	StartupCommand 		);
		}
		
		//==================================================================================================
		public function startup( root:Object ):void {
		//==================================================================================================
			this.sendNotification( ApplicationCommand.STARTUP, root );
		}
	}
}
