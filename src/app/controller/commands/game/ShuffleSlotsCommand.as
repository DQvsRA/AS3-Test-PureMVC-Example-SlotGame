/**
 * ...
 * @author Vladimir Minkin
 */

package app.controller.commands.game 
{
	import consts.notifications.SlotsNotification;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ShuffleSlotsCommand extends SimpleCommand implements ICommand 
	{
		
		/**
         * Register the Proxies and Mediators.
         */
		override public function execute( note:INotification ):void 
		{
			this.sendNotification ( SlotsNotification.SHUFFLE );
		}
		
	}
}