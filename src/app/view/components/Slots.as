package app.view.components 
{
	import app.view.components.slots.SlotItem;
	import app.view.components.slots.SlotSpinner;
	import consts.assets.SlotItemsAssets;
	import consts.entities.SlotItems;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import starling.display.QuadBatch;
	import utils.DisplayUtils;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public final class Slots extends Sprite 
	{
		static private const
			sf:Number = Application.SCALEFACTOR
		
		,	HEADER_Y_OFFSET		: uint = 48 * sf
		,	SLOTS_DELTA_X		: uint = 32 * sf
		;
		
		private const 
			_assets				:SlotItemsAssets = SlotItemsAssets.getInstance()
		,	_slotTexture		:Texture = _assets.getTextureByType(SlotItems.BACKGROUND)
		,	_slotsBackground	:Sprite = new Sprite()
		;
		
		private const _slotContainers	:Vector.<Sprite> 		= new Vector.<Sprite>();
		private const _slotsSpinners	:Vector.<SlotSpinner> 	= new Vector.<SlotSpinner>();
		
		public function Slots() {
			super();
			this.addChild(_slotsBackground);
		}
		
		public function init(slotsCount:uint, slotItemsCount:uint, maxSlotItemsCount:uint):void 
		{
			const slotXOffset	:uint = _slotTexture.width + SLOTS_DELTA_X;
			
			const slotWidth		:uint = _slotTexture.width
			const slotHeight	:uint = _slotTexture.height
			const slotsDelta	:uint = slotHeight / slotItemsCount;
			
			const emptySlotItemTexture	:Texture = _assets.getTextureByType(SlotItems.EMPTY);
			const slotItemWidth			:uint = emptySlotItemTexture.width;
			const slotItemHeight		:uint = emptySlotItemTexture.height;
			const slotScrollerXPos		:uint = ( slotWidth - slotItemWidth ) * 0.5;
			
			const maskOffset			:uint = 3 * sf;
			const maskDoubleOffset		:uint = maskOffset * 2;
			const mask					:Rectangle = new Rectangle(maskOffset, maskOffset, slotWidth-maskDoubleOffset, slotHeight-maskDoubleOffset);
			
			var slotXPos:uint = 0;
			var slotBackImage:Image, slotContainer:Sprite, slotSpinner:SlotSpinner;
			for (var i:int = 0; i < slotsCount; i++) 
			{
				slotXPos = i * slotXOffset;
				
				slotBackImage = new Image(_slotTexture);
				slotBackImage.x = slotXPos;
				_slotsBackground.addChild(slotBackImage);
				
				slotContainer = new Sprite();
				slotContainer.x = slotXPos;
				slotContainer.clipRect = mask;
				_slotContainers.push(slotContainer);
				this.addChild(slotContainer);
				
				slotSpinner = new SlotSpinner(i, maxSlotItemsCount, slotHeight, slotsDelta, slotItemHeight);
				slotSpinner.x = slotScrollerXPos;
				_slotsSpinners.push(slotSpinner);
				slotContainer.addChild(slotSpinner);
			}
			
			_slotsBackground.flatten();
			
			this.x = (Application.SCREEN_WIDTH - slotXOffset * slotsCount) * 0.5;
			this.y = Header.HEADER_HEIGHT + HEADER_Y_OFFSET;
		}
		
		public function reset():void {
			AllSpinners(function(spinner:SlotSpinner):void {
				spinner.removeFromParent(true); 
			})
		}
		
		public function appendSlotItem(type:String):void {
			trace(type);
			const itemTexture:Texture = _assets.getTextureByType(type);
			AllSpinners(function(spinner:SlotSpinner):void {
				if (spinner.numChildren < spinner.maxItemsCount) {
					spinner.addSlotItem(new SlotItem(type, itemTexture));
				}
			})
		}
		
		/**
		 * This method fill slot with items till count equal maxItemsCount
		 */
		public function fillSlotsWithItemsIfNeeded():void {
			var itemType:String;
			var itemTexture:Texture;
			AllSpinners(function(spinner:SlotSpinner):void {
				while (spinner.numChildren < spinner.maxItemsCount) {
					itemType = _assets.getRandomSlotItemType();
					itemTexture = _assets.getTextureByType(itemType);
					spinner.addSlotItem(new SlotItem(itemType, itemTexture));
				}
			});
		}
		
		public function shuffle():void {
			AllSpinners(function(spinner:SlotSpinner):void {
				spinner.shuffle(); 
			})
		}
		
		public function setupSpeed(value:uint):void {
			AllSpinners(function(spinner:SlotSpinner):void {
				spinner.speed = value; 
			})
		}
		
		public function spin():void {
			AllSpinners(function(spinner:SlotSpinner):void {
				spinner.spinRandom(); 
			})
		}
		
		public function setupSpinTime(value:uint):void {
			AllSpinners(function(spinner:SlotSpinner):void {
				spinner.spinTime = value; 
			})
		}
		
		public function setupSpinTimeOffset(value:uint):void {
			AllSpinners(function(spinner:SlotSpinner):void {
				spinner.spinTimeOffset = value; 
			})
		}
		
		public function setupPredefineResult(results:Array):void {
			var predefinedItemsForSpinner:Array;
			var itemTexture:Texture;
			var itemType:String;
			var item:SlotItem;
			AllSpinners(function(spinner:SlotSpinner):void {
				predefinedItemsForSpinner = results[spinner.index];
				for each (itemType in predefinedItemsForSpinner) {
					if (itemType.length == 0) {
						itemType = _assets.getRandomSlotItemType();
					}
					itemTexture = _assets.getTextureByType(itemType);
					item = new SlotItem(itemType, itemTexture, true);
					spinner.addPredefinedSlotItems(item);
				}
			});
		}
		
		public function spinToResults(findPredefinedPosition:Boolean):void {
			const spins:Array = new Array(_slotsSpinners.length);
			spins.forEach(function(item:*, index:int, arr:Array):void { arr[index] = index + 3 } );
			AllSpinners(function(spinner:SlotSpinner):void {
				spinner.spinToPredefined(findPredefinedPosition, spins[Math.floor(Math.random()*spins.length)]); 
			})
		}
		
		private function AllSpinners(process:Function):void {
			for each (var spinner:SlotSpinner in _slotsSpinners) {
				process.call(null, spinner);
			}
		}
	}
}