package consts.assets 
{
	import consts.entities.SlotItems;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import utils.DisplayUtils;
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public final class SlotItemsAssets 
	{
		static private const instance:SlotItemsAssets = new SlotItemsAssets();
		static public function getInstance():SlotItemsAssets { return instance; }
		public function SlotItemsAssets() { if (instance) throw new Error("Sorry this is singleton use getInstance() instead."); }
		
		private const _assets:Dictionary = new Dictionary();
		
		public function init(sf:Number):void 
		{
			_assets[SlotItems.BACKGROUND] 	= DisplayUtils.textureFromClass(	SlotBackgroundGraphic, sf);
			_assets[SlotItems.BELL] 		= DisplayUtils.textureFromClass(	SlotItemBell, 	sf);
			_assets[SlotItems.APPLE] 		= DisplayUtils.textureFromClass(	SlotItemApple, 	sf);
			_assets[SlotItems.LEMON] 		= DisplayUtils.textureFromClass(	SlotItemLemon, 	sf);
			_assets[SlotItems.BANANA] 		= DisplayUtils.textureFromClass(	SlotItemBanana, sf);
			_assets[SlotItems.CHERRY] 		= DisplayUtils.textureFromClass(	SlotItemCherry, sf);
			_assets[SlotItems.EMPTY] 		= DisplayUtils.textureFromClass(	SlotItemEmpty, 	sf);
		}
		
		public function getTextureByType(type:String):Texture {
			return _assets[type] || _assets[SlotItems.EMPTY];
		}
		
		public function getRandomTexture():Texture {
			return getTextureByType(getRandomSlotItemType());
		}
		
		public function getRandomSlotItemType():String {
			var arr:Array = [
				SlotItems.BELL, 
				SlotItems.APPLE, 
				SlotItems.LEMON,
				SlotItems.BANANA,
				SlotItems.CHERRY
			];
			const rnd:uint = Math.floor(Math.random() * arr.length);
			return arr[rnd];
		}
	}
}