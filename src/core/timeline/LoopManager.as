package core.timeline
{
	import flash.events.Event;
	import flash.utils.getTimer;
	
	
	public class LoopManager
	{
		private static var _track:ITrack;
		private static var loops:Vector.<ILoop>=new Vector.<ILoop>();
		public function LoopManager()
		{
		}
		/**
		 *添加
		 * @param value
		 */		
		public static function addLoop(value:ILoop):void{
			if(track==null){
				track=getDefaultTrack();
			}
			var index:int=loops.indexOf(value);
			if(index>=0){
				return;
			}
			value.startTimer=Timeline.pulse();
			loops.push(value);
			if(track.running==false){
				track.start();
			}
		}
		protected static function trackloop(e:Event):void
		{
			var currentTimer:int=Timeline.pulse();
//			var mstart:int=getTimer();
			for(var i:int=0;i<loops.length;i++) 
			{
				var loop:ILoop = loops[i];
				if(loop.canIt(currentTimer)){
//					var start:int = getTimer();
					loop.thingsToDo(currentTimer);
//					var end:int = getTimer();
//					if(end - start > 20){
//						trace("loop cost:",end - start,"index:",i);
//					}
				}
			}
//			var mend:int=getTimer();
//			if(mend - mstart > 50){
//				trace("all loop cost:",mend - mstart,"index:",i);
//			}
		}
		/**
		 *删除 
		 * @param value
		 */		
		public static function removeLoop(value:ILoop):void{
			var index:int=loops.indexOf(value);
			if(index<0){
				return;
			}
			loops.splice(index,1);
			checkLength();
		}
		/**
		 *检测时间轨道
		 * 如果没有需要计算的就停止计时器 
		 */		
		protected static function checkLength():void{
			if(loops.length==0){
				track.stop();
			}
		}
		static protected function getDefaultTrack():ITrack{
			return new TimerTrack(1000/60);
		}
		public static function get track():ITrack
		{
			return _track;
		}
		public static function set track(value:ITrack):void
		{
			if(_track == value){
				return;
			}
			if(_track){
				track.removeEventListener(Event.CHANGE,trackloop);
			}
			_track=value;
			_track.addEventListener(Event.CHANGE,trackloop);
		}
	}
}