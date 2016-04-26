package com.component.menu
{
	import starling.display.Canvas;
	import starling.display.Sprite;
	
	public class ArrowCtrl extends Sprite
	{
		public var left:Canvas;
		public var right:Canvas;
		public function ArrowCtrl()
		{
			super();
			
			left = new Canvas();
			left.beginFill(0x000000);
			left.drawEllipse(0,0,5,10);
			left.endFill();
			left.name = "left";
			addChild(left);
			
			right = new Canvas();
			right.beginFill(0x000000);
			right.drawEllipse(0,0,5,10);
			right.endFill();
			right.x = 20;
			right.name = "right";
			addChild(right);
		}
	}
}