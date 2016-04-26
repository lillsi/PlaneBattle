package com.game.unit.core
{
	import core.unit.behavior.IFindable;
	import core.unit.behavior.IUnit;
	
	/**
	 * 范围寻敌，剔除保护状态的单位 
	 */	
	public class Finder2 extends Finder
	{
		public function Finder2(unit:IFindable)
		{
			super(unit);
		}
		
		override protected function typeFix(unit:IUnit):Boolean{
			return super.typeFix(unit) && !unit.isProtected;
		}
	}
}