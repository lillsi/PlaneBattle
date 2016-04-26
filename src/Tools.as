package
{
	public class Tools
	{
		public function Tools()
		{
		}
		
		public static function starString(current:int,max:int):String{
			var str:String = "";
			for(var i:int=0;i<max;i++){
				if(i<current){
					str += "★";
				}else{
					str += "☆";
				}
			}
			return str;
		}
	}
}