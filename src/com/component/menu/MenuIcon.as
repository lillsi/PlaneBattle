package com.component.menu
{
	import com.component.gt.TextGame;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	public class MenuIcon extends Sprite
	{
		private var img:Image;
		private var tf:TextField;
		private var _selection:Selection;
		private var menuRoot:MenuCircle;
		
		public function MenuIcon(menuRoot:MenuCircle)
		{
			super();
			this.menuRoot = menuRoot;
			
			createImg();
			
			tf = new TextGame("1");
			tf.pivotX = tf.width>>1;
			tf.pivotY = tf.height>>1;
			tf.touchable = false;
			tf.color = 0xffffff;
			tf.y = 20;
			addChild(tf);
			
			addEventListener(TouchEvent.TOUCH,onClick);
		}
		
		protected function createImg():void{
//			var canvas:Canvas = new Canvas();
//			canvas.beginFill(0xffffcc);
//			canvas.drawCircle(0,0,20);
//			canvas.endFill();
//			addChild(canvas);
		}
		
		protected function onClick(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this,TouchPhase.ENDED);
			if(touch && _selection){
				_selection.func.apply();
				menuRoot.hide();
			}
		}
		
		public function set selection(value:Selection):void{
			if(value==null){
				this.visible = false;
			}else{
				_selection = value;
				tf.text = value.text;
				if(img){
					img.texture = Game.asset.getTexture(value.icon);
				}else{
					img = new Image(Game.asset.getTexture(value.icon));
					addChildAt(img,0);
				}
				img.pivotX = img.width>>1;
				img.pivotY = img.height>>1;
				this.visible = true;
			}
		}
	}
}