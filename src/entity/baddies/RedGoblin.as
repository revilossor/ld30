package entity.baddies {
	import entity.AnimatedEntity;
	import entity.BehaviourEntity;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class RedGoblin extends AnimatedEntity
	{
		public function RedGoblin(xp:uint, yp:uint) 
		{
			super(xp, yp, Embed.red_goblin_32x32, 32, 32, BehaviourEntity.SEEK, BehaviourEntity.STOP);
			_speed = 2;
		}
		override public function update():void {
			super.update();
		}
		
	}

}