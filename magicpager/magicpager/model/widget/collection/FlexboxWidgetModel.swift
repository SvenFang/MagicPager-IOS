//
//  FlexboxWidgetModel.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit
@objc public class FlexboxWidgetModel: BaseCollectionWidgetModel {
    @objc public var flexDirection: String = MFlexDirection.ROW
    @objc public var justifyContent: String = MJustifyContent.FLEX_START
    
    @objc public required init() {
        super.init()
        self.type = WidgetModelType.FLEXBOX_TYPE
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override public func mapping(map: Map) {
        super.mapping(map: map)
        flexDirection <- map["flexDirection"]
        justifyContent <- map["justifyContent"]
    }
    
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copyItem = super.copy(with: zone) as! FlexboxWidgetModel
        copyItem.flexDirection = self.flexDirection
        copyItem.justifyContent = self.justifyContent
        return copyItem
    }
}

@objc public class MFlexDirection: NSObject {
    @objc public static let ROW = "ROW"
    @objc public static let ROW_REVERSE = "ROW_REVERSE"
    @objc public static let COLUMN = "COLUMN"
    @objc public static let COLUMN_REVERSE = "COLUMN_REVERSE"
}

@objc public class MJustifyContent: NSObject {
    @objc public static let FLEX_START = "FLEX_START"
    @objc public static let FLEX_END = "FLEX_END"
    @objc public static let CENTER = "CENTER"
}
