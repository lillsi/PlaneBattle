package com.scene
{
	import com.component.gt.TextGame;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class SelectScene extends Scene
	{
		private var menuText:Vector.<TextGame> = new Vector.<TextGame>;
		
		public function SelectScene()
		{
			super();
			
			for(var i:int=0;i<UnitManager.STAGE_COUNT;i++){
				var starCount:int = UnitManager.getInstance().getStarCount(i,false);
				var str:String = "关卡" + (i+1).toString() + " （简单）[" + Tools.starString(starCount,3) + "]";
				var text:TextGame = new TextGame(str.toString());
				text.width = 250;
				text.pivotX = text.width >> 1;
				text.x = Game.STAGE_WIDTH/2 - 100;
				text.y = Game.STAGE_HEIGHT/4 + 100 * i;
				addChild(text);
				
				var enter:TextGame = new TextGame("进入");
				enter.width = 200;
				enter.x = text.x + 150;
				enter.y = text.y;
				enter.index = i;
				addChild(enter);
				menuText.push(enter);
				
				var starCountDef:int = UnitManager.getInstance().getStarCount(i,true);
				str = "关卡" + (i+1).toString() + " （困难）[" + Tools.starString(starCountDef,3) + "]";
				text = new TextGame(str.toString());
				text.width = 250;
				text.pivotX = text.width >> 1;
				text.x = Game.STAGE_WIDTH/2  - 100;
				text.y = Game.STAGE_HEIGHT/4 + 30 + 100 * i;
				addChild(text);
				
				enter = new TextGame("进入");
				if(starCount >= 3){
					enter.text = "进入";
					enter.index = 20+i;
					menuText.push(enter);
				}else{
					enter.text = "简单3星通关开启";
				}
				enter.x = text.x + 150;
				enter.y = text.y;
				enter.width = 200;
				addChild(enter);
			}
			
			var back:TextGame = new TextGame("返回");
			back.x = Game.STAGE_WIDTH >> 1;
			back.y = 550;
			addChild(back);
			back.name = "back";
			menuText.push(back);
			
			this.addEventListener(TouchEvent.TOUCH,onTouch);
			this.addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		private function onAdd(e:Event):void
		{
			Automic.selectScene(this);
		}
		
		public function remove():void{
			this.parent.removeChild(this);
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdd);
			this.removeEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this,TouchPhase.ENDED);
			var target:TextGame = e.target as TextGame;
			if(touch!=null && target && menuText.indexOf(target)!=-1 ){
				if(target.name == "back"){
					var start:StartScene = new StartScene();
					UnitManager.getInstance().sceneSprite.addChild(start);
				}else{
					var index:int = (e.target as TextGame).index;
					var isDefficult:Boolean;
					if(index>= 20){
						index -= 20;
						isDefficult = true;
					}else{
						isDefficult = false;
					}
					UnitManager.getInstance().enterScene(index,isDefficult);
				}
				remove();
			}
		}
		
		
	}
}