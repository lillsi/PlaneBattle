package com.game.buddle
{
	import com.calculation.Vector2D;
	
	import core.unit.behavior.IUnit;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.events.Event;

	public class BuddleFly extends Buddle
	{
		private var dx:Number;
		private var dy:Number;
		
		
		public function BuddleFly(buddleString:String="boom_purple", boomString:String="bz_purple")
		{
			super(buddleString, boomString);
		}
		
		override protected function setProperty():void{
			maxSpeed = 25;
			mass = 1;
		}
		
		override protected function move():void{
			seek(this.position.add(new Vector2D(dx,dy)));
		}
		
		override public function set target(value:IUnit):void{
			super.target = value;
			dx = target.x - this.x;
			dy = target.y - this.y;
		}
		
		private const hitLength:int = 10;
		override protected function get isHit():Boolean{
			return Math.abs(this.x - target.x) < hitLength && Math.abs(this.y - target.y) < hitLength;
		}
		
		override public function remove():void{
			
		}
		
//		override public function renderTick(tick:int):void
//		{
//			move();
//			if(Math.abs(this.x - target.x) < Math.abs(velocity.x)){
//				var boom:MovieClip = new MovieClip(Game.asset.getTextures(boomString),24);
//				boom.x = target.x;
//				boom.y = target.y;
//				boom.pivotX = boom.width>>1;
//				boom.pivotY = boom.height>>1;
//				boom.scaleX = boom.scaleY = 0.2;
//				parent.addChild(boom);
//				Starling.juggler.add(boom);
//				
//				boom.addEventListener(Event.COMPLETE,function():void{
//					boom.removeEventListeners(Event.COMPLETE);
//					if(boom.parent)	boom.parent.removeChild(boom);
//					Starling.juggler.remove(boom);
//				});
//				
//				target.defence(this);
//				remove();
//			}else{
//				update();
//			}
			//			lifeCount--;
			//			if(lifeCount == 0){
			//				this.parent.removeChild(this);
			//				track.remove(this);
			//			}
//		}
	}
}