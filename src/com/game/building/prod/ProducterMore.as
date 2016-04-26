package com.game.building.prod
{
	import com.game.unit.PlaneMore;

	public class ProducterMore extends Producter1
	{
		public function ProducterMore()
		{
			super();
		}
		
		override protected function setMaxCount():void{
			maxCountArray = [1,1,1,1,1]
		}
		
		override protected function setTickCount():void{
			tickCountArray = [2000,2000,2000,2000,2000];
		}
		
		override protected function createPlane():void{
			currentPlane = new PlaneMore();
		}
		
		override protected function get type():String{
			return Factory.P5;
		}
	}
}