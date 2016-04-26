package com.component.menu
{
	import com.component.gt.TextGame;
	import com.game.building.Building;
	
	import starling.display.Canvas;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	
	
	public class MenuCreate extends Sprite
	{
		private var drag:Sprite = new Sprite();
		private var maskRed:Canvas = new Canvas();
		private var maskGreen:Canvas = new Canvas();
		private var currentSquare:Square;
		
		private var squares:Vector.<Square> = new Vector.<Square>;

		private var grayscaleFilter:ColorMatrixFilter;
		public function MenuCreate()
		{
			super();
			
			this.addChild(drag);
			
			maskRed.beginFill(0xff0000,0.5);
			maskRed.drawRectangle(-5,-5,GRID+10,GRID+10);
			maskRed.endFill();
			
			maskGreen.beginFill(0x0000ff,0.5);
			maskGreen.drawRectangle(-5,-5,GRID+10,GRID+10);
			maskGreen.endFill();
			
			grayscaleFilter = new ColorMatrixFilter();
			grayscaleFilter.adjustSaturation(-1);
			
			for(var i:int=0;i<6;i++){
				var s:Square = new Square(i);
				s.x = 100 + 50 * i;
				s.y = 600;
				s.pivotX = s.width >> 1;
				s.pivotY = s.height >> 1;
				squares.push(s);
				addChild(s);
				
				var cost:int = Factory.GetCreateCost(s.type);
				var text:TextGame = new TextGame(cost.toString());
				text.x = s.x;
				text.y = s.y;
				addChild(text);
				text.touchable = false;
			}
			
			this.addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		public function update():void{
			for each(var s:Square in squares){
				if(!s.enable){
					s.filter = grayscaleFilter;
				}else{
					s.filter = null;
				}
			}
		}
		
		public const GRID:int = 80;
		private var dx:int;
		private var dy:int;
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			var s:Square = e.target as Square;
			
			if(touch!=null && s!=null && s.enable){
				switch(touch.phase){
					case TouchPhase.BEGAN:
						currentSquare = s.clone();
						currentSquare.alpha = 0.7;
						
						drag.addChildAt(currentSquare,0);
						drag.addChild(maskRed);
						drag.addChild(maskGreen);
						
						drag.visible = true;
						maskRed.visible = true;
						maskGreen.visible = false;
						
						drag.pivotX = currentSquare.width>>1;
						drag.pivotY = currentSquare.height>>1;
						drag.x = touch.globalX;
						drag.y = touch.globalY;
						break;
					case TouchPhase.ENDED:
//						var dx:int,dy:int;
						var money:int,available:Boolean;
//						dx = int((touch.globalX+GRID/2-UnitManager.getInstance().sceneSprite.x)/GRID);
//						dy = int((touch.globalY+GRID/2-UnitManager.getInstance().sceneSprite.y)/GRID);
						drag.removeChildren();
						drag.visible = false;
						money = Factory.GetCreateCost(currentSquare.type);
						available = UnitManager.getInstance().buildAvailable(money,dx,dy);
						if(available) {
							UnitManager.getInstance().moneyCost(money);
							var building:Building = Factory.CreateBattery(dx*GRID,dy*GRID,currentSquare.type);
							building.buildPrice = money;
							UnitManager.getInstance().setBuild(dx,dy,building);
						}
						break;
					case TouchPhase.MOVED:
						dx = int((touch.globalX+GRID/2-UnitManager.getInstance().sceneSprite.x)/GRID);
						dy = int((touch.globalY+GRID/2-UnitManager.getInstance().sceneSprite.y)/GRID);
						drag.x = dx*GRID+UnitManager.getInstance().sceneSprite.x;
						drag.y = dy*GRID+UnitManager.getInstance().sceneSprite.y;
						money = Factory.GetCreateCost(currentSquare.type);
						available = UnitManager.getInstance().buildAvailable(money,dx,dy);
						maskGreen.visible = available;
						maskRed.visible = !available;
						break;
				}
			}
		}
	}
}

