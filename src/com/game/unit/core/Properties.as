package com.game.unit.core
{
	import core.unit.base.IProperties;
	
	public class Properties implements IProperties
	{
		private var _hp:int;
		private var _hpMax:int;
		private var _attack:int;
		private var _canRestore:Boolean = false;
		public function Properties()
		{
		}
		
		public function get hp():int
		{
			return _hp;
		}
		
		public function set hp(value:int):void
		{
			_hp = Math.min(value,_hpMax);
		}
		
		public function get attack():int
		{
			return _attack;
		}
		
		public function set attack(value:int):void
		{
			_attack = value;
		}
		
		public function get hpMax():int
		{
			return _hpMax;
		}
		
		public function set hpMax(value:int):void
		{
			_hpMax = value;
		}
		
		public function get isProtected():Boolean
		{
			return _canRestore;
		}
		
		public function set isProtected(value:Boolean):void
		{
			_canRestore = value;
		}
		
	}
}