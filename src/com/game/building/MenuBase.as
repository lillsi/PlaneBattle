package com.game.building
{
	import com.component.menu.Selection;
	import com.game.building.prod.Producter1;
	import com.game.building.prod.Producter2;
	import com.game.building.prod.Producter3;
	import com.game.building.prod.ProducterMore;
	
	public class MenuBase extends Building
	{
		public function MenuBase()
		{
			super();
			
			useHandCursor = true;
		}
		
		override public function getSelection():Vector.<Selection>{
			var selections:Vector.<Selection> = new Vector.<Selection>;
			var buildSelection:Selection;
			
			buildSelection = new Selection();
			buildSelection.text = "I（100）";
			buildSelection.func = build;
			selections.push(buildSelection);
			
			buildSelection = new Selection();
			buildSelection.text = "II（150）";
			buildSelection.func = build2;
			selections.push(buildSelection);
			
			buildSelection = new Selection();
			buildSelection.text = "III（300）";
			buildSelection.func = build3;
			selections.push(buildSelection);
			
			buildSelection = new Selection();
			buildSelection.text = "IV（500）";
			buildSelection.func = build4;
			selections.push(buildSelection);
			return selections;
		}
		
		override protected function draw():void{
			graphics.lineStyle(1);
			graphics.beginFill(0xffeecc);
			graphics.drawRect(-5,-5,10,10);
			graphics.endFill();
		}
		
		public function build():void{
			if(UnitManager.getInstance().moneyCost(100)){
				var unitProducter:Producter1 = new Producter1();
				unitProducter.x = this.x;
				unitProducter.y = this.y;
				UnitManager.getInstance().sceneSprite.addChild(unitProducter);
				UnitManager.getInstance().track.add(unitProducter);
				this.parent.removeChild(this);
			}
		}
		
		public function build2():void{
			if(UnitManager.getInstance().moneyCost(150)){
				var unitProducter:Producter1 = new Producter2();
				unitProducter.x = this.x;
				unitProducter.y = this.y;
				UnitManager.getInstance().sceneSprite.addChild(unitProducter);
				UnitManager.getInstance().track.add(unitProducter);
				this.parent.removeChild(this);
			}
		}
		
		public function build3():void{
			if(UnitManager.getInstance().moneyCost(300)){
				var unitProducter:Producter1 = new Producter3();
				unitProducter.x = this.x;
				unitProducter.y = this.y;
				UnitManager.getInstance().sceneSprite.addChild(unitProducter);
				UnitManager.getInstance().track.add(unitProducter);
				this.parent.removeChild(this);
			}
		}
		
		public function build4():void{
			if(UnitManager.getInstance().moneyCost(500)){
				var unitProducter:Producter1 = new ProducterMore();
				unitProducter.x = this.x;
				unitProducter.y = this.y;
				UnitManager.getInstance().sceneSprite.addChild(unitProducter);
				UnitManager.getInstance().track.add(unitProducter);
				this.parent.removeChild(this);
			}
		}
	}
}