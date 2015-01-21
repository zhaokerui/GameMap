package xuewan.mapedit.layer
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	
	import xuewan.mapedit.data.MapVO;

	public class SceneLayer extends UIComponent
	{
		/**网格层*/
		public var gridLayer :GridLayer;
		/**物品层*/
		public var entityLayer:EntityLayer;
		/**背景图片*/
		public var background:Bitmap;
		public var data:MapVO;
		
		public function SceneLayer()
		{
		}
		public function getPathPoint():Point
		{
			if(gridLayer)
			{
				return gridLayer.getGridPoint(this.mouseX,this.mouseY);
			}
			return null;
		}
		public function getBackground(w:uint,h:uint):void
		{
			this.graphics.beginFill(0);
			this.graphics.clear();
			this.graphics.beginFill(0x333333,0);
			this.graphics.drawRect(0,0,w,h);
			this.graphics.endFill();
			this.width = w;
			this.height = h;
		}
		public function clear():void
		{
			if(gridLayer)
			{
				if(gridLayer.parent)
				{
					gridLayer.parent.removeChild(gridLayer);
				}
				gridLayer.destroy();
				gridLayer = null;
			}
			if(entityLayer)
			{
				if(entityLayer.parent)
				{
					entityLayer.parent.removeChild(entityLayer);
				}
				entityLayer.destroy();
				entityLayer = null;
			}
			data = null;
		}
		/**
		 * 路径层 
		 */		
		public function showGrid():void
		{
			if(data==null)return;
			if(gridLayer==null)
				gridLayer = new GridLayer(data);
			if(gridLayer.parent)
			{
				gridLayer.parent.removeChild(gridLayer);
			}else{
				this.addChild(gridLayer);
			}
		}
		/**
		 * 物品层 
		 */		
		public function showEntity():void
		{
			if(data==null)return;
			if(entityLayer==null)
				entityLayer = new EntityLayer(data);
			if(entityLayer.parent)
			{
				entityLayer.parent.removeChild(entityLayer);
			}else{
				this.addChild(entityLayer);
			}
		}
	}
}