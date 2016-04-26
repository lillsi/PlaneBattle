package com.game.buddle
{
	public class AddEffect extends PowerEffect
	{
		public function AddEffect()
		{
			super();
		}
		
		override public function get affactValue():int{
			return -_affectValue;
		}
	}
}