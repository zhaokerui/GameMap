package xuewan.mapedit.data
{
	/**
	 * 保存地图所有信息 
	 * @author Lyt
	 * 
	 */	
	public class MapVO
	{
		/**
		 *地图名字 
		 */		
		public var name :String;
		/**
		 * 地图宽度 
		 */		
		public var width:uint;
		
		/**
		 * 地图高度 
		 */		
		public var height:uint;
		
		/**
		 * 每格Tile宽度 
		 */		
		public var tileWidth:uint;
		
		/**
		 * 每格Tile高度 
		 */		
		public var tileHeight:uint;
		
		/**
		 * SWF资源路径 
		 */
		public var swfPath:String;
		/**
		 * 背景图资源路径 
		 */		
		public var imgPath :String;
		/**
		 * 背景图偏移X坐标
		 */		
		public var px :int;
		/**
		 * 背景图偏移Y坐标
		 */		
		public var py :int;
		/**
		 *  二维数组[y][x]格式，保存所有addCHild物品的实例
		 */		
		public var entity:Array=[];
		/**
		 * 二维数组[y][x]格式，保存地图坐标是否可通行，1是不可通行 ， 0 是可通行 
		 */		
		public var paths:Array=[];
		/**
		 * 二维数组[y][x]格式,保存所有addCHild路径点的实例
		 */		
		public var pathPoint:Array=[];
		/**
		 * 物品库
		 */		
		public var entityXml:XML;
		/**
		 * 地图网格类型 
		 */		
		public var mapType:uint;
		
		
		public function MapVO(name:String,type:uint,w:uint,h:uint,tileW:uint,tileH:uint)
		{
			this.name = name;
			width = w;
			height = h;
			tileWidth = tileW;
			tileHeight = tileH;
			paths = [];
			pathPoint = [];
			mapType = type;
			if(mapType==1)
			{
				getGridByRhombus();
			}else{
				getGridSquare();
			}
		}
		/**
		 * 方形 
		 * 
		 */		
		private function getGridSquare():void
		{
			var len:uint= width+height;
			for(var i:int=0;i<len;i++)
			{
				paths[i] = [];
				pathPoint[i] = [];
				for(var j:int=0;j<len;j++)
				{
					paths[i][j] = 0;
					pathPoint[i][j] = null;
					trace(i+"/",j)
				}
			}
		}
		/**
		 *  菱形
		 * 
		 */		
		private function getGridByRhombus():void
		{
			for(var i:int=0;i<width;i++)
			{
				paths[i] = [];
				pathPoint[i] = [];
				for(var j:int=0;j<height;j++)
				{
					paths[i][j] = 0;
					pathPoint[i][j] = null;
					trace(i+"/",j)
				}
			}
		}
		public function getGridData():String
		{
			var str:String="";
			for(var x:int = 0 ; x < height ; x++)
			{
				for(var y:int = 0 ; y < width ; y++)
				{
					str += paths[x][y];
				}
			}
			return str;
		}
		public function setGridData(v:String):void
		{
			var ary:Array = v.split("");
			for(var x:int = 0 ; x < height ; x++)
			{
				for(var y:int = 0 ; y < width ; y++)
				{
					paths[x][y] = ary[x*height+y];
				}
			}
		}
	}
}