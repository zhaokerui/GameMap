package xuewan.mapedit.ui
{
	import flash.display.Bitmap;
	import flash.display.LoaderInfo;
	import flash.events.MouseEvent;
	
	import spark.components.RadioButton;
	
	import xuewan.mapedit.utils.FileUtil;

	public class MenuPanelController
	{
		private var _view:MenuPanel;
		private var _new:MapController;
		private var _entity:EntityController;
		private var _file:FileUtil;
		public function MenuPanelController(view:MenuPanel)
		{
			_view = view;
			_view.btnNew.addEventListener(MouseEvent.CLICK,onNew);
			_view.btnOpen.addEventListener(MouseEvent.CLICK,onOpen);
			_view.btnSave.addEventListener(MouseEvent.CLICK,onSave);
			_view.btnPublish.addEventListener(MouseEvent.CLICK,onPublish);
			
			_view.btnFile.addEventListener(MouseEvent.CLICK,onFile);
			_view.radGrid1.addEventListener(MouseEvent.CLICK,onRadGrid);
			_view.radGrid2.addEventListener(MouseEvent.CLICK,onRadGrid);
			_view.radGrid3.addEventListener(MouseEvent.CLICK,onRadGrid);
			_view.radGrid4.addEventListener(MouseEvent.CLICK,onRadGrid);
			_view.radGrid5.addEventListener(MouseEvent.CLICK,onRadGrid);
			
			_view.btnMapLayer.addEventListener(MouseEvent.CLICK,onMapLayer);
			_view.btnGridLayer.addEventListener(MouseEvent.CLICK,onGridLayer);
			_view.btnEntityLayer.addEventListener(MouseEvent.CLICK,onEntityLayer);
			
			_view.btnEntityInfo.addEventListener(MouseEvent.CLICK,onEntityInfo);
			_view.btnMapInfo.addEventListener(MouseEvent.CLICK,onMapInfo);
			
			_entity = new EntityController();
			_file = new FileUtil(funFile);
		}

		public function destroy():void
		{
			if(_view != null)
			{
				_view.btnNew.removeEventListener(MouseEvent.CLICK,onNew);
				_view.btnOpen.removeEventListener(MouseEvent.CLICK,onOpen);
				_view.btnSave.removeEventListener(MouseEvent.CLICK,onSave);
				_view.btnPublish.removeEventListener(MouseEvent.CLICK,onPublish);
				
				_view.btnFile.removeEventListener(MouseEvent.CLICK,onFile);
				_view.radGrid1.removeEventListener(MouseEvent.CLICK,onRadGrid);
				_view.radGrid2.removeEventListener(MouseEvent.CLICK,onRadGrid);
				_view.radGrid3.removeEventListener(MouseEvent.CLICK,onRadGrid);
				_view.radGrid4.removeEventListener(MouseEvent.CLICK,onRadGrid);
				_view.radGrid5.removeEventListener(MouseEvent.CLICK,onRadGrid);
				
				_view.btnMapLayer.removeEventListener(MouseEvent.CLICK,onMapLayer);
				_view.btnGridLayer.removeEventListener(MouseEvent.CLICK,onGridLayer);
				_view.btnEntityLayer.removeEventListener(MouseEvent.CLICK,onEntityLayer);
				
				_view.btnEntityInfo.removeEventListener(MouseEvent.CLICK,onEntityInfo);
				_view.btnMapInfo.removeEventListener(MouseEvent.CLICK,onMapInfo);
				_view = null;
			}
		}
		/**
		 * 新建文件 
		 * @param evt
		 * 
		 */		
		private function onNew(evt:MouseEvent):void
		{
			if(_new==null)
			{
				_new = new MapController();
			}
			_new.show();
		}
		/**
		 * 打开文件 
		 * @param evt
		 * 
		 */		
		private function onOpen(evt:MouseEvent):void
		{
			_file.openMap();
		}
		/**
		 * 保存文件 
		 * @param evt
		 * 
		 */		
		private function onSave(evt:MouseEvent):void
		{
			_file.saveMap(GameMap.instance.viewGame.data,_entity.getEntityXml());
		}
		/**
		 * 发布文件 
		 * @param evt
		 * 
		 */		
		private function onPublish(evt:MouseEvent):void
		{
			_file.publishMap(GameMap.instance.viewGame.data);
		}
		/**
		 * 放置障碍物 
		 * @param evt
		 * 
		 */		
		private function onEntity(evt:MouseEvent):void
		{
			GameMap.instance.viewGame.type = 1;
		}
		/**
		 * 放置路点 
		 * @param evt
		 * 
		 */		
		private function onWay(evt:MouseEvent):void
		{
			GameMap.instance.viewGame.type = 1;
		}
		/**
		 * 放置障碍点 
		 * @param evt
		 * 
		 */		
		private function onObstacle(evt:MouseEvent):void
		{
			GameMap.instance.viewGame.type = 1;
		}
		/**
		 * 清楚障碍点或路点 
		 * @param evt
		 * 
		 */		
		private function onClear(evt:MouseEvent):void
		{
			GameMap.instance.viewGame.type = 2;
		}
		/**
		 * 取消 
		 * @param evt
		 * 
		 */		
		private function onCancel(evt:MouseEvent):void
		{
			GameMap.instance.viewGame.type = 0;
		}
		/**
		 * 地图层 
		 * @param evt
		 * 
		 */		
		private function onMapLayer(evt:MouseEvent):void
		{
			GameMap.instance.viewGame.showBackground();
		}
		/**
		 * 网格层 
		 * @param evt
		 * 
		 */		
		private function onGridLayer(evt:MouseEvent):void
		{
			GameMap.instance.viewGame.showGridLayer();
		}
		/**
		 * 物品层 
		 * @param evt
		 * 
		 */		
		private function onEntityLayer(evt:MouseEvent):void
		{
			GameMap.instance.viewGame.showEntityLayer();
		}
		/**
		 * 物品库 
		 * @param evt
		 * 
		 */		
		private function onEntityInfo(evt:MouseEvent):void
		{
			_entity.show();
		}
		/**
		 * 地图信息 
		 * @param evt
		 * 
		 */		
		private function onMapInfo(evt:MouseEvent):void
		{
			GameMap.instance.viewGame.mapInfo.show();
		}
		
		
		/**
		 * 网格操作 
		 * @param evt
		 * 
		 */		
		private function onRadGrid(evt:MouseEvent):void
		{
			var rad:RadioButton = evt.currentTarget as RadioButton;
			GameMap.instance.viewGame.type = uint(rad.value);
		}
		/**
		 * 加载地图
		 * 
		 */		
		private function onFile(evt:MouseEvent):void
		{
			_file.openFile();
		}
		private function funFile(info:LoaderInfo):void
		{
			if(info==null)
			{
				_entity.setEntityXml(_file.data.entityXml);
			}else{
				GameMap.instance.viewGame.setBackground(_file.getBitmap(info.content));
			}
		}
	}
}