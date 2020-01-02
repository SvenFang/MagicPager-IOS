//
//  ListWidgetModel.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class ListWidgetModel: BaseCollectionWidgetModel {
    //SINGLE：单列 DOUBLE：双列瀑布流
    @objc public var listType: String = ListWidgetType.SINGLE
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        listType <- map["listType"]
    }
    
    @objc public required init() {
        super.init()
        self.type = WidgetModelType.LIST_TYPE
    }  
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copyItem = super.copy(with: zone) as! ListWidgetModel
        copyItem.listType = self.listType
        return copyItem
    }
}
