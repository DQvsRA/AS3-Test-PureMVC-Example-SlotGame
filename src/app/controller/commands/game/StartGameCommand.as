/**
 * ...
 * @author Vladimir Minkin
 */

package app.controller.commands.game 
{
	import app.model.proxy.GameProxy;
	import consts.notifications.SlotsNotification;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartGameCommand extends SimpleCommand 
	{
		/**
         * Register the Proxies and Mediators.
         */
		override public function execute( note:INotification ):void 
		{
			const gameProxy:GameProxy = facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			gameProxy.startGame();
			this.sendNotification(SlotsNotification.SPIN);
		}
		
	}
}