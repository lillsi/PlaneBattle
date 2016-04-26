package
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.utils.RectangleUtil;
	
	[SWF(width="960",height="640",frameRate="30",backgroundColor = "#000000")]
	public class RTSMobile extends Sprite
	{
		private var myStarling:Starling;
		public function RTSMobile()
		{
			super();
			
			trace(Starling.VERSION);
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		
		
		private function onAddToStage(e:Event):void{
			
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			
			//			stats = new Stats();
			//			this.addChild(stats);
			
						var screenWidth:int = stage.fullScreenWidth;
						var screenHeight:int = stage.fullScreenHeight;
						var CapabilityX:int  = Capabilities.screenResolutionX;
						var CapabilityY:int = Capabilities.screenResolutionY;
						var viewPort:Rectangle = RectangleUtil.fit(
							new Rectangle(0, 0, stage.stageWidth, stage.stageHeight), 
							new Rectangle(0, 0, screenWidth, screenHeight), 
							StageScaleMode.SHOW_ALL);
			
						myStarling = new Starling(Game, stage, viewPort);
//			myStarling = new Starling(Game, stage);
			myStarling.antiAliasing = 1;
			myStarling.stage.stageWidth  = 960; 
			myStarling.stage.stageHeight = 640;
			//myStarling.simulateMultitouch = true;
			myStarling.showStatsAt();
			myStarling.start();
			//			this.stage.addEventListener(flash.events.Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
	}
}