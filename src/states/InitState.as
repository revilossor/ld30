package states {
	import oli.Debug;
	import Registry;
	import oli.states.AbstractState;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class InitState extends AbstractState
	{
		public function InitState() 
		{
			super();
		}
		override public function create():void {
			super.create();
			FlxG.bgColor = 0xffff00ff;
			Debug.log(this, 'init complete');
			gotoPlayState();
		}
		
		private function gotoPlayState():void {
			FlxG.switchState(new PlayState());
		}
		
	}

}