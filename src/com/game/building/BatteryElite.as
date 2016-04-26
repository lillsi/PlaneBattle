package com.game.building
{
	import com.game.buddle.Buddle;
	
	import core.unit.behavior.IAffact;
	import core.unit.behavior.IUnit;
	
	public class BatteryElite extends BatteryNormal
	{
		private var power:RatePower;
		private var dataVector:Vector.<BatteryData>;
		private var level:int=0;
		public function BatteryElite(dataVector:Vector.<BatteryData>,teamId:int=10)
		{
			super(teamId);
			power = new RatePower(this,5000,bar.percent);
			this.dataVector = dataVector;
			this.x = dataVector[0].x;
			this.y = dataVector[0].y;
			setProperty();
		}
		
//		override protected function draw():void{
//			var battery:Image = new Image(Game.asset.getTexture("battery"));
//			battery.pivotX = battery.width>>1;
//			battery.pivotY = battery.height>>1;
//			addChild(battery);
//		}
		
		override public function renderTick(tick:int):void{
			if(isProtected && power.isCool()){
				isProtected = false;
				hp = hpMax;
				rotation = Math.PI;
			}
			
			if(isProtected && !power.isCool()){
				power.rateRender(tick);
				rotation += Math.PI/45;
			}
			
			if(!isProtected){
				rateRender(tick);
				if(isCool()){
					var vec:Vector.<IUnit> = find();
					if(vec && vec.length>0){
						var unit:IUnit = vec[vec.length-1];
						var b:Buddle = createBuddle();
						b.target = unit;
						var dx:Number = unit.x - this.x;
						var dy:Number = unit.y - this.y;
						rotation = Math.atan2(dy,dx);
						coolDown();
					}
				}
			}
		}
		
		override public function defence(iaffact:IAffact):void{
			if(iaffact.isProtected == false && isProtected == false){
				this.hp -= iaffact.affactValue;
				if(hp<=0){
					isProtected = true;
//					power.halfCool();
					power.allCool();
					var coin:Coin = new Coin(drop);
					coin.x = this.x + int(Math.random() * 20) - 10;
					coin.y = this.y - int(Math.random() * 20) - 30;
					parent.addChild(coin);
					
					level++;
					setProperty();
				}
			}
			
			if(iaffact.isProtected == true && isProtected == true){
				if(power.restore(iaffact.affactValue)){
					remove();
				}
			}
		}
		
		private function setProperty():void{
			if(level<dataVector.length){
				var data:BatteryData = dataVector[level];
				this.range = data.range;
				this.rate = data.rate;
				this.attack = data.attack;
				this.hpMax = data.hpMax;
				this.buddle = data.buddle;
				this.drop = data.drop;
			}else{
				remove();
			}
		}
	}
}