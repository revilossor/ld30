package oli.flx 
{
	import flash.display.Bitmap;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class FlxBitmapSprite extends FlxSprite
	{
		public var bitmap:Bitmap;
		
		public function FlxBitmapSprite(xp:Number, yp:Number, src:Bitmap = null, isActive:Boolean = false) 
		{
			super(xp, yp);
			active = isActive;
			if (src != null){
				bitmap = src;
				pixels = bitmap.bitmapData;
			}
		}
		override public function update():void {
			super.update();
		}
	}

}