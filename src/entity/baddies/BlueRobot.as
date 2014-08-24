package entity.baddies {
	import entity.AnimatedEntity;
	import entity.BehaviourEntity;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class BlueRobot extends AnimatedEntity
	{
		public function BlueRobot(xp:uint, yp:uint) 
		{
			super(xp, yp, Embed.blue_robot_32x32, 32, 32, BehaviourEntity.STOP, BehaviourEntity.VERTICAL);
			immovable = false;
		}
		override public function update():void {
			super.update();
		}
		
	}

}