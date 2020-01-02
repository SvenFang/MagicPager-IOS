//
//  MagicViewCreator.swift
//  magicpager
//
//  Created by Sven on 13/11/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation
@objc public class MagicViewCreator: NSObject {
    
    @objc public static func createView(model: BaseWidgetModel,
                           maxWidth:CGFloat,
                           maxHeight:CGFloat,
                           delegate: IMagicDelegate?) -> IMagic? {
        let magicClass = WidgetModelMapping.instance.getIMagicClass(type: model.type)
        let magicView = magicClass?.init(maxWidth: maxWidth, maxHeight: maxHeight, model: model)
        magicView?.delegate = delegate
        return magicView
    }
}
