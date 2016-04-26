package com.game.unit.core
{
	import core.unit.behavior.IFindable;
	import core.unit.behavior.IUnit;
	
	public class FinderMate extends Finder
	{
		public function FinderMate(unit:IFindable)
		{
			super(unit);
		}
		
		override protected function typeFix(unit:IUnit):Boolean{
			return !_ifindable.isEnermy(unit.teamId);
		}
	}
}