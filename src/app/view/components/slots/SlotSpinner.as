package app.view.components.slots 
{
	import flash.geom.Point;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.DebugUtils;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public final class SlotSpinner extends Sprite 
	{
		static public const SPIN_COMPLETE:String = "spin_complete_event";
		
		private var _itemsCount:uint = 3;
		public function set itemsCount(value:uint):void { _itemsCount = value; }
		
		private var _maxItemsCount:uint = _itemsCount * 2;
		public function get maxItemsCount():uint { return _maxItemsCount; }
		
		private var _speed:uint = 250;
		public function set speed(value:uint):void { _speed = value; }
		
		private var _spinTime:uint = 2;
		public function set spinTime(value:uint):void { _spinTime = value; }
		
		private var _spinTimeOffset:uint = 0;
		public function set spinTimeOffset(value:uint):void { _spinTimeOffset = value; }
		
		private var _index:uint = 0;
		public function get index():uint { return _index; }
				
		private var _predefinedItems:Array = new Array();
		public function get predefinedItem():Array { return _predefinedItems; }

		private var _itemHeight		:uint = 0;
		private var _slotHeight		:uint = 0;
		
		private var _deltaOffset	:uint = 0;
		
		private var _lastIndex		:uint = 0;
		private var _swapPosition	:int = 0;
		
		private const _localPoint	:Point = new Point();
		private const _globalPoint	:Point = new Point();
		
		private var _slotItems		:Array = new Array();
		
		private var _counter		:uint;
		private	var _slotItem		:SlotItem;
		
		public function SlotSpinner(index:uint, maxItemsCount:uint, slotHeight:uint, itemDelta:uint, itemHeight:uint) 
		{
			super();
			_index = index;
			_maxItemsCount = maxItemsCount;
			_itemHeight = itemDelta;
			_slotHeight = slotHeight;
			_deltaOffset = (_itemHeight - itemHeight) * 0.5;
		}
		
		public function addSlotItem(obj:SlotItem):void {
			obj.y = this.numChildren * _itemHeight + _deltaOffset;
			obj.index = this.numChildren;
			this.addChild(obj);
			_lastIndex = numChildren;
			_slotItems.push(obj);
			//DebugUtils.addDebugMarkerToLayer(_index, 0xff0000);
		}
		
		public function addPredefinedSlotItems(obj:SlotItem):void 
		{
			obj.y = this.numChildren * _itemHeight + _deltaOffset;
			obj.index = this.numChildren;
			this.addChild(obj);
			_lastIndex = numChildren;
			_predefinedItems.push(obj);
			_slotItems.push(obj);
			//DebugUtils.addDebugMarkerToLayer(_index, 0x00ff00);
		}
		
		public function clearPredefinedItems():void {
			
		}
		
		/**
		 * It's not the best shuffle but it's works for now
		 * I know better way, and improve this in the future
		 */
		public function shuffle(from:uint = 0):void 
		{
			var range:uint = numChildren - from;
			var randomNum:uint;
			if (range < 2) return;
			_counter = numChildren-1;
			while (_counter > from) {
				randomNum = from + Math.floor(Math.random() * range);
				if (randomNum == _counter) continue;
				SwapPositionsAt(_counter--, randomNum);
			}
			_slotItems = _slotItems.sortOn("index");
		}
		
		public function spinRandom():void 
		{
			_counter = 0;
			const tweenTime: Number = _spinTime + (Math.random() * _spinTimeOffset * 2 - _spinTimeOffset);
			const tweenYPos:int = Math.floor((y - tweenTime * _speed) / _itemHeight) * _itemHeight;
			//trace("tweenTime" , tweenTime);
			Starling.juggler.tween(this, tweenTime > 0 ? tweenTime : _spinTime, { y: tweenYPos, transition:Transitions.EASE_OUT, onUpdate: Handler_SpinUpdate, onComplete: Handler_SpinComplete, onCompleteArgs:[false] } );
		}
		
		public function spinToPredefined(findPredefinedPosition:Boolean, spins:uint = 3):void 
		{
			_counter = 0;
			var endIndex:uint = Math.floor((y - spins * this.height) / _itemHeight);
			var tweenYPos:int = (endIndex + (findPredefinedPosition ? _predefinedItems.length - numChildren : 0)) * _itemHeight;
			const tweenTime:Number = Math.abs(tweenYPos) / _speed + Math.random() * _spinTimeOffset;
			//trace("tweenTime" , tweenTime);
			Starling.juggler.tween(this, tweenTime, { y: tweenYPos, transition:Transitions.EASE_OUT, onUpdate: Handler_SpinUpdate, onComplete: Handler_SpinComplete, onCompleteArgs:[true] } );
		}
		
		/**
		 * ********************************* PRIVATE METHODS ***************************************
		 */
		//==========================================================================================
		//=================================== HANDLES ==============================================
		//==========================================================================================
		private function Handler_SpinUpdate():void {
			if (_counter == numChildren) _counter = 0;
			while (_counter < numChildren) {
				_slotItem = this.getChildAt(_counter) as SlotItem;
				_localPoint.y = _slotItem.y;
				this.localToGlobal(_localPoint, _globalPoint);
				
				//DebugUtils.moveDebugMarker(_index, _counter, _globalPoint);
				
				if (_globalPoint.y < _swapPosition) {
					_slotItem.y = _lastIndex * _itemHeight + _deltaOffset;
					_lastIndex++;
					break;
				}
				_counter++;
			}
		}
		
		private function Handler_SpinComplete(predefinedSpin:Boolean = false):void {
			_counter = _slotItems.length;
			var slotIndex:uint = 0;
			while (_counter--) 
			{
				_slotItem 		= _slotItems[_counter] as SlotItem;
				_localPoint.y 	= _slotItem.y;
				
				this.localToGlobal(_localPoint, _globalPoint);
				
				slotIndex 		= Math.floor(_globalPoint.y / _itemHeight);
				_slotItem.index = slotIndex;
				_slotItem.y 	= slotIndex * _itemHeight + _deltaOffset;
				
				if(predefinedSpin) this.setChildIndex(_slotItem, slotIndex);
			}
			if(predefinedSpin) _slotItems = _slotItems.sortOn("index");
			this.y = 0;
			
			//Clear unnesessary items
			while (_predefinedItems.length) {
				_slotItem = _predefinedItems.shift();
				_slotItem.predefined = false;
				(_slotItems.pop() as SlotItem).removeFromParent(true);
			}
			
			//if(predefinedSpin) shuffle(_itemsCount);
			
			_lastIndex = numChildren;
			
			this.dispatchEventWith(SPIN_COMPLETE, true, _index);
		}
		
		private function Handler_AddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, Handler_AddedToStage);
			_swapPosition = -(_itemHeight + _deltaOffset);
		}
		
		//==========================================================================================
		//=================================== UTILS ==============================================
		//==========================================================================================
		private function SwapPositionsAt(index1:uint, index2:uint):void
		{
			const mcA:SlotItem = this.getChildAt(index1) as SlotItem;
			const mcB:SlotItem = this.getChildAt(index2) as SlotItem;
			const xpos:uint = mcA.x;
			const ypos:uint = mcA.y;
			mcA.x = mcB.x;
			mcA.y = mcB.y;

			mcB.x = xpos;
			mcB.y = ypos;
			
			mcA.index = index2;
			mcB.index = index1;
			
			//if(index1 < index2) {
				//_slotItems.insertAt(index1, mcB);
				//_slotItems.insertAt(index2, mcA);
			//} else {
				//_slotItems.insertAt(index2, mcA);
				//_slotItems.insertAt(index1, mcB);
			//}
		}
	}
}