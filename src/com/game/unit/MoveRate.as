package com.game.unit
{
	import com.Track;
	import com.game.unit.core.RateBehavior;
	
	public class MoveRate extends RateBehavior
	{
		public function MoveRate()
		{
			super();
			
			rate = Track.TIME_PER_TICK;
		}
	}
}