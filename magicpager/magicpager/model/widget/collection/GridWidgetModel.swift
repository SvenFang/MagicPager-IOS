//
//  GridWidgetModel.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class GridWidgetModel: BaseCollectionWidgetModel {
    //内容所分成行数
    @objc public var row: Int32 = 1
    //内容所分成列数
    @objc public var column: Int32 = 1
    

    @objc public required init() {
        super.init()
        self.type = WidgetModelType.GRID_TYPE
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        row <- map["row"]
        column <- map["column"]
    }
    
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copyItem = super.copy(with: zone) as! GridWidgetModel
        copyItem.row = self.row
        copyItem.column = self.column
        return copyItem
    }
}
