//
//  LinearWidgetModel.swift
//  magicpager
//
//  Created by Sven on 06/12/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation

@objc public class LinearWidgetModel: BaseCollectionWidgetModel {
    
    @objc public var orientation = Orientation.VERTICAL
    //水平对其方向
    @objc public var horizontalAlignment: String = HorizontalAlignment.LEFT
    //垂直对其方向
    @objc public var verticalAlignment: String = VerticalAlignment.TOP
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        orientation <- map["orientation"]
        horizontalAlignment <- map["horizontalAlignment"]
        verticalAlignment <- map["verticalAlignment"]
    }
    
    @objc public required init() {
        super.init()
        self.type = WidgetModelType.LINEAR_TYPE
    }  
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copyItem = super.copy(with: zone) as! LinearWidgetModel
        copyItem.orientation = self.orientation
        copyItem.horizontalAlignment = self.horizontalAlignment
        copyItem.verticalAlignment = self.verticalAlignment
        return copyItem
    }
}

@objc public class Orientation: NSObject {
    @objc public static let VERTICAL = "VERTICAL"
    @objc public static let HORIZONTAL = "HORIZONTAL"
}
