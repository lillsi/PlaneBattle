package core.unit.behavior
{
	public interface ITeamate
	{
		function get teamId():int;
		function set teamId(value:int):void;
		
		function isEnermy(id:int):Boolean;
	}
}