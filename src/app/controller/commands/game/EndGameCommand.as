/**
 * ...
 * @author Vladimir Minkin
 */

package app.controller.commands.game 
{
	import app.model.proxy.GameProxy;
	import app.model.proxy.UserProxy;
	import consts.notifications.ControlsNotification;
	import consts.notifications.HeaderNotification;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class EndGameCommand extends SimpleCommand
	{
		/**
         * Register the Proxies and Mediators.
         */
		override public function execute( note:INotification ):void 
		{
			const gameProxy:GameProxy = facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			const userProxy:UserProxy = facade.retrieveProxy(UserProxy.NAME) as UserProxy;
			
			const userGamesPlayed:uint = ++userProxy.userGamesPlayed;
			
			gameProxy.endGame();
			
			this.sendNotification( HeaderNotification.SET_GAMES_PLAYED, userGamesPlayed);
			this.sendNotification( ControlsNotification.UNLOCK_CONTROLS );
		}
		
	}
}