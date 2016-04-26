package core.procedure
{
	import com.Track;

	public interface IProcedure
	{
		function get track():Track;
		function renderTick(tick:int):void;
	}
}