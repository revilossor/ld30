package entity 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Bomb extends SinEntity
	{
		private var baseSize:uint = 60;
		private var dur:uint = 15;
		public var deadly:Boolean = true;
		
		public function Bomb(xp:uint, yp:uint, mag:uint) 
		{
			if (mag == 1) { mag = 2; }
			super(xp - ((mag * baseSize) / 2), yp - ((mag * baseSize) / 2), 2, 0.01);
			var si:Number = (mag * baseSize);
			makeGraphic(si, si, 0x99ff00ff);	
		}
		override public function update():void {
			super.update();
			if (t > 3) {
				alpha *= 0.5;
				deadly = false;
				scale.x = scale.y += Math.abs(sin*5); 
				alpha -= Math.abs(sin * 0.6);
			}
			if (t > dur) {
				kill();
			}
		}
		
	}

}