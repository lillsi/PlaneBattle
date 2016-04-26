package com.component.menu.skill
{
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MenuSkill extends Sprite
	{

		private var icon:SkillIcon;
		private var icon2:SkillIcon;
		public function MenuSkill()
		{
			super();
			
			icon = new SkillIcon("skill1");
			icon.x = 800;
			icon.y = 600;
			icon.name = "skill1";
			addChild(icon);
			
			icon2 = new SkillIcon("skill2");
			icon2.x = 850;
			icon2.y = 600;
			icon2.name = "skill2";
			addChild(icon2);
			
			addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		public function init():void{
			icon.coolDown();
			icon2.coolDown();
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this,TouchPhase.ENDED);
			var skill:SkillIcon = event.target as SkillIcon;
			if(touch && skill){
				switch(skill.name){
					case "skill1":
						if(icon.isCool()){
							icon.coolDown();
							UnitManager.getInstance().mainPlane.setAdd(20);
						}
						break;
					case "skill2":
						if(icon2.isCool()){
							icon2.coolDown();
							UnitManager.getInstance().mainPlane.setAtt(20);
						}
						break;
				}
				
			}
		}
	}
}