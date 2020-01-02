//
//  ReuseUtil.swift
//  magicpager
//
//  Created by Sven on 09/12/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation

@objc public class ReuseUtil: NSObject {
    
    @objc static public func reuseId(model: BaseWidgetModel, index: Int) -> String {
        var modelIndex = 0
        //不重用
        if (model.reuseId == 0) {
            modelIndex = index
        }
        
        return "\(model.type)_\(model.reuseId)_\(modelIndex)"
    }
    
}
