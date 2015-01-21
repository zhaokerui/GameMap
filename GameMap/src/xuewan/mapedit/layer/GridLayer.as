package xuewan.mapedit.layer
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import xuewan.mapedit.data.MapVO;
	import xuewan.mapedit.utils.GridUtil;
	
	
	/**
	 * 网格层 
	 * @author kerry
	 * 
	 */	
	public class GridLayer extends Sprite
	{
		private var _data:MapVO;
		private var scale :Number = 1;
		public function GridLayer(data:MapVO)
		{
			super();			
			_data = data;
			GridUtil.setContentSize(_data.width,_data.height,_data.tileWidth,_data.tileHeight);
			if(data.mapType==1)
			{
				drawGridByDiamond();
			}else{
				drawGridSquare();
			}
		}
		public function getGridPoint(px:Number,py:Number):Point
		{
			if(_data.mapType==1)
			{
				//Rhombus 菱形
				return GridUtil.getGridPoint(px,py,_data.mapType);
			}else{
				//square 方形
				return GridUtil.getTileFromLocationBySquare(px,py);
			}
		}
		/**
		 * 方形 
		 * 菱形取中心的方形
		 */		
		private function drawGridSquare():void
		{
			this.graphics.lineStyle(1,0xff0000,0.3);
			this.graphics.beginFill(0);
			var len:uint= _data.width+_data.height;
			var topX:int = _data.width*_data.tileWidth/2;
			var topY:int = -_data.height*_data.tileHeight/2;
			// Y方向
			for(var x:int = 0 ; x <= len ; x++)
			{
				this.graphics.moveTo(topX-x*_data.tileWidth/2,topY+x*_data.tileHeight/2);
				this.graphics.lineTo(topX-x*_data.tileWidth/2+len*_data.tileWidth/2,topY+x*_data.tileHeight/2+len*_data.tileHeight/2);
				
			}
			
			// X 方向
			for(var y:int = 0 ; y <= len ; y++)
			{
				this.graphics.moveTo(topX+y*_data.tileWidth/2,topY+y*_data.tileHeight/2);
				this.graphics.lineTo(topX+y*_data.tileWidth/2-len*_data.tileWidth/2,topY+y*_data.tileHeight/2+len*_data.tileHeight/2);
				
			}
			this.graphics.endFill();
//			this.x = topX;
//			this.y = -topY;
		}
		private function getGridPointBySquare(pt:Point):Point
		{
			// 90度角坐标
			var p90:Point = new Point(pt.x * _data.tileWidth + _data.tileWidth/4,pt.y * _data.tileHeight + _data.tileHeight/2);
			// 45度角坐标
			return GridUtil.trans90To45(p90);
		}
		/**
		 *  菱形
		 * 
		 */		
		private var _rhombus:Shape;
		private function drawGridByRhombus():void
		{
			_rhombus = new Shape();
			_rhombus.x = _data.width*_data.tileWidth/2;
			addChild(_rhombus);
			_rhombus.graphics.lineStyle(1,0xff0000,0.3);
			var mapWidth :int = _data.width * _data.tileWidth;
			var mapHeight :int = _data.height * _data.tileHeight;
			_rhombus.graphics.beginFill(0);
			// Y方向
			for(var x:int = 0 ; x <= _data.width ; x++)
			{
				var dx:Number = x * _data.tileWidth;
				var p1:Point = new Point(dx,0);
				p1 = GridUtil.trans90To45(p1);
				var p2:Point = new Point(dx,mapHeight);
				p2 = GridUtil.trans90To45(p2);
				_rhombus.graphics.moveTo(p1.x,p1.y);
				_rhombus.graphics.lineTo(p2.x,p2.y);
			}
			// X 方向
			for(var y:int = 0 ; y <= _data.height ; y++)
			{
				var dy:Number = y * _data.tileHeight;
				var p3:Point = GridUtil.trans90To45(new Point(0,dy));
				var p4:Point = GridUtil.trans90To45(new Point(mapWidth,dy));
				_rhombus.graphics.moveTo(p3.x,p3.y);
				_rhombus.graphics.lineTo(p4.x,p4.y);
			}
			_rhombus.graphics.endFill();
		}
		private function getGridPointByRhombus(pt:Point):Point
		{
			// 90度角坐标
			var p90:Point = new Point(pt.x * _data.tileWidth + _data.tileWidth/4,pt.y * _data.tileHeight + _data.tileHeight/2);
			// 45度角坐标
			return GridUtil.trans90To45(p90);
		}
		/**
		 * 菱形
		 * 
		 */		
		private function drawGridByDiamond():void
		{
			this.graphics.lineStyle(1,0xff0000,0.3);
			this.graphics.beginFill(0);
			var len:uint= _data.width+_data.height;
			var topX:int = _data.width*_data.tileWidth/2;
			var topY:int = _data.height*_data.tileHeight/2;
			// Y方向
			for(var x:int = 0 ; x <= _data.width ; x++)
			{
				this.graphics.moveTo(topX-x*_data.tileWidth/2,(1+x/2)*_data.tileHeight);
				this.graphics.lineTo(topX-x*_data.tileWidth/2+_data.width *_data.tileWidth/2,(1+x/2)*_data.tileHeight+_data.width*_data.tileHeight/2);
				
			}
			
			// X 方向
			for(var y:int = 0 ; y <= _data.height ; y++)
			{
				this.graphics.moveTo(topX+y*_data.tileWidth/2,topY+y*_data.tileHeight/2);
				this.graphics.lineTo(topX+y*_data.tileWidth/2-_data.height*_data.tileWidth/2,topY+y*_data.tileHeight/2+_data.height*_data.tileHeight/2);
				
			}
			this.graphics.endFill();
			this.x = 200;
			this.y = 200;
		}
		/**
		 * 滑动幻灯片
		 * 
		 */		
		private function drawGridBySlide():void
		{
			
		}
		/**
		 * 错列的，叉排的
		 * 
		 */		
		private function drawGridByStaggered():void
		{
			
		}
		/**
		 * 添加路点 
		 * @param pt
		 * 
		 */		
		public function addPathPoint(pt:Point,type:uint=0):void
		{
			if(visible)
			{
				var pathPoint :Bitmap = _data.pathPoint[pt.y][pt.x];				
				if(pathPoint==null)
				{
					var p45:Point = getGridPointBySquare(pt);
					pathPoint = pathPointToBitmap(new PathPoint(type));
					pathPoint.cacheAsBitmap = true;
					pathPoint.x = p45.x;
					pathPoint.y = p45.y;
					_data.pathPoint[pt.y][pt.x] = pathPoint;
					_data.paths[pt.y][pt.x] = type;
					this.addChild(pathPoint);
				}
			}
		}
		/**
		 * 删除方块或路径点 
		 * @param index
		 */		
		public function removePathPoint(pt:Point):void
		{
			var pathPoint :Bitmap = _data.pathPoint[pt.y][pt.x] as Bitmap;
			if(pathPoint)
			{
				pathPoint.parent.removeChild(pathPoint);
				pathPoint.bitmapData.dispose();
				pathPoint.bitmapData = null;
				_data.pathPoint[pt.y][pt.x] = null;
				_data.paths[pt.y][pt.x] = 0;
			}
		}
		private function clearPathPoint():void
		{
			var pathPoint:Bitmap;
			for(var x:int = 0 ; x < _data.height ; x++)
			{
				for(var y:int = 0 ; y < _data.width ; y++)
				{
					pathPoint = _data.pathPoint[x][y] as Bitmap;
					if(pathPoint)
					{
						pathPoint.parent.removeChild(pathPoint);
						pathPoint.bitmapData.dispose();
						pathPoint.bitmapData = null;
						_data.pathPoint[y][x] = null;
						_data.paths[y][x] = 0;
					}
				}
			}
		}
		/**
		 * 路径点转bitmap 
		 * @param pathPoint
		 * @return 
		 * 
		 */		
		private function pathPointToBitmap(pathPoint:PathPoint):Bitmap
		{
			var matrix:Matrix = new Matrix();
			matrix.translate(pathPoint.pointWidth/(2*scale),0);
			matrix.scale(scale, scale);          //缩放比例
			var bitmapData:BitmapData = new BitmapData(pathPoint.pointWidth,pathPoint.pointHeight,true,0xffffff);
			bitmapData.draw(pathPoint);
			return new Bitmap(bitmapData, "auto");    
		}
		public function destroy():void
		{
			clearPathPoint();
			if(_rhombus)
			{
				if(_rhombus.parent)
					_rhombus.parent.removeChild(_rhombus);
				_rhombus = null;
			}
		}
	}
}