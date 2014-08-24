package states {
	import oli.Debug;
	import org.flixel.FlxSprite;
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
			add(new FlxSprite(0, 0, Embed.menu_bg));
			add(new FlxSprite(260, 200, Embed.pressEnter));
		}
		override public function update():void {
			super.update();
			if (FlxG.keys.justPressed('ENTER')) {
				FlxG.play(Embed.snd_mu);
				FlxG.fade(0xff000000, 1, gotoPlayState);
			}
		}
		private function gotoPlayState():void {
			FlxG.switchState(new PlayState());
		}
		
	}

}