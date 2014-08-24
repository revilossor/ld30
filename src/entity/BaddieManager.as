package entity 
{
	import entity.baddies.BlueGoblin;
	import entity.baddies.BlueRobot;
	import entity.baddies.GreenGoblin;
	import entity.baddies.GreenRobot;
	import entity.baddies.RedGoblin;
	import entity.baddies.RedRobot;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class BaddieManager extends FlxGroup
	{
		public var goblins:FlxGroup;
		public var robots:FlxGroup;
		
		private var spawners:FlxGroup;
		
		public var allBaddies:FlxGroup;
		
		public function BaddieManager() 
		{
			super();
			allBaddies = new FlxGroup();
			initGoblins();
			add(allBaddies);
		}
		private function initGoblins():void {
			
			allBaddies.add(goblins = new FlxGroup());
			allBaddies.add(robots = new FlxGroup());
			allBaddies.add(spawners = new FlxGroup());
		//	addGoblin('r', 680, 400);
	//		addRowOfGoblins('h', 100, 2);
		//	addRowOfGoblins('v', 220, 1, 200, 50);
		//	addPackOfGoblins('b', 600, 400);
	//		addRobot('r', 32, 32);
		//	addRowOfRobots('h', 40, 4);
		//	addRowOfRobots('v', 40, 3);
			//addPackOfRobots('g', 30, 30);
		}
		private function spawn(t:String, xp:uint, yp:uint):void {
			trace('*** spawn ' + t + ' at ' + xp + ', ' + yp);
			spawners.add(new Spawner(t, xp, yp));
		}
		public function addRobot(type:String, xp:uint, yp:uint):void {
			switch (type) {
				case 'g':
					robots.add(new GreenRobot(xp, yp));
				break;
				case 'b':
					robots.add(new BlueRobot(xp, yp));
				break;
				case 'r':
					trace('*** spawn red robot');
					robots.add(new RedRobot(xp, yp));
				break;
				default:
			}	 
		}
		public function addPackOfRobots(type:String, xp:uint, yp:uint):void {
			switch (type) 
			{
				case 'g':
					robots.add(new GreenRobot(xp-32, yp-32));
					robots.add(new GreenRobot(xp, yp-32));
					robots.add(new GreenRobot(xp-32, yp));
					robots.add(new GreenRobot( xp, yp));
				break;
			case 'b':
					robots.add(new BlueRobot(xp-32, yp-32));
					robots.add(new BlueRobot( xp, yp-32));
					robots.add(new BlueRobot(xp-32, yp));
					robots.add(new BlueRobot(xp, yp));
				break;
				case 'r':
					robots.add(new RedRobot(xp-32, yp-32));
					robots.add(new RedRobot(xp, yp-32));
					robots.add(new RedRobot(xp-32, yp));
					robots.add(new RedRobot(xp, yp));
				break;
				default:
			}
		}
		public function addRowOfRobots(orientation:String, position:uint, skip:uint = 0, preOff:uint = 0, postOff:uint = 0):void {
			var objectSize:uint = 32;
			var sc:int = skip;
			if (orientation == 'h') {
				var n:uint = Math.floor(FlxG.width-preOff - postOff) / objectSize;
				for (var i:int = 0; i < n; i++) {
					if(sc-- == 0){
						robots.add(new BlueRobot(preOff + objectSize * i, position));
						sc = skip;
					}
				}
			}else if (orientation == 'v') {
				var nu:uint = Math.floor(FlxG.height-preOff-postOff) / objectSize;
				for (var j:int = 0; j < nu; j++) {
					if(sc-- == 0){
						robots.add(new GreenRobot(position, preOff+objectSize * j));
						sc = skip;
					}
				}
			}
		}
		public function addGoblin(type:String, xp:uint, yp:uint):void {
			switch (type) 
			{
				case 'g':
					goblins.add(new GreenGoblin(xp, yp));
				break;
				case 'b':
					goblins.add(new BlueGoblin(xp, yp));
				break;
				case 'r':
					goblins.add(new RedGoblin(xp, yp));
				break;
				default:
			}	 
		}
		public function addPackOfGoblins(type:String, xp:uint, yp:uint):void {
			switch (type) 
			{
				case 'g':
					goblins.add(new GreenGoblin(xp-32, yp-32));
					goblins.add(new GreenGoblin(xp, yp-32));
					goblins.add(new GreenGoblin(xp-32, yp));
					goblins.add(new GreenGoblin(xp, yp));
				break;
				case 'b':
					goblins.add(new BlueGoblin(xp-32, yp-32));
					goblins.add(new BlueGoblin(xp, yp-32));
					goblins.add(new BlueGoblin(xp-32, yp));
					goblins.add(new BlueGoblin(xp, yp));
				break;
				case 'r':
					goblins.add(new RedGoblin(xp-32, yp-32));
					goblins.add(new RedGoblin(xp, yp-32));
					goblins.add(new RedGoblin(xp-32, yp));
					goblins.add(new RedGoblin(xp, yp));
				break;
				default:
			}
		}
		public function addRowOfGoblins(orientation:String, position:uint, skip:uint = 0, preOff:uint = 0, postOff:uint = 0):void {
			var objectSize:uint = 32;
			var sc:int = skip;
			if (orientation == 'h') {
				var n:uint = Math.floor(FlxG.width-preOff - postOff) / objectSize;
				for (var i:int = 0; i < n; i++) {
					if(sc-- == 0){
						goblins.add(new BlueGoblin(preOff + objectSize * i, position));
						sc = skip;
					}
				}
			}else if (orientation == 'v') {
				var nu:uint = Math.floor(FlxG.height-preOff-postOff) / objectSize;
				for (var j:int = 0; j < nu; j++) {
					if(sc-- == 0){
						goblins.add(new GreenGoblin(position, preOff+objectSize * j));
						sc = skip;
					}
				}
			}
		}
		override public function update():void {
			super.update();
			cleanup(goblins);
			cleanup(robots);
			cleanup(spawners);
			FlxG.overlap(goblins, robots, goblinHitRobot);
			FlxG.overlap(goblins, goblins, goblinHitRobot);
			FlxG.overlap(robots, robots, robotHitGoblin);
			updateSpawners();
		}
		private function updateSpawners():void {
			var thisSpawner:Spawner;
			for (var i:int = 0; i < spawners.length; i++) {
				thisSpawner = spawners.members[i] as Spawner;
				if (thisSpawner.isfinished) {
					trace('spwner finished'); 
					switch(thisSpawner.type) {
						case 'gg':	goblins.add(new GreenGoblin(thisSpawner.x, thisSpawner.y));	break;
						case 'rg':	goblins.add(new RedGoblin(thisSpawner.x, thisSpawner.x));		break;
						case 'bg':	goblins.add(new BlueGoblin(thisSpawner.x, thisSpawner.x));	break;
						case 'gr':	robots.add(new GreenRobot(thisSpawner.x, thisSpawner.x));		break;
						case 'rr':	robots.add(new RedRobot(thisSpawner.x, thisSpawner.x));		break;
						case 'br':	robots.add(new BlueRobot(thisSpawner.x, thisSpawner.x));		break;
					}
					thisSpawner.kill();
				}
			}
			
		}
		
		private function robotHitGoblin(r:AnimatedEntity, g:AnimatedEntity):void 
		{
			FlxObject.separate(r, g);
			g._flip = true;
		
		}
		private function goblinHitRobot(g:AnimatedEntity, r:AnimatedEntity):void 
		{
			FlxObject.separate(g, r);
		}
		private function cleanup(group:FlxGroup):void {
			for (var i:int = 0; i < group.length; i++) {
				if (!group.members[i].alive) {
					group.members[i].destroy();
					group.remove(group.members[i], true);
				}
			}
		}
	}

}