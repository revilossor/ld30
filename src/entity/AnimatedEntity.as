package entity 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class AnimatedEntity extends BehaviourEntity
	{
		private static const WALK_UP:String = 'walkup';
		private static const WALK_DOWN:String = 'walkdown';
		private static const WALK_LEFT:String = 'walkleft';
		private static const WALK_RIGHT:String = 'walkright';
		private static const STAND_UP:String = 'standup';
		private static const STAND_DOWN:String = 'standdown';
		private static const STAND_LEFT:String = 'standleft';
		private static const STAND_RIGHT:String = 'standright';
		private static const STATUE:String = 'statue';
		
		public function AnimatedEntity(xp:uint, yp:uint, img:Class, w:uint, h:uint, pauseB:String, playB:String) 
		{
			super(xp, yp, pauseB, playB);
			init(img, w, h);
		}
		protected function init(img:Class, w:uint, h:uint):void {
			loadGraphic(img, true, false, w, h);
			addAnimation(WALK_UP, [2, 1, 2, 0], 9);
			addAnimation(WALK_DOWN, [3, 4, 3, 5], 9);
			addAnimation(WALK_LEFT, [8, 7, 8, 6], 9);
			addAnimation(WALK_RIGHT, [9, 10, 9, 11], 9);
			addAnimation(STAND_UP, [2]);
			addAnimation(STAND_DOWN, [3]);
			addAnimation(STAND_LEFT, [8]);
			addAnimation(STAND_RIGHT, [9]);
			addAnimation(STATUE, [15]);
			play(STAND_DOWN);
		}
		override public function update():void {
			super.update();
			animationHandling();
		}
		private function animationHandling():void {
			if(_currentBehaviour == STOP){
				play(STATUE);
				return;
			}
			var vel:FlxPoint = new FlxPoint();
			vel.x = x - last.x;
			vel.y = y - last.y;
			if (Math.abs(vel.y) > Math.abs(vel.x) && vel.y < 0) {
				play(WALK_UP);
			}else if (Math.abs(vel.y) > Math.abs(vel.x) && vel.y > 0) {
				play(WALK_DOWN);
			}else if (Math.abs(vel.x) > Math.abs(vel.y) && vel.x < 0) {
				play(WALK_LEFT);
			}else if (Math.abs(vel.x) > Math.abs(vel.y) && vel.x > 0) {
				play(WALK_RIGHT);
			}else{
				play(STAND_DOWN);
			}
			
		}
		
	}

}