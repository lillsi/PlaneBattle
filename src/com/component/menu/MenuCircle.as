package com.component.menu
{
	import core.procedure.IMenu;
	import core.timeline.IAct;
	import core.timeline.Loop;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	
	public class MenuCircle extends Sprite implements IAct
	{
		private var menus:Vector.<MenuIcon>;
		private var length:Number = 70;
		private var angle:Number = Math.PI/4;
		private var loop:Loop;
		
		public function MenuCircle()
		{
			super();
			
			menus=new Vector.<MenuIcon>;
			
			loop = new Loop(this);
			loop.interval = 20;
			
			for(var i:int=0;i<8;i++){
				var m:MenuIcon = new MenuIcon(this);
				m.visible = false;
				addChild(m);
				menus.push(m);
				
				var ang:Number = angle*(menus.length*2+int(menus.length/5)+6);
				m.x = length * Math.cos(ang);
				m.y = length * Math.sin(ang);
			}
			
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		
		protected function onAddToStage(event:Event):void
		{
//			this.stage.addEventListener(TouchEvent.TOUCH,onTouch);
//			this.stage.addEventListener(MouseEvent.CLICK,onClick,true,255);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this,TouchPhase.ENDED);
			if(touch){
				this.visible = false;
			}
		}
		
//		protected function onFocus(event:FocusEvent):void
//		{
//			if(contains(event.target as DisplayObject)){
//				this.visible = false;
//			}
//		}
		
//		protected function onClick(event:MouseEvent):void
//		{
////			if(!contains(event.target as DisplayObject)){
//				this.visible = false;
////			}
//		}
		
		public function act(current:Number):void
		{
			if(current - loop.startTimer > 200){
				this.scaleX = this.scaleY = 1;
				loop.stop();
			}else{
				this.scaleX = this.scaleY = (current - loop.startTimer)/200;
			}
		}
		
		public function focus(menu:IMenu,px:Number,py:Number):void
		{
			this.x = menu.x + px;
			this.y = menu.y + py;
			this.visible = true;
			
			var selections:Vector.<Selection> = menu.getSelection();
			for(var i:int=0;i<menus.length;i++){
				if(i<selections.length){
					menus[i].selection = selections[i];
				}else{
					menus[i].selection = null;
				}
			}
			
			loop.start();
			this.scaleX = this.scaleY = 0.1;
		}
		
		public function hide():void{
			for(var i:int=0;i<menus.length;i++){
				menus[i].selection = null;
			}
		}
	}
}