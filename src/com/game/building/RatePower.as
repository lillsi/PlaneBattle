package com.game.building
{
	import com.component.hpbar.HpBar;
	import com.game.unit.core.RateBehavior;
	
	import core.unit.base.IProperties;
	
	public class RatePower extends RateBehavior
	{
		protected var ip:IProperties;
		protected var update:Function;
		public function RatePower(ip:IProperties,rate:int,update:Function)
		{
			super();
			this.ip = ip;
			this.rate = rate;
			this.update = update;
		}
		
		override public function rateRender(tick:int):void{
			super.rateRender(tick);
		}
		
		override protected function set count(value:int):void{
			super.count = value;
			update(percent,0x0000ff);
		}
		
		public function halfCool():void{
			count = _rate/2;
		}
		
		public function allCool():void{
			count = _rate;
		}
		
		public function restore(value:int):Boolean{
			count += value;
			return _count >= _rate;
		}
	}
}