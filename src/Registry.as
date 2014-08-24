package  {
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Registry 
	{
		public static var PAUSE_STATE:String;
		public static var PLAYER_POS:FlxPoint;
		public static var grassKills:uint = 0;
		public static var savedGrassKills:int = 0;
		public static var carparkKills:uint = 0;
		public static function reset():void {
			grassKills = 0;
			carparkKills = 0;
			savedGrassKills = 0;
		}
	}

}