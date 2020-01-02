//
//  LengthUtil.swift
//  magicpager
//
//  Created by Sven on 08/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

let K_SCREEN_WIDTH = UIScreen.main.bounds.size.width
let K_SCREEN_HEIGHT = UIScreen.main.bounds.size.height

extension CGFloat {
    public func toPoint() -> CGFloat {
        return LengthUtil.instance.length2px(length: self)
    }
}


@objc public class LengthUtil: NSObject {
    @objc public var windowWidth:CGFloat = 375
    
    private var pxPerPoint:CGFloat = 0
    
    @objc public static let instance = LengthUtil()
    
    private override init() {
    }
    
    private func getPxPerPoint()-> CGFloat {
        if (pxPerPoint == 0.0) {
            let width = UIScreen.main.bounds.size.width
            pxPerPoint = width * 1.0 / windowWidth
        }
        return pxPerPoint
    }
    
    @objc public func length2px(length:CGFloat) -> CGFloat {
        return length * getPxPerPoint()
    }
}
