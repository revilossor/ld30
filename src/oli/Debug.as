package oli 
{
	import flash.external.ExternalInterface;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Oliver Ross
	 */
	public class Debug 
	{
		public static var ENABLED:Boolean = true;
		
		public static function log(from:*, message:String):void {	
			if (ENABLED) {
				var message:String = '[' + getQualifiedClassName(from) + '] ' + message;
				if (ExternalInterface.available) { ExternalInterface.call('console.log', message); }
				trace("[" + getQualifiedClassName(from) + "] " + message); 
			}
		}
		public static function error(from:*, message:String):void {	
			log(from, '\t!ERROR!\t' + message);
		}
		public static function spawn(from:*, message:String):void {	
			log(from, '\t<spawn>\t' + message);
		}
		public static function state(from:*, message:String):void {	
			log(from, '\t<state>\t' + message);	
		}
		public static function hit(from:*, first:*, second:*):void {	
			log(from, '\t<hit>\t' + getQualifiedClassName(first) + ' and ' + getQualifiedClassName(second));
		}	
	}

}