package xuewan.mapedit.ui
{
	import flash.display.Bitmap;
	import flash.display.LoaderInfo;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import flashk.core.DragManager;
	
	import mx.controls.Alert;
	import mx.events.ListEvent;
	
	import xuewan.core.LayoutManager;
	import xuewan.mapedit.data.EntityVO;
	import xuewan.mapedit.layer.Entity;
	import xuewan.mapedit.utils.FileUtil;

	public class EntityController
	{
		private var _view:NewEntity; 
		private var studetXml:XML;
		private var _file:FileUtil;
		private var _selectedItem:XML;
		private var dict:Dictionary;
		public function EntityController()
		{
			studetXml=
				<entity label="物品库">
				</entity>;
			dict = new Dictionary();
		}
		private function init():void
		{
			if(_view==null)
			{
				_view = new NewEntity();
				DragManager.register(_view);
					
			}
			_selectedItem = null;
		}
		private function clear():void
		{
			for(var prop:* in dict) 
			{ 
				dict[prop].destroy();
			}
		}
		public function show():void
		{
			init();
			if(_view.parent==null)
			{
				GameMap.instance.topLayer.addChild(_view);
				LayoutManager.toRight(_view,true,-_view.width);
				
				_view.myTree.dataProvider = studetXml;
				_view.myTree.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,onItemDoubleClick);
				_view.myTree.addEventListener(ListEvent.ITEM_CLICK,onItemClick);
				_view.btnClass.addEventListener(MouseEvent.CLICK,onClass);
				_view.btnAdd.addEventListener(MouseEvent.CLICK,onAdd);
				_view.btnDel.addEventListener(MouseEvent.CLICK,onDel);
				_view.closeButton.addEventListener(MouseEvent.CLICK,onClose);
			}else{
				_view.parent.removeChild(_view);
				_view.myTree.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,onItemDoubleClick);
				_view.myTree.removeEventListener(ListEvent.ITEM_CLICK,onItemClick);
				_view.btnClass.removeEventListener(MouseEvent.CLICK,onClass);
				_view.btnAdd.removeEventListener(MouseEvent.CLICK,onAdd);
				_view.btnDel.removeEventListener(MouseEvent.CLICK,onDel);
				_view.closeButton.removeEventListener(MouseEvent.CLICK,onClose);
			}
			
		}
		public function close():void
		{
			if(_view&&_view.parent)
			{
				_view.parent.removeChild(_view);
				_view.myTree.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,onItemDoubleClick);
				_view.myTree.removeEventListener(ListEvent.ITEM_CLICK,onItemClick);
				_view.btnClass.removeEventListener(MouseEvent.CLICK,onClass);
				_view.btnAdd.removeEventListener(MouseEvent.CLICK,onAdd);
				_view.btnDel.removeEventListener(MouseEvent.CLICK,onDel);
				_view.closeButton.removeEventListener(MouseEvent.CLICK,onClose);
			}
			
		}
		public function destroy():void
		{
			if(_view != null)
			{
				DragManager.unregister(_view);
				_view = null;
			}
		}
		private function onClose(evt:MouseEvent):void
		{
			close();
		}  
		private function onItemDoubleClick(evt:ListEvent):void
		{  
			var xml:XML=evt.itemRenderer.data as XML; 
			if(xml!=null) 
			{ 
				var vo:EntityVO=dict[String(xml.@label)];
				if(vo)
				{
					GameMap.instance.viewGame.addEntity(new Entity(vo));
				}
			}
		}  
		private function onItemClick(evt:ListEvent):void
		{  
			var xml:XML=evt.itemRenderer.data as XML; 
			if(xml!=null) 
			{ 
				var vo:EntityVO=dict[String(xml.@label)];
				if(vo)
				{
					_view.image.addEntity(vo);
				}
			}
		}  
		public function getEntityXml():XML
		{
			if(_view==null)return null;
			
			return _view.myTree.dataProvider[0] as XML;
		}
		public function setEntityXml(xml:XML):void
		{
			if(xml==null)return;
			studetXml = xml;
		}
		/**
		 * 添加分类
		 * @param evt
		 * 
		 */		
		private function onClass(evt:MouseEvent):void
		{
			var xml:XML=_view.myTree.selectedItem as XML; 
			var txt:String=_view.txtName.text; 
			if(xml!=null&&txt.length>0)
			{ 
				var parent:XML=xml.parent(); 
				if(parent)
				{
					parent.insertChildBefore(xml,new XML("<node  label=\""+txt+"\"  />")); 
				}else{
					xml.appendChild(new XML("<node  label=\""+txt+"\"  />"));
				}
			}else{
				Alert.show("需要先选中节点和填入文字"); 
			} 
		}
		private function onAdd(evt:MouseEvent):void
		{
			if(_selectedItem)return;
			var xml:XML=_view.myTree.selectedItem as XML; 
			if(xml!=null) 
			{ 
				var parent:XML=xml.parent(); 
				if(parent)
				{
					if(parent.hasOwnProperty("node"))
					{
						if(_file==null)
							_file = new FileUtil(funFile);
						_file.openFile();
						_selectedItem = xml;
					}
				}
			}else{
				Alert.show("需要先选中分类文件夹"); 
			} 
		}
		private function funFile(info:LoaderInfo):void
		{
			if(_selectedItem!=null) 
			{ 
				var vo:EntityVO=new EntityVO();
				vo.image = _file.getBitmap(info.content);
				dict[_file.filename]=vo;
				_selectedItem.appendChild(new XML("<item  label=\""+_file.filename+"\"  />")); 
				_selectedItem = null;
			} 
		}
		private function onDel(evt:MouseEvent):void
		{
			var xml:XML=_view.myTree.selectedItem as XML; 
			if(xml!=null) 
			{ 
				var list:Array=_view.myTree.selectedItems as Array; 
				for(var k:int=0;k<list.length;k++) 
				{ 
					xml=list[k] as XML; 
					var parent:XML=xml.parent(); 
					if(parent!=null) 
					{ 
						var children:XMLList=parent.children(); 
						for(var i:int=0;i<children.length();i++) 
						{ 
							if(children[i]==xml)
							{ 
								delete children[i]; 
								break; 
							} 
						} 
					} else { 
						Alert.show("不能选中根节点"); 
					} 
				}
			}else{ 
				Alert.show("需要先选中节点"); 
			}    
		}
	}
}