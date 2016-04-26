package com.component
{
	import com.component.gt.TextGame;
	
	import starling.display.Canvas;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Panel extends Sprite
	{
		private var func:Function;
		private var params:Array;
		
		private var text:TextGame;
		
		public function Panel(isCenter:Boolean=true)
		{
			super();
			if(isCenter){
				x = Game.STAGE_WIDTH>>1;
				y = Game.STAGE_HEIGHT>>1;
			}
			setBG();
			addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		protected function setBG():void{
			var canvas:Canvas = new Canvas();
			canvas.beginFill(0x006622);
			canvas.drawRectangle(0,0,350,200);
			canvas.endFill();
			addChild(canvas);
			
			this.pivotX = canvas.width>>1;
			this.pivotY = canvas.height>>1;
			
			this.x = Game.STAGE_WIDTH>>1;
			this.y = Game.STAGE_HEIGHT>>1;
			
		}
		
		public function show(str:String,func:Function=null,params:Array=null):void{
			this.func = func;
			this.params = params;
			
			text = new TextGame(str);
			text.width = 350;
			text.height = 200;
			text.pivotX = text.width>>1;
			text.pivotY = text.height>>1;
			text.x = this.pivotX;
			text.y = this.pivotY;
			addChild(text);
		}
		
		protected function close():void{
			this.parent.removeChild(this);
			
			if(func!=null && params!=null){
				func.apply(null,params);
			}else if(func!=null){
				func.apply();
			}
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this,TouchPhase.ENDED);
			if(touch){
				removeEventListener(TouchEvent.TOUCH,onTouch);
				close();
			}
		}
	}
}