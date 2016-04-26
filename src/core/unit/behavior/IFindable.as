package core.unit.behavior
{
	import flash.geom.Point;

	public interface IFindable extends IPosition, ITeamate
	{
		function set range(value:int):void;
		function get range():int;
		function find(r:int=0):Vector.<IUnit>;
		
		function gridPostion(range:int):Point;
		function gridChangeFlag():void;
	}
}