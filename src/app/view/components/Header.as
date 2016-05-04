package app.view.components 
{
	import consts.Colors;
	import consts.Fonts;
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import utils.DisplayUtils;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public final class Header extends Sprite 
	{
		static private const 
			TF_SCORE_TEXT:String = "SCORE: @"
		,	TF_GAMES_TEXT:String = "GAMES: @"
		;
		
		static public const 
			sf:Number =  Application.SCALEFACTOR
			
		,	HEADER_HEIGHT		:uint = 64 * sf
		,	HEADER_COLOR		:uint = Colors.HEADER
		
		,	ORDER_BTN_X			:uint = 32 * sf
		
		,	TF_SCORE_WIDTH 		:uint = 256 * sf
		,	TF_GAMES_WIDTH 		:uint = TF_SCORE_WIDTH
		
		,	TF_FONT_NAME 		:String = Fonts.LATO_REGULAR
		,	TF_FONT_SIZE 		:uint = 24 * sf
		,	TF_FONT_CLR 		:uint = Colors.HEADER_TEXT

		,	TF_HEIGHT 		:uint = TF_FONT_SIZE * 1.5
		;
		
		private const 
			_scoreTF		:TextField = new TextField(TF_SCORE_WIDTH, TF_HEIGHT, TF_SCORE_TEXT, TF_FONT_NAME, TF_FONT_SIZE, TF_FONT_CLR)
		,	_gamePlayedTF	:TextField = new TextField(TF_GAMES_WIDTH, TF_HEIGHT, TF_GAMES_TEXT, TF_FONT_NAME, TF_FONT_SIZE, TF_FONT_CLR)
		;
		
		public var orderButton:Button;
				
		public function Header() 
		{
			super();
			
			const back:Quad = new Quad(Application.SCREEN_WIDTH, HEADER_HEIGHT, HEADER_COLOR);
			this.addChild(back);
			
			_scoreTF.hAlign = HAlign.LEFT;
			_scoreTF.vAlign = VAlign.CENTER;
			_scoreTF.x = HEADER_HEIGHT;
			_scoreTF.y = (HEADER_HEIGHT - TF_HEIGHT) * 0.5;
			
			_gamePlayedTF.hAlign = _scoreTF.hAlign;
			_gamePlayedTF.vAlign = _scoreTF.vAlign;
			_gamePlayedTF.x = _scoreTF.x * 2 + _scoreTF.width;
			_gamePlayedTF.y = _scoreTF.y;
			
			orderButton = DisplayUtils.getButtonFromSimpleButtonClass(OrderButton, sf);
			orderButton.x = back.width - ORDER_BTN_X - orderButton.width;
			orderButton.y = (HEADER_HEIGHT - orderButton.height) * 0.5;
			this.addChild(orderButton);
			
			this.addChild(_scoreTF);
			this.addChild(_gamePlayedTF);
		}
		
		public function setScore(value:uint):void {
			_scoreTF.text = TF_SCORE_TEXT.replace("@", value);
		}
		
		public function setGamesPlayed(value:uint):void {
			_gamePlayedTF.text = TF_GAMES_TEXT.replace("@", value);
		}
	}

}