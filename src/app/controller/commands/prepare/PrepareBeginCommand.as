package app.controller.commands.prepare {
	
	import consts.notifications.ApplicationNotification;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public class PrepareBeginCommand extends SimpleCommand implements ICommand
	{
		override public function execute( note:INotification ):void 
		{
			this.sendNotification( ApplicationNotification.PREPARE );
		}
	}
}
