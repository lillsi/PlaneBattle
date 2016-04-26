package com.game.building.prod
{
	import com.game.unit.PlaneMore;
	import com.game.unit.PlaneRush;

	public class ProducterRush extends Producter1
	{
		public function ProducterRush()
		{
			super();
		}
		
		override protected function setMaxCount():void{
			maxCountArray = [3,3,3,3,3]
		}
		
		override protected function setTickCount():void{
			tickCountArray = [2000,2000,2000,2000,2000];
		}
		
		override protected function createPlane():void{
			currentPlane = new PlaneRush();
		}
		
		override protected function get type():String{
			return Factory.P4;
		}
	}
}