//
//  WidgetModelType.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

/**
 * 控件model type 
 */
@objc public class WidgetModelType: NSObject {
    @objc public static let BLANK_TYPE = "BLANK_TYPE"
    
    @objc public static let TEXT_TYPE = "TEXT_TYPE"
    
    @objc public static let IMAGE_TYPE = "IMAGE_TYPE"
    
    @objc public static let BUTTON_TYPE = "BUTTON_TYPE"
    
    @objc public static let SVGA_TYPE = "SVGA_TYPE"
    
    //容器类组件
    
    @objc public static let GRID_TYPE = "GRID_TYPE"
    
    @objc public static let CAROUSEL_TYPE = "CAROUSEL_TYPE"
    
    @objc public static let LIST_TYPE = "LIST_TYPE"
    
    @objc public static let FRAME_TYPE = "FRAME_TYPE"
    
    @objc public static let FLEXBOX_TYPE = "FLEXBOX_TYPE"
    
    @objc public static let SLIDER_TYPE = "SLIDER_TYPE"
    
    @objc public static let LINEAR_TYPE = "LINEAR_TYPE"
    
    //其他
    @objc public static let NAVIGATION_TYPE = "NAVIGATION_TYPE"
}

@objc public class HorizontalAlignment: NSObject {
    @objc public static let LEFT = "LEFT" 
    @objc public static let RIGHT = "RIGHT"
    @objc public static let CENTER = "CENTER"
}

@objc public class VerticalAlignment: NSObject {
    @objc public static let TOP = "TOP"
    @objc public static let BOTTOM = "BOTTOM"
    @objc public static let CENTER = "CENTER"
}

@objc public class ListWidgetType: NSObject {
    @objc public static let SINGLE = "SINGLE"
    @objc public static let DOUBLE = "DOUBLE"
}

@objc public class ScaleType: NSObject {
    @objc public static let CROP = "CROP"
    @objc public static let INSIDE = "INSIDE"
    @objc public static let FIX = "FIX"
}

@objc public class WidgetModelPosition: NSObject {
    //控件位置
    @objc public static let NONE = "NONE"
    //fix
    @objc public static let TOP_FIX = "TOP_FIX"
    
    @objc public static let BOTTOM_FIX = "BOTTOM_FIX"
    
    @objc public static let LEFT_FIX = "LEFT_FIX"
    
    @objc public static let RIGHT_FIX = "RIGHT_FIX"
    
    //float
    @objc public static let TOP_FLOAT = "TOP_FLOAT"
    
    @objc public static let BOTTOM_FLOAT = "BOTTOM_FLOAT"
    
    @objc public static let LEFT_FLOAT = "LEFT_FLOAT"
    
    @objc public static let RIGHT_FLOAT = "RIGHT_FLOAT"
}
