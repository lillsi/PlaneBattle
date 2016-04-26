package core.timeline
{
	internal interface ILoop
	{
		/**
		 *开始时间 
		 */		
		function get startTimer():Number;
		function set startTimer(value:Number):void;
		/**
		 *是否可以做 
		 * @param currentTimer
		 */
		function canIt(currentTimer:Number):Boolean;
		/**
		 *开始做 
		 * @param currentTimer
		 */
		function thingsToDo(currentTimer:Number):void;
		/**
		 *时间间隔
		 * @return
		 */		
		function get interval():Number;
		function set interval(value:Number):void;
		/**
		 *是否正在运行
		 */
		function get runing():Boolean;
	}
}