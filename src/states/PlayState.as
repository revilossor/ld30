package states 
{
	import entity.AnimatedEntity;
	import entity.Background;
	import entity.BaddieManager;
	import entity.baddies.BlueGoblin;
	import entity.baddies.BlueRobot;
	import entity.baddies.GreenGoblin;
	import entity.baddies.GreenRobot;
	import entity.baddies.RedGoblin;
	import entity.baddies.RedRobot;
	import entity.BehaviourEntity;
	import entity.Bomb;
	import entity.Bullet;
	import entity.Hud;
	import entity.ParticleManager;
	import entity.PauseButton;
	import entity.Player;
	import entity.Spawner;
	import oli.states.AbstractState;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class PlayState extends AbstractState
	{
		private var _player:Player;
		private var _hud:Hud;
		private var _baddies:BaddieManager;
		private var _particles:ParticleManager;
		private var _background:Background;
		private var _bombs:BombArea;
		
		public static var PAUSE_KEY:String = 'SPACE';
		
		private var b:Boolean = false;
		private var BOMB_THRESHOLD:uint = 2;
		
		private var t:uint = 80;
		
		public function set paused(v:Boolean):void { v?_hud.paused = PauseButton.PAUSE:_hud.paused = PauseButton.PLAY; }
		
		public function PlayState() 
		{
			super();
			Registry.reset();
			FlxG.bgColor = 0xff363632;
			addEntities();
		}
		private function addEntities():void {
			add(_background = new Background());
			addBaddies();
			_player = new Player(FlxG.width / 2, FlxG.height / 2);
			add(_player.bullets);
			add(_player);
			add(_bombs = new BombArea());
			addHud();
			add(_particles = new ParticleManager());
		}
		private function addBaddies():void {
			add(_baddies = new BaddieManager());
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
			updateRegistry();
			handleColission();
			t++;
			if (t % 126 == 0) {
				switch (Math.round(Math.random())) {
					case 0 :
						_baddies.addGoblin(getRandomColour(), Math.random() * FlxG.width - 32, Math.random() * FlxG.height - 32);
					break;
					default:
						_baddies.addRobot(getRandomColour(), Math.random() * FlxG.width - 32, Math.random() * FlxG.height - 32);
					break;
				}
			}
			if (t % 211 == 0) {
				switch (Math.round(Math.random())) {
					case 0 :
						_baddies.addGoblin('r', Math.random() * FlxG.width - 32, Math.random() * FlxG.height - 32);
					break;
					default:
						_baddies.addRobot('r', Math.random() * FlxG.width - 32, Math.random() * FlxG.height - 32);
					break;
				}
			}
			if (t % 351 == 0) {
				switch (Math.round(Math.random())) {
					case 0 :
						_baddies.addRowOfGoblins(getRandomOrientation(),Math.round(Math.random() * 400), Math.round(Math.random() * 5), Math.round(Math.random() * 200), Math.round(Math.random() * 200));
					break;
					default:
						_baddies.addRowOfRobots(getRandomOrientation(), Math.round(Math.random() * 400), Math.round(Math.random() * 5), Math.round(Math.random() * 200), Math.round(Math.random() * 200));
					break;
				}
			}
			if (t % 421 == 0) {
				switch (Math.round(Math.random())) {
					case 0 :
						_baddies.addPackOfGoblins(getRandomColour(),Math.random() * FlxG.width - 32, Math.random() * FlxG.height - 32);
					break;
					default:
						_baddies.addPackOfRobots(getRandomColour(),Math.random() * FlxG.width - 32, Math.random() * FlxG.height - 32);
					break;
				}
			}
		}
		private function getRandomColour():String {
			var m:int = Math.round(Math.random() * 4);
			switch (m) {
				case 0:
					return 'b';
				break;
				case 1:
					return 'g';
				break;
				case 2:
					return 'b';
				break;
				case 3:
					return 'g';
				break;
				default:
			}
			return 'r';
		}
		private function getRandomOrientation():String {
			var m:int = Math.round(Math.random() * 4);
			switch (m) {
				case 0:
					return 'h';
				break;
				case 1:
					return 'v';
				break;
				case 2:
					return 'h';
				break;
				case 3:
					return 'v';
				break;
				default:
			}
			return 'h';
		}
		private function handleColission():void {
			FlxG.collide(_player._core, _baddies, playerHitBaddie);
			FlxG.overlap(_player.bullets, _baddies, bulletHitBaddie);
			FlxG.overlap(_bombs.allBombs, _baddies.robots, bombHitRobot);
		}
		
		private function bombHitRobot(bo:FlxSprite, ro:AnimatedEntity):void {
			var bomb:Bomb = bo as Bomb;
			if (!bomb.deadly) { return; }
			if (ro._currentBehaviour == BehaviourEntity.STOP) {
			}else {
				_particles.addParticles('blood', ro.getMidpoint().x, ro.y + ro.height, 20, 0xff000088, 40);
				ro.kill();
				FlxG.play(Embed.snd_bd, 1.0)
				Registry.carparkKills++;
				trace('carpark kills : ' + Registry.carparkKills);
			}
		}
		private function bulletHitBaddie(bl:FlxSprite, bd:AnimatedEntity):void {
			var bullet:Bullet = bl as Bullet;
			bullet.makeDead();
			if (bd._currentBehaviour == BehaviourEntity.STOP) {
			}else {
				if (bd is GreenGoblin || bd is RedGoblin || bd is BlueGoblin){
					_particles.addParticles('blood', bd.getMidpoint().x, bd.y + bd.height, 20, 0xffff0000, 40);
				}else {
					_particles.addParticles('blood', bd.getMidpoint().x, bd.y + bd.height, 20, 0xff000088, 40);
				}
				bd.kill();
				FlxG.play(Embed.snd_bd, 1.0);
				Registry.grassKills++;
				Registry.savedGrassKills++;
				trace('grass kills : ' + Registry.grassKills);
			}
		}
		private function playerHitBaddie(pl:FlxSprite, bd:AnimatedEntity):void {
			if (bd._currentBehaviour == BehaviourEntity.STOP) {
				
			}else{
				playerDie();
			}
		}
		private function playerDie():void {
			_player.kill();
			FlxG.play(Embed.snd_pd, 1.0);
			_particles.addParticles('blood',  _player._core.getMidpoint().x, _player._core.y + _player._core.height, 20, 0xff880000, 40);
			FlxG.fade(0xff000000, 1,gotoDeathState);
		}
		private function gotoDeathState():void {
			FlxG.switchState(new DeathState());
		}
		private function updateRegistry():void {
			Registry.PLAYER_POS = _player._sprite.getMidpoint()
		}
		private function keyHandling():void {
			if (FlxG.keys.pressed(PAUSE_KEY)) {
				paused = _background.isGrass = true;
				_baddies.robots.callAll('setImmovableTrue');
				_baddies.goblins.callAll('setImmovableFalse');
			} else {
				paused = _background.isGrass = false;
				_player.bullets.callAll('kill', true);
				_baddies.robots.callAll('setImmovableFalse');
				_baddies.goblins.callAll('setImmovableTrue');
				checkBomb();
			}
			if (FlxG.keys.justReleased(PAUSE_KEY) || FlxG.keys.justPressed(PAUSE_KEY)) {
				_player.stop();
				_player.isWalking = false;
				_player.resetFiring();
				b = true;
			}
		}
		private function checkBomb():void {
			if(b){
				trace('check bomb - grass kills : ' +Registry.grassKills);
				b = false;
				if (Registry.grassKills >= BOMB_THRESHOLD) {
					trace('do bomb');
					doBomb(Registry.grassKills);
				}
				trace('grasskills : ' + Registry.grassKills);
			}
		}
		
		private function doBomb(grassKills:uint):void {
			_bombs.addBomb(_player._core.getMidpoint().x, _player._core.getMidpoint().y, Registry.grassKills);
			Registry.grassKills = 0;
			trace('spawn kill area of : ' + grassKills);
			
		}
		
		
	}

}