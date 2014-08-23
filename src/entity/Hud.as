package entity 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Hud extends FlxGroup
	{
		private var _pauseButton:PauseButton;
		
		public function Hud() 
		{
			super();
			add(_pauseButton = new PauseButton());
		}
		
		public function set paused(v:String):void {
			_pauseButton.paused = v;
		}
		
		public function get pauseButton():PauseButton 
		{
			return _pauseButton;
		}
		
	}

}