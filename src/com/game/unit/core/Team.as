package com.game.unit.core
{
	import core.unit.behavior.ITeamate;
	
	public class Team implements ITeamate
	{
		private var _teamId:int;
		public function Team()
		{
		}
		
		public function isEnermy(id:int):Boolean{
			return !(_teamId & id);
		}
		
		public function get teamId():int
		{
			return _teamId;
		}
		
		public function set teamId(value:int):void{
			_teamId = value;
		}
	}
}