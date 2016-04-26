package core.pool
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 *对象池 
	 */
	public class ObjectPool
	{
		private static var newNumber:Dictionary=new Dictionary();
		private static var content:Dictionary=new Dictionary();
		public function ObjectPool()
		{
			
		}
		/**
		 *获取对象实例 
		 * @param value
		 * @return
		 */		
		static public function getInstance(value:Class):*{
			var className:String=getQualifiedClassName(value);
			var arr:Array=content[className];
			if(arr&&arr.length){
				return content[className].pop();
			}
			if(newNumber[className]==null){
				newNumber[className]=1;
			}else{
				newNumber[className]+=1;
			}
			return new value();
		}
		/**
		 *回收对象实例 
		 * @param value
		 * 
		 */		
		static public function reclaim(value:IPoolObject):void{
			var className:String=getQualifiedClassName(value);
			var arr:Array=content[className];
			if(arr==null){
				arr=content[className]=[];
			}
			var index:int=arr.indexOf(value);
			if(index>=0){
				return;
			}
			value.reclaim();
			arr.push(value);
		}
		/**
		 *删除某一个类型的池 
		 * @param valueaidu
		 */		
		static public function removeClassPool(value:Class):void{
			var className:String=getQualifiedClassName(value);
			var arr:Array=content[className];
			if(arr&&arr.length>0){
				arr.length=0;
			}
			delete content[className];
		}
		/**
		 *某个类型状态
		 * @param value
		 * @return
		 */		
		static public function getInstanceState(value:Class):void{
			var className:String=getQualifiedClassName(value);
			var arr:Array=content[className];
			var poolNumber:uint;
			var newNum:uint;
			if(arr&&arr.length){
				poolNumber=content[className].length;
			}
			 trace(className+':池中的数量为'+poolNumber+'个。');
			if(newNumber[className]){
				newNum=newNumber[className];
			}
			trace(className+':new过'+newNum+'个');
		}
	}
}