//
//  SliderWidgetModel.swift
//  magicpager
//
//  Created by Sven on 14/11/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation

@objc public class SliderWidgetModel: BaseCollectionWidgetModel {
    
    @objc public required init() {
        super.init()
        self.type = WidgetModelType.SLIDER_TYPE
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
}
