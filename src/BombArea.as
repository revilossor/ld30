package  
{
	import entity.Bomb;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class BombArea extends FlxGroup
	{
		public var allBombs:FlxGroup;
		
		public function BombArea() 
		{
			super();
			add(allBombs = new FlxGroup());
		}
		public function addBomb(xp:Number, yp:Number, mag:Number):void {
			allBombs.add(new Bomb(xp, yp, mag));
		}
		override public function update():void {
			super.update();
			for (var i:int = 0; i < allBombs.length; i++) {
				if (!allBombs.members[i].alive) {
					allBombs.members[i].destroy();
					allBombs.remove(allBombs.members[i], true);
				}
			}
		}
		
	}

}