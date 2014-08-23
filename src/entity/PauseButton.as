package entity 
{
	import oli.Debug;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class PauseButton extends SinEntity
	{
		public static const PAUSE:String = 'pause';
		public static const PLAY:String = 'play';
		
		public function PauseButton() 
		{
			super(0,0,0.15,0.2);
			loadGraphic(Embed.pauseButton_128x128, true, false, 128, 128);
			x = 575;
			y = 295;
			addAnimation(PAUSE, [0]);
			addAnimation(PLAY, [1]);
		}
		public function set paused(value:String):void {
			if (value != Registry.PAUSE_STATE) { 
				switch(value) {
					case PAUSE: 
						FlxG.flash(0x88AA7F39, 0.6); 
					break;
					case PLAY: 
						FlxG.flash(0x8842AA39, 0.6); 
					break;
				} 
				alpha = 0.7; scale.x = scale.y = 1.3; t = 0; sin = 0;
			}
			play(Registry.PAUSE_STATE = value);
		} 
		override public function update():void {
			super.update();
			if (scale.x > 1) { 
				scale.x = scale.y -= 0.01; 
				if (alpha > 0.3) { alpha -= 0.028; }
			}else {
				alpha = 0.3 + sin;
			}
		}
		
	}

}