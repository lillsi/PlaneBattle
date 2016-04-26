package
{
	public class BatteryData
	{
		public var range:int;
		public var rate:int;
		public var attack:int;
		public var hpMax:int;
		public var drop:int;
		public var buddle:int;
		
		public var x:Number;
		public var y:Number;
		
		public function BatteryData(x:Number,y:Number,range:int,rate:int,
									attack:int,hpMax:int,drop:int,buddle:int)
		{
			this.x = x;
			this.y = y;
			
			this.attack = attack;
			this.rate = rate;
			this.range = range;
			this.hpMax = hpMax;
			this.drop = drop;
			this.buddle = buddle;
//			range = range;
//			rate = rate;
//			attack = attack;
//			hpMax = hpMax;
//			buddle = buddle;
		}
	}
}