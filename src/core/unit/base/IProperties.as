package core.unit.base
{
	public interface IProperties
	{
		function get hp():int;
		function set hp(value:int):void;
		
		function get hpMax():int;
		function set hpMax(value:int):void;
		
		function get attack():int;
		function set attack(value:int):void;
		
		function get isProtected():Boolean;
		function set isProtected(value:Boolean):void;
	}
}