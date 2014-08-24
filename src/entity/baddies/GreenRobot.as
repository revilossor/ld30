package entity.baddies {
	import entity.AnimatedEntity;
	import entity.BehaviourEntity;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class GreenRobot extends AnimatedEntity
	{
		public function GreenRobot(xp:uint, yp:uint) 
		{
			super(xp, yp, Embed.green_robot_32x32, 32, 32, BehaviourEntity.STOP, BehaviourEntity.HORIZONTAL);
			immovable = false;
		}
		override public function update():void {
			super.update();
		}
		
	}

}