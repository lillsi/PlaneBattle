package core.unit.behavior
{
	public interface IRateabel
	{
		function set rate(value:int):void;
		function get rate():int;
		function rateRender(tick:int):void;
		function isCool():Boolean;
		function coolDown():void;
		function resetTick(tick:int=-1):void;
		function get percent():Number;
	}
}