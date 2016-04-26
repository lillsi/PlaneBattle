package com.game.buddle
{
	import com.game.building.Coin;
	import com.game.unit.core.RateBehavior;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class CoingetEffect extends Sprite
	{
		private var _rate:RateBehavior;
		private var target:Coin;
		private var img:Image;
		private var running:Boolean = false;
		public function CoingetEffect()
		{
			super();
			
			_rate = new RateBehavior();
			_rate.rate = 50;
			_rate.coolDown();
		}
		
		public function setTarget(coin:Coin):void{
			target = coin;
		}
		
		public function updateImage():void{
			var dx:Number = target.x - this.x;
			var dy:Number = target.y - this.y;
			
			var angle:Number = Math.atan2(dy,dx);
			var l:Number = Math.sqrt(dx*dx+dy*dy);
			
			addImage();
			img.height = l;
			img.rotation = angle-Math.PI/2;
		}
		
		public function renderTick(tick:int):void
		{
			if(running){
				_rate.rateRender(tick);
				if(_rate.isCool()){
					updateImage();
					alpha -= 0.05;
					if(alpha<=0.2){
						alpha = 1;
					}
				}
			}
		}
		
		protected function addImage():void{
			if(img!=null){
				removeChild(img);
			}
			img = new Image(Game.asset.getTexture("laser"));
			img.width = 4;
			img.pivotX = img.width>>1;
			addChild(img);
		}
		
		public function start():void
		{
			visible = true;
			running = true;
			_rate.coolDown();
			_rate.resetTick();
		}
		
		public function stop():void{
			visible = false;
			running = false;
		}
	}
}