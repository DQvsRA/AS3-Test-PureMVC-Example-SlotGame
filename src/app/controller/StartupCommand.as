/**
 * ...
 * @author Vladimir Minkin
 */

package app.controller {
	
	import app.controller.commands.prepare.PrepareBeginCommand;
	import app.controller.commands.prepare.PrepareCompleteCommand;
	import app.controller.commands.prepare.PrepareControllerCommand;
	import app.controller.commands.prepare.PrepareModelCommand;
	import app.controller.commands.prepare.PrepareViewCommand;
	import app.controller.commands.prepare.PrepareBeginCommand;
	import consts.commands.ApplicationCommand;
	import org.puremvc.as3.interfaces.INotification;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	public final class StartupCommand extends AsyncMacroCommand implements ICommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			this.addSubCommand( PrepareBeginCommand 		); // SimpleCommand
			this.addSubCommand( PrepareModelCommand 		); // AsyncCommand
			this.addSubCommand( PrepareControllerCommand 	); // AsyncCommand
			this.addSubCommand( PrepareViewCommand 			); // AsyncCommand
			this.addSubCommand( PrepareCompleteCommand 		); // AsyncCommand
			
			this.setOnComplete(function():void {
				facade.removeCommand( ApplicationCommand.STARTUP );
			})
		}
	}
}
