package xuewan.mapedit.ui
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import flashk.core.DragManager;
	
	import xuewan.mapedit.data.MapVO;
	import xuewan.mapedit.layer.Entity;
	import xuewan.mapedit.layer.EntityLayer;
	import xuewan.mapedit.layer.GridLayer;
	import xuewan.mapedit.layer.SceneLayer;

	public class ViewPanelController
	{
		private var _view:ViewPanel;
		private var _scene:SceneLayer;
		private var _mapInfo:MapInfo;
		/**背景图片*/
		private var background:Bitmap;
		/**鼠标左键是否被按下*/
		private var mouseDown:Boolean = false;
		public var type:uint=0;
		public var data:MapVO;
		public function ViewPanelController(view:ViewPanel)
		{
			_view = view;
			_scene = _view.sceneLayer;
			_mapInfo = new MapInfo();
			_view.sceneLayer.addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			_view.sceneLayer.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
			_view.sceneLayer.addEventListener(MouseEvent.MOUSE_UP,onUp);
			_view.sceneLayer.addEventListener(MouseEvent.CLICK,onClick);
		}
		public function destroy():void
		{
			if(_view != null)
			{
				_view.sceneLayer.removeEventListener(MouseEvent.MOUSE_DOWN,onDown);
				_view.sceneLayer.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
				_view.sceneLayer.removeEventListener(MouseEvent.MOUSE_UP,onUp);
				_view.sceneLayer.removeEventListener(MouseEvent.CLICK,onClick);
				_view = null;
			}
		}
		public function clear():void
		{			
			_scene.clear();
			data = null;
		}
		
		public function get mapInfo():MapInfo
		{
			return _mapInfo;
		}
		/**
		 * 操作事件
		 */		
		private function onDown(event :MouseEvent):void
		{
			if(_scene.gridLayer&&_scene.gridLayer.visible&&type>0)
			{
				mouseDown = true;
			}
		}
		private function onMove(event :MouseEvent):void
		{
			if(mouseDown)
			{
				var pt:Point = _view.sceneLayer.getPathPoint();
				if(pt)
				{
					if(type==4)
					{
						_scene.gridLayer.removePathPoint(pt);
					}else{
						_scene.gridLayer.addPathPoint(pt,type);
					}
					GameMap.instance.menuPanel.txtMouseX.text = pt.x+"";
					GameMap.instance.menuPanel.txtMouseY.text = pt.y+"";
				}
				
			}
		}
		private function onUp(event :MouseEvent):void
		{
			mouseDown = false;
		}
		private function onClick(event :MouseEvent):void
		{
			if(_scene.gridLayer&&_scene.gridLayer.visible)
			{
				var pt:Point = _view.sceneLayer.getPathPoint();
				if(pt)
				{
					GameMap.instance.menuPanel.txtMouseX.text = pt.x+"";
					GameMap.instance.menuPanel.txtMouseY.text = pt.y+"";
				}
			}
		}
		/**
		 * 初始化地图数据 
		 * @param vo
		 * 
		 */		
		public function initMap(vo:MapVO):void
		{
			clear();
			data = vo;
			_scene.data = vo;
			mapInfo.data = vo;
			_view.sceneLayer.getBackground(data.width*data.tileWidth,data.height*data.tileHeight);
		}
		/**
		 * 背景图 
		 * 
		 */		
		public function showBackground():void
		{
			if(background==null)return;
			if(background.parent)
			{
				background.parent.removeChild(background);
			}else{
				if(_view.sceneLayer.numChildren==0)
					_view.sceneLayer.addChild(background);
				else
					_view.sceneLayer.addChildAt(background,1);
			}
		}
		public function setBackground(image:Bitmap):void
		{
			if(background&&background.parent)
			{
				background.parent.removeChild(background);
			}
			background = image;
			showBackground();
		}
		/**
		 * 路径层 
		 */		
		public function showGridLayer():void
		{
			_scene.showGrid();
		}
		/**
		 * 物品层 
		 */		
		public function showEntityLayer():void
		{
			_scene.showEntity();
		}
		public function addEntity(vo:Entity):void
		{
			if(_scene.entityLayer==null)return;
			_scene.entityLayer.addEntity(vo);
			var t:uint=uint(Math.random()*20);
			vo.x = _view.myScroller.viewport.horizontalScrollPosition+100+t;
			vo.y = _view.myScroller.viewport.verticalScrollPosition+100+t;
		}
	}
}