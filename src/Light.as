package{
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.*;
	
	public class Light extends Sprite {
		
		public var bitmap:Bitmap;
		public var glow2:GlowFilter;
		public var dis_bmp:BitmapData;
		public var source_bmd:BitmapData;
		public var w:Number;
		public var glow3:GlowFilter;
		public var h:Number;
		public var offset_array:Array;
		public var glow:GlowFilter;
		public var logo_mc:MovieClip;
		public var bounds:Object;
		public var offset_x:Number;
		public var offset_y:Number;
		public var perlinNoise_bmd:BitmapData;
		public var dmf:DisplacementMapFilter;
		
		
		public function Light() {
			glow = new GlowFilter(65535, 1, 1, 1, 100, 1, false, true);
			glow2 = new GlowFilter(65535, 0.6, 8, 8, 2, 1, false, false);
			glow3 = new GlowFilter(6711039, 0.8, 10, 10, 3, 1, false, false);
			offset_y = 2;
			offset_x = 2;
			bounds = logo_mc.getBounds(logo_mc);
			w = bounds.width + offset_x;
			h = bounds.height + offset_y;
			bounds.x = bounds.x - offset_x / 2;
			bounds.y = bounds.y - offset_y / 2;
			source_bmd = new BitmapData(w, h, true, 0);
			var myMatrix:Matrix = new Matrix(1, 0, 0, 1, bounds.x * -1, bounds.y * -1)
			source_bmd.draw(logo_mc,myMatrix);
			dis_bmp = new BitmapData(w, h, true, 0);
			bitmap = new Bitmap(dis_bmp);
			this.addChild(bitmap);
			bitmap.x = logo_mc.x + bounds.x;
			bitmap.y = logo_mc.y + bounds.y;
			perlinNoise_bmd = new BitmapData(w, h);
			logo_mc.filters = [glow2];
			bitmap.blendMode = BlendMode.SCREEN;
			bitmap.filters = [glow2, glow3];
			this.addEventListener(Event.ENTER_FRAME, onEventEnterFrame);
			var myPoint1:Point = new Point();
			var myPoint2:Point = new Point();
			var myPoint3:Point = new Point();
			offset_array = [myPoint1,myPoint2];
			dmf = new DisplacementMapFilter(perlinNoise_bmd, myPoint3, 1, 1, 25, 25, DisplacementMapFilterMode.COLOR);
		}
		
		public function onEventEnterFrame(param1:Event):void {
			offset_array[0].x = offset_array[0].x - 3;
			offset_array[1].x = offset_array[1].x - 2;
			perlinNoise_bmd.perlinNoise(10, 20, 3, 64, true, true, 1, true, offset_array);
			dis_bmp.applyFilter(source_bmd, source_bmd.rect, new Point(), glow);
			dis_bmp.applyFilter(dis_bmp, source_bmd.rect, new Point(), dmf);
		}
	}
}