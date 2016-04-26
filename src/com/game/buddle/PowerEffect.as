package com.game.buddle
{
	import com.Track;
	import com.game.unit.core.RateBehavior;
	
	import core.procedure.IProcedure;
	import core.unit.behavior.IAffact;
	import core.unit.behavior.IUnit;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class PowerEffect extends Sprite implements IAffact,IProcedure
	{
		protected var _affectValue:int;
		private var _isProtected:Boolean;
		private var _rate:RateBehavior;
		private var _target:IUnit;
		public function PowerEffect()
		{
			_rate = new RateBehavior();
			_rate.rate = 500;
			_rate.coolDown();
		}
		
		public function setTarget(target:IUnit):void{
			_target = target;
			
			var dx:Number = target.x - this.x;
			var dy:Number = target.y - this.y;
			
			var angle:Number = Math.atan2(dy,dx);
			var l:Number = Math.sqrt(dx*dx+dy*dy);
			
			var img:Image = new Image(Game.asset.getTexture("laser"));
			img.width = 4;
			img.pivotX = img.width>>1;
			img.height = l;
			
			img.rotation = angle-Math.PI/2;
			addChild(img);
			
			_target.defence(this);
		}
		
		public function get affactValue():int
		{
			return _affectValue;
		}
		
		public function set affactValue(value:int):void
		{
			_affectValue = value
		}
		
		public function get isProtected():Boolean
		{
			return _isProtected;
		}
		
		public function set isProtected(value:Boolean):void
		{
			_isProtected = value;
		}
		
		public function renderTick(tick:int):void
		{
			_rate.rateRender(tick);
			if(_rate.isCool()){
				removeFromParent();
				track.remove(this);
			}else{
				alpha -= 0.1;
			}
		}
		
		public function get track():Track
		{
			return UnitManager.getInstance().track;
		}
		
	}
}