package com.game.unit
{
	import com.calculation.Vector2D;
	import com.game.buddle.AddEffect;
	import com.game.buddle.Buddle;
	import com.game.buddle.BuddlePool;
	import com.game.buddle.BuddleSkill;
	import com.game.unit.core.FinderMate;
	import com.game.unit.core.RateBehavior;
	
	import core.unit.behavior.IAffact;
	import core.unit.behavior.IUnit;

	public class PlaneBig extends Plane
	{
		private var mateFinder:FinderMate;
		private var mateRender:RateBehavior;
		private var attRender:RateBehavior;
		
		private var addCount:int;
		private var attCount:int;
		
		public function PlaneBig(teamId:int=1)
		{
			super(teamId);
			
			maxSpeed = 0.5;
			mass = 250;
			
			this.attack = 20;
			this.range = 500;
			this.rate = 5000;
			this.attack = 100;
			this.hpMax = 5000;
			
			
//			maxSpeed = 3;
//			mass = 2;
		}
		
		public function setAdd(value:int):void{
			addCount = value;
		}
		
		public function setAtt(value:int):void{
			attCount = value;
		}
		
		override protected function draw():void{
			super.draw();
			mainDisplay.scaleX = mainDisplay.scaleY = 0.3;
		}
		
		override protected function get imageString():String{
			return "LiPlane";
		}
		
		override public function rateRender(tick:int):void{
			super.rateRender(tick);
			mateRender.rateRender(tick);
			attRender.rateRender(tick);
		}
		
		override protected function move():void{
			seek(this.position.add(new Vector2D(maxSpeed,0)));
			hp++;
		}
		
		override protected function shoot():void{
			if(isCool()){
				var vec:Vector.<IUnit> = find();
				if(vec && vec.length>0){
					var unit:IUnit = vec.pop();
					var b:Buddle = BuddlePool.getIns().getNew();
					b.affactValue = attack;
					b.maxSpeed = 10;
					b.target = unit;
					b.x = this.x;
					b.y = this.y;
					parent.addChild(b);
					track.add(b);
					coolDown();
				}
			}
			
			if(addCount>0 && mateRender.isCool()){
				vec = mateFinder.find(500);
				if(vec && vec.length >0){
					var random:int = Math.random() * vec.length;
					var add:AddEffect = new AddEffect();
					add.x = this.x;
					add.y = this.y;
					add.affactValue = 50;
					add.setTarget(vec[random]);
					parent.addChild(add);
					track.add(add);
					
					addCount--;
					mateRender.coolDown();
				}
			}
			
			if(attCount>0 && attRender.isCool()){
				vec = find();
				if(vec && vec.length >0){
					random = Math.random() * vec.length;
					b = new BuddleSkill();
					b.affactValue = attack;
					b.maxSpeed = 10;
					b.isProtected = false;
					b.target = vec[random];
					b.x = this.x;
					b.y = this.y;
					parent.addChild(b);
					track.add(b);
				}
				attCount--;
			}
		}
		
		override protected function createFinder():void{
			super.createFinder();
//			finder = new Finder(this);
			mateFinder = new FinderMate(this);
		}
		
		override protected function createRate():void{
			super.createRate();
			mateRender = new RateBehavior();
			mateRender.rate = 300;
			mateRender.coolDown();
			
			attRender = new RateBehavior();
			attRender.rate = 150;
			attRender.coolDown();
		}
		
		override public function defence(iaffact:IAffact):void{
//			super.defence(iaffact);
		}
	}
}