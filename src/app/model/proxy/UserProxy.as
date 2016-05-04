package app.model.proxy 
{
	import app.model.vo.UserVO;
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ...
	 * @author Vladimir Minkin
	 */
	public final class UserProxy extends Proxy 
	{
		static public const NAME:String = "UserProxy";
		
		static private var USER_INITIALIZED:String = "user_initialized";
		
		public function UserProxy() 
		{
			super(NAME, RetrieveUser());
		}
		
		override public function onRegister():void {
		}
		
		/**
		 * Save current user to local storage
		 */
		public function saveUser(user:UserVO):void {
			var byteArray:ByteArray;
			ProcessEveryParameterInObject(function(variable:String, type:String):void {
				byteArray = new ByteArray();
				SetValueToByteArrayByType(byteArray, user[variable], type);
			}, user);
			if(byteArray) byteArray.clear();
			byteArray = null;
		}
		
		public function get userGamesPlayed():uint { return user.gamesPlayed; }
		public function set userGamesPlayed(value:uint):void { user.gamesPlayed = value; StoreUserParam("gamesPlayed", value); }
		public function get userScore():uint { return user.score; }
		public function set userScore(value:uint):void { user.score = value; StoreUserParam("score", value); }
		
		private function RetrieveUser():UserVO {
			if (EncryptedLocalStore.isSupported) {
				return GetUserFromLocalStore();
			} else {
				// Other wy to get user
				return new UserVO();
			}
		}
		
		/**
		 * Need to be moved in special service
		 */
		private function StoreUserParam(key:String, value:*):void {
			const byteArray:ByteArray = new ByteArray();
			SetValueToByteArrayByType(byteArray, value);
			EncryptedLocalStore.setItem(key, byteArray);
		}
		 
		private function GetUserFromLocalStore():UserVO {
			const user:UserVO = new UserVO();
			var byteArray:ByteArray;
			if (EncryptedLocalStore.getItem(USER_INITIALIZED) != null) {
				ProcessEveryParameterInObject(function(variable:String, type:String):void {
					byteArray = EncryptedLocalStore.getItem(variable);
					if (byteArray != null)	{
						user[variable] = GetValueFromByteArrayByType(byteArray, type);
						trace(variable, type, user[variable]);
					}
				}, user);
			} else {
				byteArray = new ByteArray();
				byteArray.writeBoolean(true);
				EncryptedLocalStore.setItem(USER_INITIALIZED, byteArray);
				saveUser(user);
			}
			if(byteArray) byteArray.clear();
			byteArray = null;
			return user;
		}
		
		private function ProcessEveryParameterInObject(process:Function, object:Object):void {
			const decription	: XML = describeType(object);
			const variablesList	: XMLList = decription..variable as XMLList;
			var variableXML		: XML;
			if(variablesList.length() > 0) {
				for each (variableXML in variablesList) {
					process.call(null, String(variableXML.@name), String(variableXML.@type));
				}
			}
		}
		 
		private function GetValueFromByteArrayByType(ba:ByteArray, type:String):* {
			switch (type) 
			{
				case "int": 	return int(ba.readInt());
				case "uint": 	return uint(ba.readUnsignedInt());	
				case "string": 	return String(ba.readUTF());
				case "number": 	return Number(ba.readFloat());
			}
		}
		
		private function SetValueToByteArrayByType(ba:ByteArray, value:*, type:String = null):void {
			type = type || getQualifiedClassName(value);
			switch (type) 
			{
				case "int": 	ba.writeInt(int(value)); break;
				case "uint": 	ba.writeUnsignedInt(uint(value)); break;	
				case "string": 	ba.writeUTF(String(value)); break;
				case "number": 	ba.writeFloat(Number(value)); break;
			}
		}
		/**
		 * ***************************************************************************************
		 */
		
		private function get user():UserVO { return UserVO(data); }
	}
}