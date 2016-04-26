package com.component.print
{
	import com.component.gt.TextGame;
	
	public class PrinterText extends TextGame
	{
		public var remove:Boolean = false;
		public var targetY:int;
		private var stayTime:int = 2000;
		public function PrinterText(text:String="", width:int=80, height:int=40)
		{
			super(text, width, height);
		}
		
		private var stopTick:int = -1;
		public function renderText(tick:int):void{
			if(y == targetY){
				if(tick - stopTick < stayTime){
					alpha = (stayTime - (tick - stopTick))/stayTime;
				}else{
					remove = true;
				}
			}
			else if(y - targetY < 10){
					y = targetY;
					if(stopTick == -1){
						stopTick = tick;
					}
				}
			else{
				y += (targetY - y)/2;
			}
		}
	}
}