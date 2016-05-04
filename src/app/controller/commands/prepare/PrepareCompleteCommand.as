package app.controller.commands.prepare {
	import app.model.proxy.UserProxy;
	import consts.notifications.ApplicationNotification;
	import consts.notifications.HeaderNotification;
	import flash.system.Capabilities;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public class PrepareCompleteCommand extends SimpleCommand
	{ 
		override public function execute( note:INotification ):void 
		{
			Main(note.getBody()).hideSplash();
			
			const userProxy:UserProxy = this.facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			
			this.sendNotification( HeaderNotification.SET_SCORE, userProxy.userScore);
			this.sendNotification( HeaderNotification.SET_GAMES_PLAYED, userProxy.userGamesPlayed);
			
			this.sendNotification( ApplicationNotification.INITIALIZED );
		}
	}
}
