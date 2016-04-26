package com.scene
{
	import com.component.gt.TextGame;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class StartScene extends Scene
	{
		public function StartScene()
		{
			super();
			
			var text:TextGame = new TextGame("开始");
			addChild(text);
			text.x = Game.STAGE_WIDTH>>1;
			text.y = Game.STAGE_HEIGHT/3;
			text.index = 0;
			text.name = "start";
			
			var text2:TextGame = new TextGame("升级");
			addChild(text2);
			text2.index = 1;
			text2.x = Game.STAGE_WIDTH>>1;
			text2.y = Game.STAGE_HEIGHT/3 + 50;
			text2.name = "research";
			
			this.addEventListener(TouchEvent.TOUCH,onTouch);
			this.addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		private function onAdd(e:Event):void
		{
			Automic.autoStart(this);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this,TouchPhase.ENDED);
			var text:TextGame = e.target as TextGame;
			if(touch!=null && text){
				remove();
				var scene:Scene;
				switch(text.index){
					case 0:
						scene = new SelectScene();
						break;
					case 1:
						scene = new ResearchScene();
						break;
				}
				UnitManager.getInstance().sceneSprite.addChild(scene);
			}
		}
		
		public function remove():void{
			this.parent.removeChild(this);
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdd);
			this.removeEventListener(TouchEvent.TOUCH,onTouch);
		}
	}
}