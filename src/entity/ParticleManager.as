package entity 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class ParticleManager extends FlxGroup
	{
		private var _allParticles:FlxGroup;
		
		public function ParticleManager() 
		{
			super();
			add(_allParticles = new FlxGroup());
		}
		override public function update():void {
			super.update();
	/*		for (var i:int = 0; i < _allParticles.length; i++) {
				if (!_allParticles.members[i].alive) {
					_allParticles.members[i].destroy();
					_allParticles.remove(_allParticles.members[i], true);
				}
			}
	*/	}
		public function addParticles(type:String, xp:uint, yp:uint, n:uint, col:uint, duration:uint):void {
			var vel:FlxPoint = new FlxPoint();
			var spread:Number = 200;
			for (var i:int = 0; i < n; i++) {
				_allParticles.add(new Particle(xp, yp, col, duration));
			}
		}
		
	}

}