//
//  ButtonWidgetModel.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit
@objc public class ButtonWidgetModel: BaseWidgetModel {
    @objc public var text: String? = nil
    @objc public var textSize: Int32 = 15
    @objc public var textColor: String = "#000000"
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        text <- map["text"]
        textSize <- map["textSize"]
        textColor <- map["textColor"]
    }
    
    @objc public required init() {
        super.init()
        self.type = WidgetModelType.BUTTON_TYPE
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copyItem = super.copy(with: zone) as! ButtonWidgetModel
        copyItem.text = text
        copyItem.textSize = textSize
        copyItem.textColor = textColor
        return copyItem
    }
}
