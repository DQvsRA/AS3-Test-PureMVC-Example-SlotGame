package app.controller.commands.prepare {
	import app.controller.commands.game.EndGameCommand;
	import app.controller.commands.game.ResetSlotsCommand;
	import app.controller.commands.game.ShuffleSlotsCommand;
	import app.controller.commands.game.StartGameCommand;
	import consts.commands.GameCommands;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public class PrepareControllerCommand extends AsyncCommand
	{
		override public function execute( note:INotification ):void 
		{
			trace("> Startup - Prepare: \t Controller");
			
			facade.registerCommand( GameCommands.START_GAME, 	StartGameCommand );
			facade.registerCommand( GameCommands.END_GAME, 		EndGameCommand );
			facade.registerCommand( GameCommands.RESET_SLOTS, 	ResetSlotsCommand );
			facade.registerCommand( GameCommands.SHUFFLE_SLOTS, ShuffleSlotsCommand );
			
			commandComplete();
		}
	}
}
