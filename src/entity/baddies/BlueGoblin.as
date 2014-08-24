package entity.baddies {
	import entity.AnimatedEntity;
	import entity.BehaviourEntity;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class BlueGoblin extends AnimatedEntity
	{
		public function BlueGoblin(xp:uint, yp:uint) 
		{
			super(xp, yp, Embed.blue_goblin_32x32, 32, 32, BehaviourEntity.VERTICAL, BehaviourEntity.STOP);
		}
		override public function update():void {
			super.update();
		}
		
	}

}