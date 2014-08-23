package 
{
	import flash.events.Event;
	import oli.Debug;
	import Registry;
	import states.InitState;
	import org.flixel.FlxGame;
	
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Main extends FlxGame
	{
		
		public function Main():void 
		{
			super(720, 440, InitState, 1, 30, 30, true);
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Debug.log(this, 'init');
		}
		
		
	}
	
}