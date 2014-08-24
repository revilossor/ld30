package entity 
{
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Bullet extends FlxSprite
	{
		private static const speed:uint = 300;
		
		public function Bullet(xp:Number, yp:Number, dir:uint) 
		{
			super(xp, yp, Embed.bullet);
			x = xp - width / 2;
			y = yp - height / 2;
			switch (dir) 
			{
				case FlxObject.UP:
					velocity.x = 0;
					velocity.y = -speed;
					x += 7;
					y -= 5;
				break;
				case FlxObject.DOWN:
					velocity.x = 0;
					velocity.y = speed;
					x += 7;
					y += 5;
				break;
				case FlxObject.LEFT:
					velocity.x = -speed;
					velocity.y = 0;
					x -= 15;
					y -= 7;
				break;
				case FlxObject.RIGHT:
					velocity.x = speed;
					velocity.y = 0;
					x += 15;
					y -= 7;
				break;
				default:
				
				break;
			}
		}
		override public function update():void {
			super.update();
			if (x < -width || x > FlxG.width || y < -height || y > FlxG.height) {
				makeDead();
			}
		}
		public function makeDead():void {
			this.kill();
		}
		
	}

}