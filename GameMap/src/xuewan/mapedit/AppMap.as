package xuewan.mapedit
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import xuewan.core.StageManager;

	public class AppMap
	{
		public function AppMap()
		{
		}
		public static function initialize(stage:Stage,root:Sprite=null):void
		{
			StageManager.instance.initialize(stage,root);
		}
	}
}