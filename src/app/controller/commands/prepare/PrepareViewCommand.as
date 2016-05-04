package app.controller.commands.prepare {
	import app.view.components.Controls;
	import app.view.components.Header;
	import app.view.components.Order;
	import app.view.components.Slots;
	import app.view.mediators.ControlsMediator;
	import app.view.mediators.HeaderMediator;
	import app.view.mediators.OrderMediator;
	import app.view.mediators.SlotsMediator;
	import consts.assets.SlotItemsAssets;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public class PrepareViewCommand extends AsyncCommand
	{
		override public function execute( note:INotification ):void 
		{
			trace("> Startup - Prepare: \t View");
			
			const scalefactor:Number = Application.SCALEFACTOR;
			
			SlotItemsAssets.getInstance().init(scalefactor);
			
			facade.registerMediator(new HeaderMediator		(new Header		()));
			facade.registerMediator(new ControlsMediator	(new Controls	()));
			facade.registerMediator(new SlotsMediator		(new Slots		()));
			facade.registerMediator(new OrderMediator		(new Order		()));
			
			commandComplete();
		}		
	}
}
