//
//  BaseCollectionWidgetModel.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class BaseCollectionWidgetModel: BaseWidgetModel {
    @objc public var items: [BaseWidgetModel] = [BaseWidgetModel]()

    public override func mapping(map: Map) {
        super.mapping(map: map)
        items <- (map["items"], WidgetsTranform())
    }
    
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copyItem = super.copy(with: zone) as! BaseCollectionWidgetModel
        self.items.forEach { (item) in
            copyItem.items.append(item.copy() as! BaseWidgetModel)
        }
        return copyItem
    }
}
