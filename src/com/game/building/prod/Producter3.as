package com.game.building.prod
{
	import com.game.unit.Plane3;

	public class Producter3 extends Producter1
	{
		public function Producter3()
		{
			super();
		}
		
		override protected function setMaxCount():void{
			maxCountArray = [2,4,6,8,10]
		}
		
		override protected function setTickCount():void{
			tickCountArray = [1000,800,600,500,400];
		}
		
		override protected function createPlane():void{
			currentPlane = new Plane3();
		}
		
		override protected function get type():String{
			return Factory.P3;
		}
	}
}