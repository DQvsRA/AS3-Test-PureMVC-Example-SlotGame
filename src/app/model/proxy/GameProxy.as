package app.model.proxy 
{
	import app.model.proxy.game.GameGrid;
	import consts.Defaults;
	import flash.geom.Point;
	import utils.FileUtils;

	import flash.filesystem.File;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public class GameProxy extends Proxy 
	{
		static public const NAME:String = "GameProxy";
		
		private static const PATH:String = "data/gamedata.xml";		
		
		public var finishedSlots:uint = 0;
		
		private var _predefinedResultsChanged:Boolean = false;
		
		public function get predefinedResultsChanged():Boolean { return predefinedResults && _predefinedResultsChanged; }
		public function get predefinedResults():Boolean { return _gameGrid.isGridEmpty == false; }
		public function get allSlotsFinished():Boolean { return finishedSlots == slotsCount; }
				
		private var _gameGrid:GameGrid = GameGrid.getInstance();
		
		public function GameProxy() 
		{
			super(NAME, new XML(FileUtils.readStringFromFile(PATH)));
		}
		
		override public function onRegister():void {
			//trace("GameData", gamedata);
			_gameGrid.init(slotsCount, slotsCount);
		}
		
		public function setGameGridValue(pointer:Point, value:String):void {
			_predefinedResultsChanged = true;
			if (value != "") _gameGrid.setValue(pointer.x, pointer.y, value);
			else _gameGrid.clearValue(pointer.x, pointer.y);
		}
		
		//==================================================================================================	
		public function gameGridResults():Array {
		//==================================================================================================	
			const result:Array = new Array(slotsCount);
			var innerArray:Array;
			var i:int, j:int;
			for (i = 0; i < slotsCount; i++) {
				innerArray = new Array();
				for (j = 0; j < itemsPerSlot; j++) {
					innerArray.push(_gameGrid.getValue(i, j) || "");
				}
				result[i] = innerArray;
			}
			_predefinedResultsChanged = false;
			return result;
		}
		
		public function startGame():void { 
			finishedSlots = 0;
		}
		
		public function endGame():void {
			
		}
		
		public function get slotsCount():uint {
			return uint(gamedata.slots.@count) || Defaults.SLOT_COUNT;
		}
		
		public function get slotsSpeed():uint {
			return uint(gamedata.slots.@speed) || Defaults.SLOT_SPEED;
		}
		
		public function get slotsItems():XMLList {
			return gamedata.slots.item as XMLList;
		}
		
		public function get itemsPerSlot():uint {
			return uint(gamedata.slots.@itemsPerSlot) || Defaults.SLOT_ITEMS_PER_SLOT;
		}
		
		public function get maxItemsPerSlot():uint {
			return uint(gamedata.slots.@maxItemsPerSlot) || itemsPerSlot * 2;
		}
		
		public function get slotsSpinTime():uint {
			return uint(gamedata.slots.@spinTime) || Defaults.SLOT_SPIN_TIME;
		}
		
		public function get slotsSpinTimeOffset():uint {
			return uint(gamedata.slots.@spinTimeOffset) || Defaults.SLOT_SPIN_TIME_OFFSET;
		}
		
		private function get gamedata():XML { return XML(this.data); }
		
	}

}