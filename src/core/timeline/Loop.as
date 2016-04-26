package core.timeline
{
	public class Loop implements ILoop
	{
		private var _startTimer:Number=0;        //开始时间
		private var _lastTimer:Number=0;     //上一次调用的时间点
		private var _interval:Number=0;
		private var target:IAct;
		public function Loop(target:IAct)
		{
			this.target=target;
		}
		public function start():void{
			_runing=true;
			LoopManager.addLoop(this);
		}
		public function stop():void{
			_runing=false;
			LoopManager.removeLoop(this);
		}
		public function set startTimer(value:Number):void
		{
			_startTimer=value;
			_lastTimer=value;
		}
		public function get startTimer():Number
		{
			return _startTimer;
		}
		public function canIt(currentTimer:Number):Boolean
		{
			if(currentTimer-_lastTimer>=_interval){
				return true;
			}
			return false;
		}
		public function thingsToDo(currentTimer:Number):void
		{
			_lastTimer=currentTimer;
			target.act(currentTimer);
		}
		public function get interval():Number
		{
			return _interval;
		}
		public function set interval(value:Number):void
		{
			_interval=value;
		}
		private var _runing:Boolean;
		public function get runing():Boolean
		{
			return _runing;
		}
	}
}