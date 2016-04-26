package com.game.building
{
	import com.game.unit.core.GridPos;
	
	import flash.geom.Point;
	
	import core.unit.behavior.IPosition;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Coin extends Sprite implements IPosition
	{
		private var pos:GridPos;
		public var value:int;
		public function Coin(value:int)
		{
			super();
			
			this.value = value;
			
			var img:Image = new Image(Game.asset.getTexture("coin"));
			img.pivotX = img.width>>1;
			img.pivotY = img.height>>1;
			img.scaleX = img.scaleY = 0.2;
			addChild(img);
			
			pos = new GridPos(this);
		}
		
		public function gridPostion(range:int):Point
		{
			return pos.gridPostion(range);
		}
	}
}