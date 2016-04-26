package com.component.menu.skill
{
	import com.Track;
	import com.game.unit.core.RateBehavior;
	
	import core.procedure.IProcedure;
	import core.unit.behavior.IRateabel;
	
	import starling.display.Canvas;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class SkillIcon extends Sprite implements IRateabel,IProcedure
	{
		private var img:Image;
		private var cd:RateBehavior;
		private var mask:Canvas;
		public function SkillIcon(imgName:String)
		{
			super();
			
			img = new Image(Game.asset.getTexture(imgName));
			img.width = img.height = 40;
			addChild(img);
			
			mask = new Canvas();
			mask.beginFill(0x000000,0.7);
			mask.drawRectangle(0,0,img.width,img.height);
			addChild(mask);
			
			cd = new RateBehavior();
			cd.rate = 1000;
			cd.coolDown();
			
			track.add(this);
			touchGroup = true;
		}
			
		public function coolDown():void
		{
			cd.coolDown();
			mask.scaleY = 1;
		}
		
		public function isCool():Boolean
		{
			return cd.isCool();
		}
		
		public function set rate(value:int):void
		{
			cd.rate = value;
		}
		
		public function get rate():int
		{
			return cd.rate;
		}
		
		public function rateRender(tick:int):void
		{
			cd.rateRender(tick);
			mask.scaleY = percent;
		}
		
		public function resetTick(tick:int=-1):void
		{
			cd.resetTick();
		}
			
		public function get percent():Number{
			return 1 - cd.percent;
		}
		
		public function renderTick(tick:int):void
		{
			rateRender(tick);
		}
		
		public function set track(value:Track):void
		{
		}
		
		public function get track():Track
		{
			return UnitManager.getInstance().track;
		}
		
	}
}