package xuewan.core
{
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import flashk.core.Singleton;
	
	public class StageManager
	{
		
		static public function get instance():StageManager
		{
			return Singleton.getInstanceOrCreate(StageManager) as StageManager;
		}
		
		private var _root:Sprite;
		
		private var _stage:Stage;
		
		
		public function StageManager()
		{
			
		}

		public static function get stage():Stage
		{
			return instance.stage;
		}
		
		public static function get stageWidth():int
		{
			return instance.stage.stageWidth;
		}
		
		public static function get stageHeight():int
		{
			return instance.stage.stageHeight;
		}
		
		public function initialize( stage:Stage,root:Sprite=null):void
		{
			_root = root;
			_stage = stage;
			_stage.align = StageAlign.TOP_LEFT;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		public function get root():Sprite
		{
			return _root;
		}
		
		public function set root( value:Sprite ):void
		{
			_root = value;
		}
		
		public function get stage():Stage
		{
			return _stage;
		}
		
		public function set stage( value:Stage ):void
		{
			_stage = value;
		}
	}
}