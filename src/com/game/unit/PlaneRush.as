package com.game.unit
{
	import com.calculation.Vector2D;

	public class PlaneRush extends Plane
	{
		public function PlaneRush(teamId:int=1)
		{
			super(teamId);
		}
		
		override protected function get imageString():String{
			return "GodPlane";
		}
		
		override protected function get buddleString():String{
			return "missileblue/aa";
		}
		
		override protected function get boomString():String{
			return "wave_blue_hit_a/wave_blue_hit_a";
		}
	}
}