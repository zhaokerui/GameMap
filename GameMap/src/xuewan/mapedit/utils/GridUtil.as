package xuewan.mapedit.utils
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import flashk.utils.Geom;
	
	/**
	 * 45度场景相关
	 * @author kerry
	 * 
	 */
	public final class GridUtil
	{
		/**
		 * 最大横坐标
		 */
		public static var maxi:int = 10000;
		
		private static var _wh:Number;
		private static var _width:uint;
		private static var _height:uint;
		private static var _tileWidth:uint;
		private static var _tileHeight:uint;
		private static var _topX:int;
		private static var _topY:int;
		
		public static function get wh():Number
		{
			return _wh
		}
		public static function get width():uint
		{
			return _width;
		}
		public static function get height():uint
		{
			return _height;
		}
		public static function get tileHeight():uint
		{
			return _tileHeight;
		}

		public static function get tileWidth():uint
		{
			return _tileWidth;
		}

		public static function get topY():int
		{
			return _topY;
		}

		public static function get topX():int
		{
			return _topX;
		}
		
		
		/**
		 * 设置单个格子的大小
		 * @param w
		 * @param h
		 * 
		 */
		public static function setContentSize(w:uint,h:uint,tw:uint,th:uint):void
		{
			_width = w;
			_height = h;
			_tileWidth =tw;
			_tileHeight =th;
			_wh = tw / th;
			_topX = w*tw/2;
			_topY = -h*th/2;
		}
		
		/**
		 * 获得屏幕上点的方块索引坐标 
		 * @param p
		 * @param width
		 * @param height
		 * @return 
		 * 
		 */
		public static function getGridPoint(px:Number,py:Number,type:uint):Point
		{
			if(type==1)
			{
				//Rhombus 菱形
				return new Point(int((px + py * wh) / _tileWidth), int((py - px/wh) / _tileHeight)); 
			}else{
				//square 方形
				var i:int = Math.round((py*tileWidth -px*tileHeight )/tileHeight /tileWidth - topY/tileHeight  + topX/tileWidth  - 1/2);
				var j:int = Math.round(px / tileWidth + py / tileHeight - topX / tileWidth - topY / tileHeight + 1 / 2)-1;
				return new Point(i,j);
			}
			
		}
		private static const UNIT_LENGTH:Number = Math.sqrt (5) * 10;
		public static function getTileFromLocationBySquare(x:Number,y:Number):Point
		{
			var pos:Point = new Point ();
			
//			var sx:Number = x;
//			var sy:Number = -y;
//			var tx:Number = sx * 0.5 + sy - tileHeight*height;
//			var ty:Number = tx * 0.5;
//			var column:Number = Math.sqrt (tx * tx + ty * ty) / UNIT_LENGTH;
//			tx = sx / 2 - sy +  tileHeight*height;
//			ty = -tx / 2;
//			var row:Number = Math.sqrt (tx * tx + ty * ty) / UNIT_LENGTH;
//			pos.x = int(row + 0.000001);
//			pos.y = int(column + 0.000001);
			
			return pos;
		}
		
		/**
		 * 从45度显示坐标换算为90度数据坐标
		 * @param p
		 * @return 
		 * 
		 */
		public static function trans45To90(p:Point):Point
		{
			return new Point(p.x + p.y * wh,p.y - p.x/wh);
		}
		
		/**
		 * 从90度数据坐标换算为45度显示坐标
		 * @param p
		 * @return 
		 * 
		 */
		public static function trans90To45(p:Point):Point
		{
			return new Point((p.x - p.y * wh)/2,(p.x / wh + p.y)/2);
		}
		public static function transStageToLogiByStaggered(stage:Point):Point
		{
			var logic : Point = new Point; 
			logic.y = ( 2 * stage.y ) / tileHeight; 
			logic.x = ( stage.x / tileWidth ) - ( logic.y & 1 ) * ( tileWidth / 2 ); 
			return logic; 
		}
		public static function transLogicToStageByStaggered(logic:Point):Point
		{
			var stage : Point = new Point; 
			stage.x = logic.x * tileWidth + ( logic.y & 1) * ( tileWidth / 2 ); 
			stage.y = logic.y * tileHeight / 2; 
			return stage; 
		}
		
		
	}
}