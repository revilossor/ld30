package entity 
{
	import oli.steer.Steering;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class BehaviourEntity extends FlxSprite
	{
		public static const SEEK:String = 'seek';
		public static const STOP:String = 'stop';
		public static const FLEE:String = 'flee';
		public static const VERTICAL:String = 'vertical';
		public static const HORIZONTAL:String = 'horizontal';
		public static const BACK_DIAGONAL:String = 'backdiagonal';
		public static const FORWARD_DIAGONAL:String = 'forediagonal';
		
		private var _pauseBehaviour:String;
		private var _playBehaviour:String;
		
		public var _currentBehaviour:String;
		
		protected var _speed:Number = 2;
		public var _flip:Boolean = false;
		
		private var _boundsx:Boolean = false;
		private var _boundsy:Boolean = false;
		
		public function BehaviourEntity(xp:uint, yp:uint, pauseB:String, playB:String) 
		{
			super(xp, yp);
			_pauseBehaviour = pauseB;
			_playBehaviour = playB;	
			immovable = true;
			drag = new FlxPoint(20000, 20000);
		}
		override public function update():void {
			super.update();
			updateCurrentBehaviour();	
			handleEdges();
			performCurrentBehaviour();
		}
		public function setImmovableTrue():void {
			immovable = true;
		}
		public function setImmovableFalse():void {
			immovable = false;
		}
		private function handleEdges():void {
			if (_currentBehaviour == STOP) {
				if (x < 0) { x = 0; }
				if (x > FlxG.width - width) { x = FlxG.width - width; }
				if (y < 0) { y = 0; }
				if (y > FlxG.height - height) {	y = FlxG.height - height; }
			}else if (_currentBehaviour != SEEK && _currentBehaviour != FLEE) {
				if (x < 0) {
					_flip = !_flip;
					x = last.x;
				}
				if (x > FlxG.width - width) {
					_flip = !_flip;
					x = last.x;
				}
				if (y < 0) {
					_flip = !_flip;
					y = last.y;
				}
				if (y > FlxG.height - height) {
					_flip = !_flip;
					y = last.y;
				}
			}else if (_currentBehaviour == SEEK || _currentBehaviour == FLEE || _currentBehaviour == STOP) {
				_boundsx = _boundsy = false;
				if (x < 0) { x = last.x; _boundsx = true; }
				if (x > FlxG.width - width) { x = last.x; _boundsx = true;}
				if (y < 0) { y = last.y; _boundsy = true;}
				if (y > FlxG.height - height) {	y = last.y;	_boundsy = true;}
			}else {
				
			}
		}
		
		private function performCurrentBehaviour():void {
			switch(_currentBehaviour) {
				case STOP:
					x = last.x;
					y = last.y;
				break;
				case SEEK:
					var vs:FlxPoint = Steering.seekAtSpeed(getMidpoint(), Registry.PLAYER_POS, _speed)
					if (_boundsx) { vs.x = 0; }
					if (_boundsy) { vs.y = 0; }
					applyBehaviourMotion(vs);
				break;
				case FLEE:
					var vf:FlxPoint = Steering.fleeAtSpeed(getMidpoint(), Registry.PLAYER_POS, _speed)
					if (_boundsx) { vf.x = 0; }
					if (_boundsy) { vf.y = 0; }
					applyBehaviourMotion(vf);
				break;
				case VERTICAL:
					if (_flip) {
						applyBehaviourMotion(new FlxPoint(0, _speed));
					}else {
						applyBehaviourMotion(new FlxPoint(0, -_speed));
					}
				break;
				case HORIZONTAL:
					if (_flip) {
						applyBehaviourMotion(new FlxPoint(_speed, 0));
					}else {
						applyBehaviourMotion(new FlxPoint(-_speed, 0));
					}
				break;
				case BACK_DIAGONAL:
					if (_flip) {
						applyBehaviourMotion(new FlxPoint(_speed, _speed));
					}else {
						applyBehaviourMotion(new FlxPoint(-_speed, -_speed));
					}
				break;
				case FORWARD_DIAGONAL:
					if (_flip) {
						applyBehaviourMotion(new FlxPoint(-_speed, _speed));
					}else {
						applyBehaviourMotion(new FlxPoint(_speed, -_speed));
					}
				break;
			}
		}
		private function applyBehaviourMotion(motion:FlxPoint):void {
			x += motion.x;
			y += motion.y;
		}
		private function updateCurrentBehaviour():void {
			if (Registry.PAUSE_STATE == PauseButton.PAUSE) {
				_currentBehaviour = _pauseBehaviour;
				
			}else if (Registry.PAUSE_STATE == PauseButton.PLAY) {
				_currentBehaviour = _playBehaviour;
			}
		}
		
	}

}