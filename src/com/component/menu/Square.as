package com.component.menu
{
	import starling.display.Image;
	import starling.textures.Texture;

	public class Square extends Image{
		public var type:String;
		private var index:int;
		public function Square(ty:int){
			type = Factory.VEC[ty];
			index = ty;
//			var t:Texture = createTexture();
			var imgName:String = Factory.SwitchUrl(type);
			var t:Texture = Game.asset.getTexture(imgName);
			super(t);
		}
		
		public function get enable():Boolean{
//			return Research.getInstance().getLevel(Research.RESEARCH_1) >= researchNeed;
			return true;
		}
		
		public function get researchNeed():int{
			return Factory.NEED[index];
		}
		
//		private function createTexture():Texture{
//			var shape:Shape = new Shape();
//			var color:uint = Factory.SwitchColor(type);
//			shape.graphics.lineStyle(1,color);
//			shape.graphics.beginFill(color,0);
//			shape.graphics.drawRect(0,0,20,20);
//			shape.graphics.endFill();
//			
//			var b:BitmapData = new BitmapData(24,24,true,0xffffff);
//			b.draw(shape);
//			
//			return Texture.fromBitmapData(b);
//		}
		
		public function clone():Square{
			var s:Square = new Square(index);
			return s;
		}
	}
}