package app.model.proxy.game 
{
	/**
	 * ...
	 * @author Vladimir Minkin (vk.com/dqvsra)
	 */
	public class GameGrid 
	{
		private var _grid:Vector.<String>;
		private var _limitX:uint = 0;
		private var _limitY:uint = 0;
		
		private static var _instance:GameGrid = new GameGrid();
		//==================================================================================================	

		private var _ypos:uint;
		private var _position:uint;
		
		public static function getInstance():GameGrid {
		//==================================================================================================	
			return _instance;
		}
		
		public function GameGrid() 
		{
			
		}
		
		//==================================================================================================	
		public function init(xlimit:uint, ylimit:uint):void {
		//==================================================================================================	
			_limitX = xlimit;
			_limitY = ylimit;
			_grid = new Vector.<String>(_limitX * _limitY);
		}
		
		//==================================================================================================	
		public function get isGridEmpty():Boolean {
		//==================================================================================================	
			const limit:uint = _limitX * _limitY;	
			var value:String = "";
			for (var i:int = 0; i < limit; i++) {
				value = _grid[i];
				if (value != null && value.length > 0) return false;
			}
			return true;
		}
		
		//==================================================================================================	
		public function getValue(x:uint, y:uint):String {
		//==================================================================================================	
			_ypos = y * limitX;
			_position = x + _ypos;
			var result:String = _grid[ _position ];
			return result;
		}
		
		//==================================================================================================	
		public function setValue(x:uint, y:uint, value:String):uint {
		//==================================================================================================	
			_ypos = y * limitX;
			_position = x + _ypos;
			_grid[ _position ] = value;
			return _position;
		}
		
		//==================================================================================================	
		public function clearValue(x:uint, y:uint):uint {
			//==================================================================================================	
			_ypos = y * limitX;
			_position = x + _ypos;
			_grid[ _position ] = null;
			return _position;
		}
		
		//==================================================================================================	
		public function setValueAtPosition(position:uint, value:String):void {
			//==================================================================================================	
			_grid[ position ] = value;
		}
	
		//==================================================================================================
		public function get limitX():uint {
		//==================================================================================================
			return _limitX;
		}
		
		//==================================================================================================
		public function get limitY():uint {
		//==================================================================================================
			return _limitY;
		}
		
		//==================================================================================================	
		public function toString(xlim:uint = 0, ylim:uint = 0, offsetX:uint = 0, offsetY:uint = 0, tabulation:Boolean = true):String {
		//==================================================================================================	
			if (xlim == 0) xlim = limitX; else xlim += offsetX;
			if (ylim == 0) ylim = limitY; else ylim += offsetY;
			var result:String = "\n ======== GAME GRID : " + (xlim-offsetX) + "x" + (ylim-offsetY) + " | " + offsetX + "x" + offsetY + " ======== \n";
			for (var i:int = offsetY; i < ylim + 1; i++) 
			{
				for (var j:int = offsetX; j < xlim + 1; j++) 
				{
					if(i == offsetY) result += (j < 10 ? " " : "") + j + (tabulation ? "\t" : "") +  " | ";
					else if(j == offsetX && i > offsetY) result += (i < 10 ? " " : "") + i + (tabulation ? "\t" : "") + " | ";
					else 
						result += " " + getValue(j-1, i-1) + (tabulation ? "\t" : "") + " | ";
				}
				result += "\n";
			}
			return result;
		}
	}

}
