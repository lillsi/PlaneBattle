package com.component.print
{
	import com.Track;
	import com.component.gt.TextGame;
	
	import core.procedure.IProcedure;
	
	import starling.display.Sprite;
	
	public class Printer extends Sprite implements IProcedure
	{
		private var textVecter:Vector.<PrinterText>;
		private var top:PrinterText;
		private var targetY:Number = 450;
		private var startY:Number = 600;
		public function Printer()
		{
			super();
			textVecter = new Vector.<PrinterText>;
		}
		
		public function add(str:String):void{
			if(textVecter.length>5){
				removeAll();
			}
			
			var text:PrinterText = new PrinterText(str,200,40);
			text.x = Game.STAGE_WIDTH >> 1;
			text.y = startY;
			text.targetY = targetY + textVecter.length * 25;
			addChild(text);
			textVecter.push(text);
		}
		
		public function removeAll():void{
			textVecter = new Vector.<PrinterText>;
			removeChildren();
		}
		
		private var prevTick:int = -1;
		private var perTick:int = 20;
		public function renderTick(tick:int):void
		{
//			if(prevTick == -1){
//				prevTick = tick;
//			}else{
//				if(tick-prevTick > 20){
//					var count:int = (tick - prevTick)/perTick;
//					prevTick += count * perTick;
//				}
//			}
			
			for(var i:int=0;i<textVecter.length;i++){
				var text:PrinterText = textVecter[i];
				text.renderText(tick);
				
				if(text.remove){
					this.removeChild(text);
					textVecter.splice(i,1);
					i--;
				}
			}
			
			for(i=0;i<textVecter.length;i++){
				textVecter[i].targetY = targetY + i * 25;
			}
		}
		
		public function get track():Track
		{
			return UnitManager.getInstance().track;
		}
		
		public function update():void
		{
			removeAll();
			UnitManager.getInstance().track.add(this);
		}
	}
}