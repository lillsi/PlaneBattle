package core.pool
{
	/**
	 *对象池中的位置
	 * 所有放入对象池的对象必须实现该接口
	 * @author Greg
	 */	
	public interface IPoolObject
	{
		 function reclaim():void;
	}
}