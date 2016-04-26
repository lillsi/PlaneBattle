package com
{
	import flash.utils.getTimer;
	
	import core.procedure.IProcedure;
	
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;

	public class Track
	{
		public static const TIME_PER_TICK:int = 25;
		private var current:int = 0;
		private var lastTime:int = 0;
		private var speed:int = 20;
		private var isStop:Boolean = true;
		public var procedureObject:Vector.<IProcedure> = new Vector.<IProcedure>;
		
		public function Track(main:Sprite)
		{
			main.addEventListener(EnterFrameEvent.ENTER_FRAME,onProcedure);
		}
		
		
		
		public function onProcedure(e:EnterFrameEvent):void{
			if(isStop) return;
			
			var time:int = getTimer();
			if(lastTime != 0){
				var past:int = time - lastTime;
				for(var i:int=0;i<speed;i++){
					current += past;
					update();
				}
			}
			lastTime = time;
		}
		
		private function update():void{
			for each(var p:IProcedure in procedureObject){
				p.renderTick(current);
			}
		}
		
		public function add(procedure:IProcedure):void{
			procedureObject.push(procedure);
		}
		
		public function remove(procedure:IProcedure):void{
			var index:int = procedureObject.indexOf(procedure);
			if(index!=-1){
				procedureObject.splice(index,1);
			}
		}
		
		public function clear():void{
			procedureObject.length = 0;
			procedureObject = new Vector.<IProcedure>;
		}
		
		public function stop():void{
			isStop = true;
		}
		
		public function start():void{
			isStop = false;
		}
		
		public function getCurrent():int{
			return current;
		}
		
		public function pluse():int{
			var tick:int = getTimer();
			var past:int = tick - lastTime;
			var temp:int = current + past;
			return temp;
		}
	}
}