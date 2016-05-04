package app.controller.commands.prepare {
	
	import app.model.proxy.GameProxy;
	import app.model.proxy.UserProxy;
	import flash.utils.setTimeout;
	import org.puremvc.as3.interfaces.IProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public class PrepareModelCommand extends AsyncCommand
	{
		override public function execute( note:INotification ):void 
		{
			trace("> Startup - Prepare: \t Model");
			
			facade.registerProxy( new UserProxy() 	);
			facade.registerProxy( new GameProxy() 	);
			
			// Wait while loading resurces (for example)
			setTimeout(function():void {
				commandComplete();
			}, 1000);
			
		}
	}
}
