package states 
{
	import entity.Hud;
	import entity.PauseButton;
	import entity.Player;
	import oli.states.AbstractState;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class PlayState extends AbstractState
	{
		private var _player:Player;
		private var _hud:Hud;
		
		public static var PAUSE_KEY:String = 'SPACE';
		public function set paused(v:Boolean):void { v?_hud.paused = PauseButton.PAUSE:_hud.paused = PauseButton.PLAY; }
		
		public function PlayState() 
		{
			super();
			FlxG.bgColor = 0xff2c2c2c;
			addEntities();
		}
		private function addEntities():void {
			addPlayer();
			addHud();
		}
		private function addPlayer():void {
			add(_player = new Player(FlxG.width / 2, FlxG.height / 2));
		}
		private function addHud():void {
			add(_hud = new Hud());
		}
		override public function update():void {
			super.update();
			keyHandling();
		}
		
		private function keyHandling():void {
			if (FlxG.keys.pressed(PAUSE_KEY)) {
				paused = true;
			} else {
				paused = false;
			}
			if (FlxG.keys.justReleased(PAUSE_KEY) || FlxG.keys.justPressed(PAUSE_KEY)) {
				_player.stop();
				_player.isWalking = false;
				_player.resetFiring();
			}
		}
		
		
	}

}