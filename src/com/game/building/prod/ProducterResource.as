package com.game.building.prod
{
	import com.game.unit.PlaneResource;

	public class ProducterResource extends Producter1
	{
		public function ProducterResource()
		{
			super();
		}
		
		override protected function createPlane():void{
			currentPlane = new PlaneResource(this,buildingLevel>=1);
		}
		
		override protected function get type():String{
			return Factory.P6;
		}
	}
}