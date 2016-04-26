package
{
	import com.game.building.BatteryElite;
	
	import avmplus.getQualifiedClassName;

	
	public class BatteryDataFactory
	{
		[Embed(source="/xml/scene.xml",mimeType="application/octet-stream")]
		private static var sceneData:Class;
		private static var sceneXml:XML = new XML(new sceneData);
		private static var sceneList:Array;
		private static var sceneListDef:Array;
		
		[Embed(source="/xml/plane.xml",mimeType="application/octet-stream")]
		private static var planeData:Class;
		private static var planeXml:XML = new XML(new planeData);
		
		
		private static var tempData:Array = [];
		
		public function BatteryDataFactory()
		{
		}
		
		public static function SetObjectProperty(unit:*,level:int=1):void{
			var fullName:String = getQualifiedClassName(unit);
			var className:String = fullName.split("::")[1];
			
			var index:int = level - 1;
			if(tempData[className + "_" + index]==null){
				var node:XML = planeXml[className][index];
				tempData[className + "_" + index] = node;
			}else{
				node = tempData[className + "_" + index];
			}
			
			
			for each(var child:XML in node.children()){
				var property:String = child.name();
				if(unit.hasOwnProperty(property)){
					switch(property){
						case "attack":
							unit[property] = Research.getInstance().valueChange(Research.RESEARCH_2,int(child.toString()));
							break;
//						case "rate":
//							break;
						case "hpMax":
							unit[property] = Research.getInstance().valueChange(Research.RESEARCH_3,int(child.toString()));
							break;
						default:
							unit[property] = int(child.toString());
					}
				}
			}
		}
		
		public static function GetSceneData(id:int,defficult:Boolean):XML{
			if(sceneList==null){
				sceneList = [];
				sceneListDef = [];
				for each(var node:XML in sceneXml.scene){
					if(node.def==0){
						sceneList[String(node.id)] = node;
					}
					
					if(node.def==1){
						sceneListDef[String(node.id)] = node;
					}
				}
			}
			
			if(defficult){
				return sceneListDef[id];
			}else{
				return sceneList[id];
			}
		}
		
		public static function GetPrice(type:String,level:int):int{
			if(tempData[type + "_" + level]==null){
				var node:XML = planeXml[type][level];
				tempData[type + "_" + level] = node;
			}else{
				node = tempData[type + "_" + level];
			}
			return node.price;
		}
	}
}