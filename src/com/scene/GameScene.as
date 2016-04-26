package com.scene
{
	import com.Track;
	import com.component.Panel;
	import com.component.menu.MenuIcon;
	import com.game.building.BatteryElite;
	import com.game.building.BatteryNormal;
	import com.game.building.MainBase;
	import com.game.unit.PlaneBig;
	
	import flash.geom.Point;
	
	import core.procedure.IMenu;
	import core.procedure.IProcedure;
	
	import starling.display.Canvas;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class GameScene implements IProcedure
	{

		private var tempMousePoint:Point;
		private var canvas:Canvas;
		
		protected var startTime:int;
		private var info:SceneStarInfo;

		private var plane:PlaneBig;
		private var base:MainBase;
		
		public function GameScene(info:SceneStarInfo)
		{
			this.info = info;
		}
		
		public function fromXml(xml:XML):void{
			createGround(xml.width,xml.height);
			createMainBase(xml.basex,xml.basey,xml.baseHp);
			
			for each(var node:XML in xml.battery){
				batteryFromXml(node);
			}
		}
		
		public function initScene():void{
			UnitManager.getInstance().menuCreate.update();
			UnitManager.getInstance().menuSkill.init();
			UnitManager.getInstance().printer.update();
			UnitManager.getInstance().menuSprite.visible = true;
			UnitManager.getInstance().moneySet(300);
//			createGround(2100,800);
//			createEnermy();
			createBigPlane();
			track.add(this);
			
			if(Automic.isAuto){
				start();
			}else{
				createPanel();
			}
		}
		
		private function createPanel():void
		{
			UnitManager.getInstance().track.stop();
			var panel:Panel = new Panel();
			panel.show("胜利：摧毁敌方基地\n" +
				"失败：母舰被摧毁",start);
			
			UnitManager.getInstance().menuSprite.addChild(panel);
		}
		
		private function start():void{
			UnitManager.getInstance().track.start();
			UnitManager.getInstance().printer.add("开始游戏");
			startTime = track.getCurrent();
		}
		
		private function createBigPlane():void
		{
			plane = new PlaneBig();
			
			plane.x = 0;
			plane.y = 350;
			
			UnitManager.getInstance().sceneSprite.addChild(plane);
			UnitManager.getInstance().track.add(plane);
			
			UnitManager.getInstance().addPos(plane);
			
			plane.addEventListener(Event.REMOVED,onFail);
			
			UnitManager.getInstance().mainPlane = plane;
		}
		
		protected function createEnermy():void{
			createMainBase(1900,400,1000);
			createBatteryNormal(850,250,300,1000,5,200,0);
			createBatteryNormal(900,350,650,1000,1,200,0);
			createBatteryNormal(900,450,650,1000,1,200,0);
			createBatteryNormal(850,550,300,1000,5,200,0);
			
			createBatteryNormal(1200,200,300,750,5,500,0);
			createBatteryNormal(1250,250,300,750,5,500,0);
			createBatteryNormal(1300,350,650,1500,2,500,0);
			createBatteryNormal(1300,450,650,1500,2,500,0);
			createBatteryNormal(1250,550,300,750,5,500,0);
			createBatteryNormal(1200,600,300,750,5,500,0);
			
			createBatteryNormal(1650,300,400,500,15,1000,0);
			createBatteryNormal(1750,350,400,500,15,1000,0);
			createBatteryNormal(1750,450,400,500,15,1000,0);
			createBatteryNormal(1650,500,400,500,15,1000,0);
			createBatteryNormal(1800,400,800,500,2,1000,0);
			createBatteryNormal(1850,400,1000,500,2,1000,0);
		}
		
		protected function batteryFromXml(xml:XML):void{
			if(xml.data.length() == 1){
				var dataArray:Array = String(xml.data[0]).split(",");
				createBatteryNormal(dataArray[0],dataArray[1],dataArray[2],dataArray[3],dataArray[4],dataArray[5],dataArray[6],dataArray[7]);
			}else{
				var dataVec:Vector.<BatteryData> = new Vector.<BatteryData>;
				for each(var node:XML in xml.data){
					dataArray = node.toString().split(",");
					var data:BatteryData = new BatteryData(dataArray[0],dataArray[1],dataArray[2],dataArray[3],dataArray[4],dataArray[5],dataArray[6],dataArray[7]);
					dataVec.push(data);
				}
				createBatteryElite(dataVec);
			}
		}
		
//		protected function createMenu(x:Number,y:Number):void{
//			var menu:MenuBase = new MenuBase();
//			menu.x = x;
//			menu.y = y;
//			UnitManager.getInstance().mainSprite.addChild(menu);
//		}
		
		protected function createGround(w:Number,h:Number):void{
			canvas = new Canvas();
			canvas.beginFill(0x000000);
			canvas.drawRectangle(0,0,w,h);
			canvas.endFill();
			UnitManager.getInstance().sceneSprite.addChildAt(canvas,0);
			UnitManager.getInstance().sceneSprite.addEventListener(TouchEvent.TOUCH,onTouch);
			UnitManager.getInstance().rootSprite.addEventListener(TouchEvent.TOUCH,onTouchRoot);
			
			var graphics:Canvas = new Canvas;
			graphics.beginFill(0xffffff,0.5);
			graphics.drawRectangle(40-5,200-5,160+10,240+10);
			graphics.endFill();
			UnitManager.getInstance().sceneSprite.addChildAt(graphics,1);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			// TODO Auto Generated method stub
			var touch:Touch = event.getTouch(UnitManager.getInstance().sceneSprite);
			if(touch!=null){
				switch(touch.phase){
					case TouchPhase.BEGAN:
						tempMousePoint = touch.getLocation(UnitManager.getInstance().sceneSprite);
						
//						UnitManager.getInstance().printer.add("开始移动屏幕");
						break;
					case TouchPhase.ENDED:
//						UnitManager.getInstance().printer.add("结束移动屏幕");
						
						break;
					case TouchPhase.MOVED:
						UnitManager.getInstance().sceneSprite.x = touch.globalX - tempMousePoint.x;
						UnitManager.getInstance().sceneSprite.y = touch.globalY - tempMousePoint.y;
						
						if(UnitManager.getInstance().sceneSprite.x > 0){
							UnitManager.getInstance().sceneSprite.x = 0;
						}
						
						if(UnitManager.getInstance().sceneSprite.x < Game.STAGE_WIDTH - canvas.width){
							UnitManager.getInstance().sceneSprite.x = Game.STAGE_WIDTH - canvas.width;
						}
						
						if(UnitManager.getInstance().sceneSprite.y > 0){
							UnitManager.getInstance().sceneSprite.y = 0;
						}
						
						if(UnitManager.getInstance().sceneSprite.y < Game.STAGE_HEIGHT - canvas.height){
							UnitManager.getInstance().sceneSprite.y = Game.STAGE_HEIGHT - canvas.height;
						}
						
						break;
				}
			}
		}
		
		
		private function onTouchRoot(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(UnitManager.getInstance().rootSprite);
			if(touch!=null){
				switch(touch.phase){
					case TouchPhase.ENDED:
						var bool1:Boolean = touch.target is IMenu;
						var bool2:Boolean = touch.target is MenuIcon;
						if(!bool1 && !bool2){
							UnitManager.getInstance().menuCircle.hide();
						}
						break;
				}
			}
		}
		
		protected function createMainBase(x:Number,y:Number,hpMax:int):void{
			base = new MainBase();
			base.x = x;
			base.y = y;
			base.hpMax = hpMax;
			UnitManager.getInstance().sceneSprite.addChild(base);
			UnitManager.getInstance().mainBase = base;
			UnitManager.getInstance().addPos(base);
			
			base.addEventListener(Event.REMOVED,onWin);
		}
		
		protected function backToStart():void{
			UnitManager.getInstance().clearAll();
			UnitManager.getInstance().menuSprite.visible = false;
			var start:StartScene = new StartScene();
			UnitManager.getInstance().sceneSprite.addChild(start);
		}
		
		protected function createBatteryNormal(x:Number,y:Number,range:int=500,rate:int=500,
											   attack:int=20,hpMax:int=20,drop:int=0,buddle:int=0):void{
			var battery:BatteryNormal = new BatteryNormal();
			battery.x = x;
			battery.y = y;
			UnitManager.getInstance().sceneSprite.addChild(battery);
			UnitManager.getInstance().track.add(battery);
			UnitManager.getInstance().addPos(battery);
			
			battery.range = range;
			battery.rate = rate;
			battery.attack = attack;
			battery.hpMax = hpMax;
			battery.buddle = buddle;
			battery.drop = drop;
		}
		
		protected function createBatteryElite(datas:Vector.<BatteryData>):void{
			var battery:BatteryElite = new BatteryElite(datas);
			UnitManager.getInstance().sceneSprite.addChild(battery);
			UnitManager.getInstance().track.add(battery);
			UnitManager.getInstance().addPos(battery);
		}
		
		protected function removeEvent():void{
			base.removeEventListener(Event.REMOVED,onWin);
			plane.removeEventListener(Event.REMOVED,onFail);
			track.remove(this);
		}
		
		protected function onWin(event:Event):void
		{
			removeEvent();
			
			var sec:int = (timeTick - startTime)/1000;
			var star:int;
			if(sec > 60){
				star = 1;
			}else if(sec > 45){
				star = 2;
			}else{
				star = 3;
			}
			
			if(star>info.starCount){
				info.starCount = star;
				UnitManager.getInstance().saveStar(star,info.stageIndex,info.isDefficult);
			}
			var string:String = "You Win; Cost "+ sec + " Seconds [";
			string += Tools.starString(star,3);
			string += "]";
			
			if(Automic.isAuto){
				trace(string);
				backToStart();
			}else{
				var panel:Panel = new Panel();
				panel.show(string,backToStart);
				UnitManager.getInstance().menuSprite.addChild(panel);
			}
		}
		
		private function onFail():void
		{
			removeEvent();
			var string:String = "You Lose."
			if(Automic.isAuto){
				trace(string);
				backToStart();
			}else{
				var panel:Panel = new Panel();
				panel.show(string,backToStart);
				UnitManager.getInstance().menuSprite.addChild(panel);
			}
		}
		
		private var lastTick:int = -1;
		private var timeTick:int;
		public function renderTick(tick:int):void
		{
			timeTick = tick;
			if(lastTick == -1){
				lastTick = tick;
			}else{
				var past:int = tick - lastTick;
				if(past > 1000){
					lastTick = tick;
					UnitManager.getInstance().moneyAdd(5);
					Automic.autoBuild();
				}
			}
		}
		
		public function get track():Track
		{
			return UnitManager.getInstance().track;
		}
		
	}
}