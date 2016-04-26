package com.game.buddle
{
	import com.calculation.Vector2D;
	import com.game.unit.core.Finder;
	import com.game.unit.core.Team;
	
	import flash.geom.Point;
	
	import core.unit.behavior.IFindable;
	import core.unit.behavior.IUnit;
	
	import starling.display.DisplayObjectContainer;

	public class BuddleJump extends Buddle implements IFindable
	{
		protected var finder:Finder;
		protected var team:Team;
		protected var life:int;
		
		protected var targetList:Vector.<IUnit>;
		
		public function BuddleJump(life:int=2,targetList:Vector.<IUnit>=null)
		{
			super();
			this.life = life;
			if(targetList==null){
				this.targetList = new Vector.<IUnit>;
			}else{
				this.targetList = targetList;
			}
			finder = new Finder(this);
			team = new Team();
			teamId = 10;
			range = 100;
		}
		
		override public function renderTick(tick:int):void
		{
			seek(new Vector2D(target.x,target.y));
			if(Math.abs(this.x - target.x) < Math.abs(velocity.x)){
				var container:DisplayObjectContainer = parent;
				target.defence(this);
				this.parent.removeChild(this);
				track.remove(this);
				
				targetList.push(target);
				var vec:Vector.<IUnit> = finder.find();
				for each(var t:IUnit in targetList){
					var index:int = vec.indexOf(t);
					if(index!=-1){
						vec.splice(index,1);
					}
				}
				
				if(life>0 && vec.length>0){
					var buddle:BuddleJump = new BuddleJump(life-1,targetList);
					buddle.x = this.x;
					buddle.y = this.y;
					buddle.affactValue = this.affactValue/3*2;
					buddle.target = vec[0];
					container.addChild(buddle);
					track.add(buddle);
				}
			}else{
				update();
			}
			//			lifeCount--;
			//			if(lifeCount == 0){
			//				this.parent.removeChild(this);
			//				track.remove(this);
			//			}
		}
		
		public function find(r:int=0):Vector.<IUnit>
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function gridChangeFlag():void
		{
			finder.gridChangeFlag();
		}
		
		public function gridPostion(range:int):Point
		{
			return finder.gridPostion(range);
		}
		
		public function set range(value:int):void
		{
			finder.range = value;
		}
		
		public function get range():int
		{
			return finder.range;
		}
		
		public function isEnermy(id:int):Boolean
		{
			return team.isEnermy(id);
		}
		
		public function get teamId():int
		{
			return team.teamId;
		}
		
		public function set teamId(value:int):void
		{
			team.teamId = value;
		}
		
	}
}