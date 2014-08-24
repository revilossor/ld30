package entity.baddies {
	import entity.AnimatedEntity;
	import entity.BehaviourEntity;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class GreenGoblin extends AnimatedEntity
	{
		public function GreenGoblin(xp:uint, yp:uint) 
		{
			super(xp, yp, Embed.green_goblin_32x32, 32, 32, BehaviourEntity.HORIZONTAL, BehaviourEntity.STOP);
		}
		override public function update():void {
			super.update();
		}
		
	}

}