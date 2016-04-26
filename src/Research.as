package
{
	public class Research
	{
		public var attack_raise:Number=0;
		public var hp_raise:Number=0;
		
		public static const RESEARCH_1:int = 0;//机体
		public static const RESEARCH_2:int = 1;//火炮
		public static const RESEARCH_3:int = 2;//护盾
		public static const RESEARCH_4:int = 3;//量产
		public static const RESEARCH_5:int = 4;//能耗
		
		private var researchData:Vector.<int>;
		
		private static var instance:Research;
		public function Research()
		{
			reset();
		}
		
		public static function getInstance():Research{
			if(instance == null){
				instance = new Research();
			}
			return instance;
		}
		
		public function getLevel(type:int):int{
			return researchData[type];
		}
		
		public function levelUp(type:int):void{
			if(left > 0){
				researchData[type]++;
			}
		}
		
		public function reset():void{
			researchData = new Vector.<int>;
			researchData.push(0,0,0,0,0);
		}
		
		public function get left():int{
			return UnitManager.getInstance().getAllStar() - cost;
		}
		
		private function get cost():int{
			var count:int=0;
			for(var i:int=0;i<researchData.length;i++){
				count += researchData[i];
			}
			return count;
		}
		
		public function valueChange(type:int,value:int=0):int{
			switch(type){
				case RESEARCH_1:
					return researchData[type];
				case RESEARCH_2:
					return value * (1+researchData[type]*0.05);
				case RESEARCH_3:
					return value * (1+researchData[type]*0.05);
				case RESEARCH_4:
					return value * (1-researchData[type]*0.05);
				case RESEARCH_5:
					return value * (1-researchData[type]*0.05);
				default:
					throw new Error("unknow type");
			}
			return 0;
		}
	}
}