//
//  NavigationBarModel.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class NavigationBarModel: BaseWidgetModel {
    
    @objc public var left: BaseWidgetModel?
    @objc public var right: BaseWidgetModel?
    @objc public var bgImage: String?
    @objc public var title: TextWidgetModel?
    @objc public var subTitle:TextWidgetModel?
    
    @objc public required init() {
        super.init()
        self.type = WidgetModelType.NAVIGATION_TYPE
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copyItem = super.copy(with: zone) as! NavigationBarModel
        return copyItem
    }
}
