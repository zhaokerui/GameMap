package xuewan.mapedit.layer
{
	import flash.display.Sprite;
	/**
	 * 路径节点 
	 * @author leo
	 * 
	 */	
	public class PathPoint extends Sprite
	{
		public var pointWidth :int = 20;
		public var pointHeight :int = 20;
		public var pointRadius :int = 10;
		private var ary:Array=[0,0,0x789799,0x852147,0x335689];
		public function PathPoint(type:uint)
		{
			super();
			this.graphics.beginFill(ary[type]);
			this.graphics.drawCircle(10,10,pointRadius);
			this.graphics.endFill();
		}
	}
}