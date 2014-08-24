package entity.baddies {
	import entity.AnimatedEntity;
	import entity.BehaviourEntity;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class RedRobot extends AnimatedEntity
	{
		public function RedRobot(xp:uint, yp:uint) 
		{
			super(xp, yp, Embed.red_robot_32x32, 32, 32, BehaviourEntity.STOP, BehaviourEntity.SEEK);
			_speed = 2;
			immovable = false;
		}
		override public function update():void {
			super.update();
		}
		
	}

}