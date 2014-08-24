package entity 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Background extends FlxGroup
	{
		private var grass:FlxSprite;
		private var carpark:FlxSprite;
		
		public function Background() 
		{
			super();
			add(grass = new FlxSprite(0, 0, Embed.grass));
			add(carpark = new FlxSprite(0, 0, Embed.carpark));
		}
		public function set isGrass(t:Boolean):void {
			carpark.visible = !t;
			grass.visible = t;
		}
		
	}

}