package entity 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Hud extends FlxGroup
	{
		private var _pauseButton:PauseButton;
		private var _pointsText:FlxText;
		private var _grassText:FlxText;
		
		public function Hud() 
		{
			super();
			add(_pauseButton = new PauseButton());
			add(_pointsText = new FlxText(4, 0, 720, 'kills : ' + (Registry.carparkKills + Registry.savedGrassKills)));
			_pointsText.setFormat(null, 32, 0x88000000, 'left');
			add(_grassText = new FlxText(0, 0, 720, 'charge : ' + Registry.grassKills));
			_grassText.setFormat(null, 32, 0x88000000, 'right');
			_grassText.alpha = _pointsText.alpha = 0.5;
		}
		override public function update():void {
			super.update();
			if (Registry.PAUSE_STATE == PauseButton.PAUSE) {
				_grassText.text = 'charge : ' + Registry.grassKills;
				if (Registry.grassKills >= 2) {
					_grassText.color = 0x88ff00ff;
				}else {
					_grassText.color = 0x88000000;
				}
				_grassText.visible = true;
				_pointsText.visible = false;
			}else{
				_pointsText.text = 'kills : ' + (Registry.carparkKills + Registry.savedGrassKills);
				_pointsText.visible = true;
				_grassText.visible = false;
			}
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