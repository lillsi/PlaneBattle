package com.game.building.prod
{
	import com.game.unit.Plane2;

	public class Producter2 extends Producter1
	{
		public function Producter2()
		{
			super();
		}
		
		override protected function createPlane():void{
			currentPlane = new Plane2();
		}
		
		override protected function setMaxCount():void{
			maxCountArray = [1,1,2,2,2];
		}
		
//		override protected function setPrice():void{
//			priceArray = [200,300,350,400];
//		}
		
		override protected function get type():String{
			return Factory.P2;
		}
	}
}