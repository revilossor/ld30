package entity 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class SinEntity extends FlxSprite
	{
		protected var t:uint;
		protected var sin:Number;
		protected var amplitude:Number;
		protected var frequency:Number;   
		
		public function SinEntity(xp:uint, yp:uint, f:Number, a:Number) 
		{
			super(xp, yp);
			amplitude = a;
			frequency = f;
		}
		override public function update():void {
			super.update();
			sin = amplitude * Math.sin((frequency*++t));
		}
		public function resetSin():void {
			t = 0;
		}
	}

}