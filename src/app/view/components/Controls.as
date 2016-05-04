package app.view.components 
{
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import utils.DisplayUtils;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public final class Controls extends Sprite 
	{
		public var 
			spinButton		:Button
		,	shuffleButton	:Button
		,	resetButton		:Button
		;
		
		public function Controls() 
		{
			super();
			
			const sf:Number = Application.SCALEFACTOR;
			
			spinButton 		= DisplayUtils.getButtonFromSimpleButtonClass(SpinButton, sf);
			shuffleButton 	= DisplayUtils.getButtonFromSimpleButtonClass(ShuffleButton, sf);
			resetButton 	= DisplayUtils.getButtonFromSimpleButtonClass(ResetButton, sf);
			
			shuffleButton.x = spinButton.width + 16 * sf;
			resetButton.x = shuffleButton.x;
			
			resetButton.y = shuffleButton.y + spinButton.height - resetButton.height;
			
			this.addChild(spinButton);
			this.addChild(shuffleButton);
			this.addChild(resetButton);
			
			this.x = (Application.SCREEN_WIDTH - this.width) * 0.5;
			this.y = Application.SCREEN_HEIGHT - this.height - 32 * sf;
		}
		
		public function lockControls():void {
			spinButton.enabled = false;
			shuffleButton.enabled = false;
			resetButton.enabled = false;
		}
		
		public function unlockControls():void {
			spinButton.enabled = true;
			shuffleButton.enabled = true;
			resetButton.enabled = true;
		}
	}
}