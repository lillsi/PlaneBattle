package com.game.buddle
{
	import com.calculation.Vector2D;
	import com.game.unit.core.Finder;
	import com.game.unit.core.Team;
	
	import core.unit.behavior.IFindable;
	import core.unit.behavior.ITeamate;
	import core.unit.behavior.IUnit;
	
	import flash.geom.Point;

	public class BuddleArea extends Buddle implements IFindable
	{
		protected var finder:Finder;
		protected var team:Team;
		public function BuddleArea()
		{
			super();
			
			finder = new Finder(this);
			team = new Team();
			teamId = 10;
			range = 100;
		}
		
		override public function renderTick(tick:int):void
		{
			seek(new Vector2D(target.x,target.y));
			
			if(Math.abs(this.x - target.x) < Math.abs(velocity.x)){
				target.defence(this);
				this.parent.removeChild(this);
				track.remove(this);
				
				var vec:Vector.<IUnit> = finder.find();
				for each(var iu:IUnit in vec){
					iu.defence(this);
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