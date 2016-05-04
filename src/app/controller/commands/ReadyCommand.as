/**
 * ...
 * @author Vladimir Minkin
 */

package app.controller.commands 
{
	import consts.commands.ApplicationCommand;
	import consts.notifications.OrderNotification;
	import flash.utils.setTimeout;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.interfaces.INotifier;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ReadyCommand extends SimpleCommand implements ICommand 
	{
		override public function execute( note:INotification ):void 
		{
			var that:INotifier = this;
			setTimeout(function():void{
				that.sendNotification( OrderNotification.SHOW_ORDER );
				that = null;
			}, 1000)
			
			this.facade.removeCommand( ApplicationCommand.READY );
		}
		
	}
}