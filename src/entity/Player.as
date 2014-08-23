package entity 
{
	import flash.events.WeakFunctionClosure;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 * 
	 * shoot if paused
	 * walk if active
	 * 
	 */
	public class Player extends FlxGroup
	{
		public var RIGHT_KEY:String;
		public var LEFT_KEY:String;
		public var UP_KEY:String;
		public var DOWN_KEY:String; 
		
		static public const SPRITEBOX:String = 		'sprite';
		static public const HITBOX:String = 		'hitbox';
		static public const OVERLAPBOX:String = 	'overlapbox';
		static public const CORE:String = 			'core';
		static public const WALK_LEFT:String = 		'walkLeft';
		static public const WALK_RIGHT:String = 	'walkRight';
		static public const WALK_UP:String = 		'walkUp';
		static public const WALK_DOWN:String = 		'walkDown';
		static public const SHOOT_UP:String = 		'shootUp';
		static public const SHOOT_DOWN:String = 	'shootDown';
		static public const SHOOT_LEFT:String = 	'shootLeft';
		static public const SHOOT_RIGHT:String = 	'shootRight';
		static public const STAND_UP:String = 		'standUp';
		static public const STAND_DOWN:String = 	'standDown';
		static public const STAND_LEFT:String = 	'standLeft';
		static public const STAND_RIGHT:String = 	'standRight';
		
		public var _sprite:FlxSprite;
		public var _hit:FlxSprite;
		public var _overlap:FlxSprite;
		private var _core:FlxSprite;
		
		private var x:Number;
		private var y:Number;
		
		private var _isWalking:Boolean = false;	public function set isWalking(value:Boolean):void { _isWalking = value; }
		private var _isFiring:Boolean = false;
		private var _doFire:Boolean = false;
		private var _lastPressed:uint;
		private var _shotCooldown:uint = 60;
		private var FIRE_RATE:uint = 60;
		
		static private const MAX_SPEED_MULTIPLIER:Number = 8;
		static private const MOVE_ACCELERATION:Object = {
			x:FlxG.width / 50,
			y:FlxG.height / 50
		};
		static private const MOVE_DRAG:Object = {
			x:FlxG.width / 500,
			y:FlxG.height / 500
		};
		
		public function Player(xp:uint, yp:uint) 
		{
			super();
			addEntity(CORE);
			addEntity(SPRITEBOX);
			addEntity(HITBOX);
			addEntity(OVERLAPBOX);
			assignKeys();
			_core.visible = _hit.visible = _overlap.visible = false;
		}
		
		private function addEntity(type:String):void {
			switch(type) {
				case CORE:
					add(_core = new FlxSprite());
					_core.makeGraphic(2, 2, 0xffffffff);
					setupCore();
				break
				case SPRITEBOX:
					add(_sprite = new FlxSprite());
					setupSpritebox();
				break;
				case HITBOX:
					add(_hit = new FlxSprite());
					_hit.makeGraphic(21, 50, 0xff00ff00);
				break;
				case OVERLAPBOX:
					add(_overlap = new FlxSprite());
					_overlap.makeGraphic(21, 3, 0xff0000ff);
				break;
			}
		}
		
		private function setupCore():void {
			_core.maxVelocity.x = MOVE_ACCELERATION.x * MAX_SPEED_MULTIPLIER;
			_core.maxVelocity.y = MOVE_ACCELERATION.y * MAX_SPEED_MULTIPLIER;
			_core.drag.x = MOVE_DRAG.x;
			_core.drag.y = MOVE_DRAG.y;
			_core.x = FlxG.width / 2 - _core.width;
			_core.y = FlxG.height / 2 - _core.height;
		}
		private function setupSpritebox():void {
			_sprite.loadGraphic(Embed.player_48x48, true, false, 48, 48);
			_sprite.addAnimation(WALK_LEFT,		[15, 16, 15, 17], 	8);
			_sprite.addAnimation(WALK_RIGHT,	[12, 11, 12, 10], 	8);
			_sprite.addAnimation(WALK_UP,		[0, 1, 0, 2], 		8);
			_sprite.addAnimation(WALK_DOWN,		[5, 6, 5, 7], 		7);
			_sprite.addAnimation(STAND_UP, 		[0]);
			_sprite.addAnimation(STAND_DOWN,	[5]);
			_sprite.addAnimation(STAND_LEFT,	[15]);
			_sprite.addAnimation(STAND_RIGHT,	[12]);
			_sprite.addAnimation(SHOOT_UP,		[3, 3, 3, 3], 10, false);
			_sprite.addAnimation(SHOOT_DOWN,	[8, 8, 8, 8], 10, false);
			_sprite.addAnimation(SHOOT_LEFT,	[14, 14, 14, 14], 10, false);
			_sprite.addAnimation(SHOOT_RIGHT,	[13, 13, 13, 13]);
			_sprite.play(STAND_DOWN);
		}
		private function assignKeys():void {
			UP_KEY = 'UP';
			DOWN_KEY = 'DOWN';
			LEFT_KEY = 'LEFT';
			RIGHT_KEY = 'RIGHT';
		}
		override public function update():void {
			keyHandling();
			alignEntityPosition();
			fireHandling();
			super.update();
		}
		
		private function fireHandling():void {
			if (_isFiring) {
				_shotCooldown--;
				if (_shotCooldown > FIRE_RATE - 10 && _isFiring) {
					if (Registry.PAUSE_STATE == PauseButton.PAUSE) {
						switch(_lastPressed) {
							case FlxObject.UP : 	_sprite.play(SHOOT_UP);	break;
							case FlxObject.DOWN : 	_sprite.play(SHOOT_DOWN);	break;
							case FlxObject.LEFT : 	_sprite.play(SHOOT_LEFT);	break;
							case FlxObject.RIGHT : 	_sprite.play(SHOOT_RIGHT);	break;
						}
					}
				}else if(_shotCooldown <= FIRE_RATE - 10 && _isFiring) {
					if (Registry.PAUSE_STATE == PauseButton.PAUSE) {
						switch(_lastPressed) {
							case FlxObject.UP : 	_sprite.play(STAND_UP);	break;
							case FlxObject.DOWN : 	_sprite.play(STAND_DOWN);	break;
							case FlxObject.LEFT : 	_sprite.play(STAND_LEFT);	break;
							case FlxObject.RIGHT : 	_sprite.play(STAND_RIGHT);	break;
						}	
					}
				}else {
					if (Registry.PAUSE_STATE == PauseButton.PLAY && !_isWalking) {
						switch(_lastPressed) {
							case FlxObject.UP : 	_sprite.play(STAND_UP);	break;
							case FlxObject.DOWN : 	_sprite.play(STAND_DOWN);	break;
							case FlxObject.LEFT : 	_sprite.play(STAND_LEFT);	break;
							case FlxObject.RIGHT : 	_sprite.play(STAND_RIGHT);	break;
						}	
					}
				}
				if (_shotCooldown == 0) {
					_isFiring = false;
					_shotCooldown = FIRE_RATE;
				}
			}
			if (_doFire) {
				fire();
			}
		}
		public function resetFiring():void {
			_isFiring = true;
			_shotCooldown = FIRE_RATE - 1;		
			_doFire = true;
		}
		private function keyHandling():void {
			if (FlxG.keys.justPressed(RIGHT_KEY)) 								{ right_pressed(); }
			if (FlxG.keys.pressed(RIGHT_KEY)) 									{ right_held(); }
			if (FlxG.keys.justReleased(RIGHT_KEY))							 	{ right_released(); }
			if (FlxG.keys.justPressed(LEFT_KEY)) 								{ left_pressed(); }
			if (FlxG.keys.pressed(LEFT_KEY)) 									{ left_held(); }
			if (FlxG.keys.justReleased(LEFT_KEY)) 								{ left_released(); }
			if (FlxG.keys.justPressed(UP_KEY)) 									{ up_pressed(); }
			if (FlxG.keys.pressed(UP_KEY)) 										{ up_held(); }
			if (FlxG.keys.justReleased(UP_KEY)) 								{ up_released(); }
			if (FlxG.keys.justPressed(DOWN_KEY)) 								{ down_pressed(); }
			if (FlxG.keys.pressed(DOWN_KEY)) 									{ down_held(); }
			if (FlxG.keys.justReleased(DOWN_KEY)) 								{ down_released(); }			
		}
		private function walk(direction:uint):void {
			if(Registry.PAUSE_STATE == PauseButton.PLAY){
				switch(direction) {
					case FlxObject.UP:	
					case FlxObject.DOWN:	applyForce(direction, MOVE_ACCELERATION.y);		break;
					case FlxObject.LEFT:	
					case FlxObject.RIGHT:	applyForce(direction, MOVE_ACCELERATION.x);		break;
				}
			}
		}
		private function applyForce(direction:uint, magnitude:Number):void {
			switch(direction) {
				case FlxObject.UP:
					if (_core.y < 0 +_hit.height/2 && _isWalking) { 
						stop(FlxObject.PATH_VERTICAL_ONLY);
						_core.y = 0 + _hit.height / 2;
					}
					else {
						_core.velocity.y -= magnitude;
					}
					if (!_isWalking) { _sprite.play(WALK_UP); }
				break;
				case FlxObject.DOWN:
					if (_core.y + _hit.height / 2 > FlxG.height&& _isWalking) {
						stop(FlxObject.PATH_VERTICAL_ONLY);
						_core.y = FlxG.height - _hit.height / 2;
					}
					else {
						_core.velocity.y += magnitude;
					}
					if (!_isWalking) { _sprite.play(WALK_DOWN); }
				break;					
				case FlxObject.LEFT:	
					if (_core.x < 0 + _hit.width - 3 && _isWalking) {
						stop(FlxObject.PATH_HORIZONTAL_ONLY);
						_core.x = 0 + _hit.width - 3;
					}
					else {
						_core.velocity.x -= magnitude;
					}
					if (!_isWalking) { _sprite.play(WALK_LEFT); }
				break;
				case FlxObject.RIGHT:	
					if (_core.x > FlxG.width - 3 && _isWalking) {
						stop(FlxObject.PATH_HORIZONTAL_ONLY);
						_core.x = FlxG.width - 3;
					}
					else {
						_core.velocity.x += magnitude;
					}
					if (!_isWalking) { _sprite.play(WALK_RIGHT); }
				break;
			}
			_isWalking = true;
		}
		private function tryToStop(direction:uint):void {
			if (!(FlxG.keys.pressed(UP_KEY)		|| 	FlxG.keys.pressed(DOWN_KEY))) 	{
				stop(FlxObject.PATH_VERTICAL_ONLY);
			}
			if (!(FlxG.keys.pressed(LEFT_KEY)	||	FlxG.keys.pressed(RIGHT_KEY))) 	{
				stop(FlxObject.PATH_HORIZONTAL_ONLY);
			}
		}
		public function stop(direction:uint = FlxObject.NONE):void {
			switch(direction) {
				case FlxObject.PATH_VERTICAL_ONLY : 
					_core.velocity.y = 0;
				break
				case FlxObject.PATH_HORIZONTAL_ONLY :
					_core.velocity.x = 0;
				break
				case FlxObject.NONE :
					_core.velocity.x = _core.velocity.y = 0;					
				break;
			}
		}
		private function alignEntityPosition():void {
			_sprite.x = 	_core.x - _sprite.width / 2 - 8;
			_sprite.y = 	_core.y - _sprite.height / 2;
			_hit.x = 		_core.x - _sprite.width / 2 + 7;
			_hit.y = 		_core.y - _sprite.height / 2;
			_overlap.x = 	_core.x - _sprite.width / 2 + 7;
			_overlap.y = 	_core.y + _sprite.height / 2 - 3;
			x =  			_core.x; 
			y = 			_core.y;
		}
		private function checkFire():void {
			if (_shotCooldown == FIRE_RATE) {
				_isFiring = true;
				_doFire = true;
				if (_shotCooldown < 10) {
					switch(_lastPressed) {
						case FlxObject.UP : 	_sprite.play(SHOOT_UP);	break;
						case FlxObject.DOWN : 	_sprite.play(SHOOT_DOWN);	break;
						case FlxObject.LEFT : 	_sprite.play(SHOOT_LEFT);	break;
						case FlxObject.RIGHT : 	_sprite.play(SHOOT_RIGHT);	break;
					}
				}
			}
		}
		private function fire():void {
			if(Registry.PAUSE_STATE == PauseButton.PAUSE){
				_doFire = false;
				switch(_lastPressed) {
					case FlxObject.UP:
						trace('only fire one up!');						
					break;
					case FlxObject.DOWN:
						trace('only fire one down!');
					break;
					case FlxObject.LEFT:
						trace('only fire one left!');
					break;
					case FlxObject.RIGHT:
						trace('only fire one right!');
					break;
				}
			}
		}
		
		private function up_released():void {
			tryToStop(FlxObject.PATH_VERTICAL_ONLY);
			if(Registry.PAUSE_STATE == PauseButton.PLAY){_sprite.play(STAND_UP);}
			_isWalking = false;
		}
		private function up_held():void {
			walk(FlxObject.UP);
			if (!_isWalking && Registry.PAUSE_STATE == PauseButton.PLAY) { _sprite.play(WALK_UP); }
			_isWalking = true;
			checkFire();
			_lastPressed = FlxObject.UP;
			if (Registry.PAUSE_STATE == PauseButton.PAUSE) { _sprite.play( STAND_UP ); }
		}
		private function up_pressed():void {
			checkFire();
			_lastPressed = FlxObject.UP;
		}
		
		private function down_released():void {
			tryToStop(FlxObject.PATH_VERTICAL_ONLY);
			if(Registry.PAUSE_STATE == PauseButton.PLAY){_sprite.play(STAND_DOWN);}
			_isWalking = false;
		}
		private function down_held():void {
			walk(FlxObject.DOWN);
			if (!_isWalking && Registry.PAUSE_STATE == PauseButton.PLAY) { _sprite.play(WALK_DOWN); } 
			_isWalking = true;
			checkFire();
			_lastPressed = FlxObject.DOWN;
			if (Registry.PAUSE_STATE == PauseButton.PAUSE) { _sprite.play( STAND_DOWN ); }
		}
		private function down_pressed():void {
			checkFire();
			_lastPressed = FlxObject.DOWN;
		}
		
		private function left_released():void {
			tryToStop(FlxObject.PATH_HORIZONTAL_ONLY);
			if(Registry.PAUSE_STATE == PauseButton.PLAY){_sprite.play(STAND_LEFT);}
			_isWalking = false;
		}
		private function left_held():void {
			walk(FlxObject.LEFT);
			if (!_isWalking && Registry.PAUSE_STATE == PauseButton.PLAY) { _sprite.play(WALK_LEFT); }
			_isWalking = true;
			checkFire();
			_lastPressed = FlxObject.LEFT;
			if (Registry.PAUSE_STATE == PauseButton.PAUSE) { _sprite.play( STAND_LEFT ); }
		}
		private function left_pressed():void {
			checkFire();
			_lastPressed = FlxObject.LEFT;
		}
		
		private function right_released():void {
			tryToStop(FlxObject.PATH_HORIZONTAL_ONLY);
			if(Registry.PAUSE_STATE == PauseButton.PLAY){_sprite.play(STAND_RIGHT);}
			_isWalking = false;
		}
		private function right_held():void {
			walk(FlxObject.RIGHT);
			if (!_isWalking && Registry.PAUSE_STATE == PauseButton.PLAY) { _sprite.play(WALK_RIGHT); } 
			_isWalking = true;
			checkFire();
			_lastPressed = FlxObject.RIGHT;
			if (Registry.PAUSE_STATE == PauseButton.PAUSE) { _sprite.play( STAND_RIGHT ); }
		}	
		private function right_pressed():void {
			checkFire();
			_lastPressed = FlxObject.RIGHT;
		}
	}
}