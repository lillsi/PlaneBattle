package com.game.unit
{
	import com.game.buddle.Buddle;
	import com.game.buddle.PowerEffect;
	import com.game.unit.core.Finder;
	
	import flash.filters.GlowFilter;
	
	import core.unit.behavior.IUnit;

	public class Plane1 extends Plane
	{
		public function Plane1(teamId:int=1)
		{
			super(teamId);
			maxSpeed = 5;
		}
	}
}