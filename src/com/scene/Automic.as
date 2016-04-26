package com.scene
{
	public class Automic
	{
		public static var isAuto:Boolean = true;
//		public static var isAuto:Boolean = false;
		public function Automic()
		{
		}
		
		public static function autoBuild():void{
			if(isAuto){
				if(Math.random()>0.5){
					UnitManager.getInstance().tryUpgrade();
				}else{
					var vec:Vector.<String> = Vector.<String>([Factory.P6]);
					var index:int = Math.random() * vec.length;
					UnitManager.getInstance().tryBuild(vec[index]);
				}
			}
		}
		
		public static function selectScene(scene:SelectScene):void
		{
			if(isAuto){
				scene.remove();
				UnitManager.getInstance().enterScene(0,false);
			}
		}
		
		public static function autoStart(scene:StartScene):void
		{
			if(isAuto){
				scene.remove();
				UnitManager.getInstance().sceneSprite.addChild(new SelectScene());
			}
		}
	}
}