package
{
	import com.Track;
	import com.component.menu.ArrowCtrl;
	import com.component.menu.MenuCircle;
	import com.component.menu.MenuCreate;
	import com.component.menu.skill.MenuSkill;
	import com.component.print.Printer;
	import com.scene.StartScene;
	
	import flash.filesystem.File;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	
	public class Game extends Sprite
	{
		public static var asset:AssetManager = new AssetManager();
		public static const STAGE_WIDTH:Number = 960;
		public static const STAGE_HEIGHT:Number = 640;
		private var rootSprite:Sprite = new Sprite();
		private var sceneSprite:Sprite = new Sprite();
		private var menuSprite:Sprite = new Sprite();
		private var m:MenuCircle;
		private var track:Track;

		private var arrow:ArrowCtrl;
		public function Game()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAddtoStage);
		}
		
		private function onAddtoStage(e:Event):void
		{
			this.removeEventListeners(Event.ADDED_TO_STAGE);
			
			var file:File = File.applicationDirectory.resolvePath("asset");
			asset.enqueue(file);
			asset.loadQueue(onComplete);
		}
		
		private function onComplete(radio:int):void
		{
			if(radio == 1){
				init();
			}
		}
		
		private function init():void{
			rootSprite.addChild(sceneSprite);
			rootSprite.addChild(menuSprite);
			addChild(rootSprite);
			
			track = new Track(this);
			UnitManager.getInstance().track = track;
			UnitManager.getInstance().sceneSprite = sceneSprite;
			UnitManager.getInstance().menuSprite = menuSprite;
			UnitManager.getInstance().rootSprite = rootSprite;
			UnitManager.getInstance().loadStar();
			menuCreate();
			dataInit();
			
			var start:StartScene = new StartScene();
			addChild(start);
		}
		
		private function dataInit():void
		{
			
		}
		
		private function menuCreate():void{
			m = new MenuCircle();
			menuSprite.addChild(m);
			UnitManager.getInstance().menuCircle = m;
			
			var text:TextField = new TextField(100,30,"0");
			text.color = 0xffffff;
			text.x = 20;
			text.y = 20;
			menuSprite.addChild(text);
			UnitManager.getInstance().text = text;
			
			var menu:MenuCreate = new MenuCreate();
			menuSprite.addChild(menu);
			UnitManager.getInstance().menuCreate = menu;
			
			var skill:MenuSkill = new MenuSkill();
			menuSprite.addChild(skill);
			UnitManager.getInstance().menuSkill = skill;
			
			var printer:Printer = new Printer();
			menuSprite.addChild(printer);
			UnitManager.getInstance().printer = printer;
			
			menuSprite.visible = false;
		}
	}
}