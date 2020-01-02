//
//  WidgetModelMapping.swift
//  magicpager
//
//  Created by Sven on 13/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

struct ModelViewItem<M: IMagic>{
    var modelClass: BaseWidgetModel.Type
    var viewClass: M.Type
    
    init(modelClass: BaseWidgetModel.Type, viewClass: M.Type) {
        self.modelClass = modelClass
        self.viewClass = viewClass 
    }
}

@objc public class WidgetModelMapping: NSObject {

    @objc public static let instance = WidgetModelMapping()
    
    private var map = Dictionary<String, ModelViewItem>()
    //MARK: - 注册魔法控件
    private override init() {
        super.init()
        //基础类控件
        add(type: WidgetModelType.BLANK_TYPE,
            modelClass: BlankWidgetModel.self,
            viewClass: MagicBlank.self)
        add(type: WidgetModelType.BUTTON_TYPE,
            modelClass: ButtonWidgetModel.self,
            viewClass: MagicButton.self)
        add(type: WidgetModelType.IMAGE_TYPE,
            modelClass: ImageWidgetModel.self,
            viewClass: MagicImage.self)
        add(type: WidgetModelType.TEXT_TYPE,
            modelClass: TextWidgetModel.self,
            viewClass: MagicText.self)
        add(type: WidgetModelType.SVGA_TYPE,
            modelClass: SvgaWidgetModel.self,
            viewClass: MagicSvga.self)
        add(type: WidgetModelType.NAVIGATION_TYPE,
            modelClass: NavigationBarModel.self,
            viewClass: MagicNavigationBar.self)
        
        //容器类控件
        add(type: WidgetModelType.LIST_TYPE,
            modelClass: ListWidgetModel.self,
            viewClass: MagicList.self)
        add(type: WidgetModelType.CAROUSEL_TYPE,
            modelClass: CarouselWidgetModel.self,
            viewClass: MagicCarousel.self)
        add(type: WidgetModelType.FLEXBOX_TYPE,
            modelClass: FlexboxWidgetModel.self,
            viewClass: MagicFlexboxView.self)
        add(type: WidgetModelType.FRAME_TYPE,
            modelClass: FrameWidgetModel.self,
            viewClass: MagicFrame.self)
        add(type: WidgetModelType.GRID_TYPE,
            modelClass: GridWidgetModel.self,
            viewClass: MagicGrid.self)
        add(type: WidgetModelType.SLIDER_TYPE,
            modelClass: SliderWidgetModel.self,
            viewClass: MagicSilder.self)
        add(type: WidgetModelType.LINEAR_TYPE, 
            modelClass: LinearWidgetModel.self, 
            viewClass: MagicLinear.self)
    }   
    
    @objc public func add(type: String, modelClass: BaseWidgetModel.Type, viewClass:IMagic.Type) {
        let item = ModelViewItem(modelClass: modelClass, viewClass: viewClass )
        map.updateValue( item, forKey: type)
    }
    
    @objc public func getModelClass(type: String) -> BaseWidgetModel.Type? {
        let item = map[type]
        return item?.modelClass
    }
    
    @objc public func getIMagicClass(type: String) -> IMagic.Type? {
        let item = map[type]
        return item?.viewClass
    }
}
