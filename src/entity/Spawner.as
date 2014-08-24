package entity 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Spawner extends SinEntity
	{
		public var type:String; 
		public var c:uint;
		
		public static const TIME:uint = 20;
			
		private var _isFinished:Boolean = false;
		
		public function Spawner(t:String, xp:uint, yp:uint) 
		{
			super(xp, yp, 0.5, 0.1);
			if (t == 'rg' || t == 'bg' || t == 'gg') {
				loadGraphic(Embed.goblinSpawner, true, false, 32, 32);
			}else {
				loadGraphic(Embed.robotSpawner, true, false, 32, 32);
			}
			type = t;
			addAnimation('idle', [0, 0, 0, 1, 2, 3], 8, false);
			play('idle');
			alpha = 0.01;
		}
		override public function update():void {
			super.update();
			alpha += Math.abs(sin*0.3); 
			scale.x = scale.y = 1 + sin;
			if (c++ == TIME) {
				_isFinished = true;
				kill();
			}else {
				_isFinished = false;
			}
			angle++;
		}
		public function get isfinished():Boolean {
			return _isFinished;
		}
		public function set isfinished(v:Boolean):void {
			_isFinished = v;
		}
		
	}

}