package states 
{
	import oli.states.AbstractState;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class DeathState extends AbstractState
	{
	
		private var _grassText:FlxText;
		private var _carText:FlxText;
		private var _totText:FlxText;
		
		
		public function DeathState() 
		{
			super();
		}
		override public function create():void {
			super.create();
			add(new FlxSprite(0, 0, Embed.gover_bg));
			add(new FlxSprite(260, 370, Embed.pressEnter));
			add(_grassText = new FlxText(345, 202, 500, ''+Registry.savedGrassKills));
			_grassText.setFormat(null, 32, 0xff8B0602, 'left');
			add(_carText = new FlxText(345, 240, 500, ''+Registry.carparkKills));
			_carText.setFormat(null, 32, 0xff8B0602, 'left');
			add(_totText = new FlxText(125, 310, 500, ''+(Registry.savedGrassKills+Registry.carparkKills)));
			_totText.setFormat(null, 32, 0xffCE0704, 'left');
		}
		override public function update():void {
			super.update();
			if (FlxG.keys.justReleased('ENTER')) {
				FlxG.play(Embed.snd_mu);
				FlxG.fade(0xff000000, 1, gotoPlayState);
			}
		}
		private function gotoPlayState():void {
			FlxG.switchState(new PlayState());
		}
	}

}