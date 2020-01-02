//
//  FrameWidgetModel.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class FrameWidgetModel: BaseCollectionWidgetModel {
    
    @objc public required init() {
        super.init()
        self.type = WidgetModelType.FRAME_TYPE
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
}
