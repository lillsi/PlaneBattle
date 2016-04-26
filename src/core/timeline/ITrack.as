package core.timeline
{
	import flash.events.IEventDispatcher;
	
	public interface ITrack extends IEventDispatcher
	{
		/**
		 *开始
		 */		
		function start():void;
		/**
		 *是否正在运行 
		 * @return
		 */		
		function get running():Boolean;
		/**
		 *停止
		 */		
		function stop():void;
		/**
		 *描述 
		 * @return
		 */		
		function get bewrite():String;
	}
}