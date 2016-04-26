package com.game.buddle
{
	public class BuddlePool
	{
		private var list:Vector.<Buddle> = new Vector.<Buddle>;
		private static var instance:BuddlePool;
		public function BuddlePool()
		{
		}
		
		public static function getIns():BuddlePool{
			if(instance==null){
				instance = new BuddlePool();
			}
			return instance;
		}
		
		public function getNew():Buddle{
			if(list.length>0){
				var b:Buddle = list.pop();
				return b;
			}else{
				b = new Buddle();
				return b;
			}
		}
		
		public function restore(b:Buddle):void{
			list.push(b);
		}
	}
}