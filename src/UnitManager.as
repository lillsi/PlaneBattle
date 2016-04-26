package
{
	import com.Track;
	import com.component.menu.MenuCircle;
	import com.component.menu.MenuCreate;
	import com.component.menu.skill.MenuSkill;
	import com.component.print.Printer;
	import com.game.building.Building;
	import com.game.building.Coin;
	import com.game.building.MainBase;
	import com.game.unit.PlaneBig;
	import com.scene.GameScene;
	import com.scene.SceneStarInfo;
	
	import flash.net.SharedObject;
	
	import core.unit.behavior.IUnit;
	
	import starling.display.Sprite;
	import starling.text.TextField;

	public class UnitManager
	{
		private static var instance:UnitManager;
		public var list:Vector.<IUnit> = new Vector.<IUnit>;
		public var coins:Vector.<Coin> = new Vector.<Coin>;
		public var mainBase:MainBase;
		
		public var track:Track;
		public var sceneSprite:Sprite;
		public var menuSprite:Sprite;
		public var rootSprite:Sprite;
		
		private var _money:int=0;
		public var text:TextField;
		
		
		public var menuCircle:MenuCircle;
		public var menuCreate:MenuCreate;
		public var menuSkill:MenuSkill;
		public var printer:Printer;
		
		public var buildingList:Array = [];
		private var scenes:Vector.<SceneStarInfo>;
		private var scenesDef:Vector.<SceneStarInfo>;
		
		private var lso:SharedObject;
		private const SHARED_LABEL:String = "Star";
		public static const STAGE_COUNT:int = 4;

		public static const NORMAL:String = "normal";
		public static const DEFFICULT:String = "defficult";
		
		public var mainPlane:PlaneBig;
		
		public function UnitManager()
		{
			scenes = new Vector.<SceneStarInfo>;
			scenesDef = new Vector.<SceneStarInfo>;
			
			for(var i:int=0;i<STAGE_COUNT;i++){
				scenes[i] = new SceneStarInfo;
				scenes[i].stageIndex = i;
				scenes[i].isDefficult = false;
				
				scenesDef[i] = new SceneStarInfo;
				scenesDef[i].stageIndex = i;
				scenesDef[i].isDefficult = true;
			}
		}
		
		public static function getInstance():UnitManager{
			if(instance == null){
				instance = new UnitManager();
			}
			return instance;
		}
		
		public function addPos(pos:IUnit):void{
			list.push(pos);
		}
		
		public function removePos(unit:IUnit):void
		{
			var index:int = list.indexOf(unit);
			if(index!=-1){
				list.splice(index,1);
			}
		}
		
		public function clearAll():void{
			list.length = 0;
			list = new Vector.<IUnit>;
			
			track.clear();
			buildingList = [];
			
			while(sceneSprite.numChildren>0){
				sceneSprite.removeChildAt(0);
			}
			sceneSprite.x = sceneSprite.y = 0;
		}
		
		public function moneyCost(value:int):Boolean{
			if(_money >= value){
				_money -= value;
				text.text = _money.toString();
				return true;
			}else{
				return false;
			}
		}
		public function moneyAdd(value:int):void{
			_money += value;
			text.text = _money.toString();
		}
		
		public function moneySet(value:int):void
		{
			_money = value;
			text.text = _money.toString();
		}
		
		public function buildAvailable(money:int,x:int,y:int):Boolean{
			var xb:Boolean = x<=2 && x>=1;
			var yb:Boolean = y<=5 && y>=3;
			 return _money >= money && buildingList[x+"_"+y]==null && xb && yb;
		}
		
		public function setBuild(x:int,y:int,building:Building):void{
			building.dx = x;
			building.dy = y;
			buildingList[x+"_"+y] = building;
		}
		
		public function tryBuild(type:String):void{
			var cost:int = Factory.GetCreateCost(type);
			if(_money >= cost){
				for(var x:int=1;x<=2;x++){
					for(var y:int=3;y<=5;y++){
						if(buildingList[x+"_"+y]==null){
							UnitManager.getInstance().moneyCost(cost);
							var building:Building = Factory.CreateBattery(x*80,y*80,type);
							building.buildPrice = cost;
							UnitManager.getInstance().setBuild(x,y,building);
							return
						}
					}
				}
			}
		}
		
		public function tryUpgrade():void{
			for each(var b:Building in buildingList){
				if(b.upgrade()){
					return;
				}
			}
		}
		
		public function removeBuild(building:Building):void{
			delete buildingList[building.dx+"_"+building.dy];
		}
		
		public function loadStar():void{
			lso = SharedObject.getLocal(SHARED_LABEL);
			
			for(var i:int=0;i<STAGE_COUNT;i++){
				if(lso.data[NORMAL + "_" + i]!=null){
					scenes[i].starCount = lso.data[NORMAL + "_" + i];
				}
				
				if(lso.data[DEFFICULT + "_" + i]!=null){
					scenesDef[i].starCount = lso.data[DEFFICULT + "_" + i];
				}
			}
		}
		
		public function saveStar(starCount:int,stageIndex:int,isDefficult:Boolean):void{
			if(isDefficult){
				lso.data[DEFFICULT + "_" + stageIndex] = starCount;
			}else{
				lso.data[NORMAL + "_" + stageIndex] = starCount;
			}
			lso.flush();
		}
		
		public function getStarCount(stage:int,isDefficult:Boolean):int{
			if(isDefficult){
				return scenesDef[stage].starCount;
			}else{
				return scenes[stage].starCount;
			}
		}
		
		public function getAllStar():int{
			var count:int = 0;
			for(var i:int=0;i<scenes.length;i++){
				count += scenes[i].starCount;
				count += scenesDef[i].starCount;
			}
			return count;
		}
		
		public function enterScene(stage:int,isDefficult:Boolean):void{
			var info:SceneStarInfo;
			if(isDefficult){
				info = scenesDef[stage];
			}else{
				info = scenes[stage];
			}
			var scene:GameScene = new GameScene(info);
			scene.initScene();
			scene.fromXml(BatteryDataFactory.GetSceneData(stage,isDefficult));
		}
	}
}