package com.game.unit.core
{
	import core.unit.behavior.IFindable;
	import core.unit.behavior.IPosition;
	import core.unit.behavior.ITeamate;
	import core.unit.behavior.IUnit;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public class GridPos
	{
		private var _unit:IPosition;
		private var _gridPosition:Array;
		private var _isUpdated:Boolean=false;
		
		public function GridPos(unit:IPosition)
		{
			_gridPosition = [];
			_unit = unit;
		}
		
		public function gridPostion(range:int):Point
		{
			if(_isUpdated){
				_gridPosition = [];
				_isUpdated = false;
			}
			if(_gridPosition[range]==null){
				var point:Point = new Point(int(_unit.x/range),int(_unit.y/range));
				_gridPosition[range] = point;
			}
			return _gridPosition[range];
		}
		
		public function gridChangeFlag():void{
			_isUpdated = true;
		}
		
//		public function get teamId():int{
//			return _unit.teamId;
//		}
//		
		public function get x():Number{
			return _unit.x;
		}
		
		public function get y():Number{
			return _unit.y;
		}
		
//		public function defence(iaffact:IAffact):void{
//			
//		}
	}
}