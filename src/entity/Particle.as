package entity 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Particle extends FlxSprite 
	{
		private var dur:int;
		private var c:int;
		private var r:int;
		
		
		public function Particle(xp:uint, yp:uint, col:uint, d:int) 
		{
			super(xp, yp);
			makeGraphic(4, 4, col);
			dur = c = d;
			velocity.x = -50 + (Math.random() * 100);
			velocity.y = -(250 + (Math.random() * 100));
			acceleration = new FlxPoint(0, 800);
			r = Math.round(Math.random() * 5);
		}
		override public function update():void {
			super.update();
			if (--c <= 0) {
				kill();
			}
			if (c == dur - (22+r)) { velocity.x = velocity.y = 0; acceleration.y = 0; }
			alpha = c / dur;
		}
		
	}

}