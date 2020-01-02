//
//  TextWidgetModel.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class TextWidgetModel: BaseWidgetModel {
    
    //文本内容
    @objc public var text: String? = nil
    //字体大小（单位大小）
    @objc public var textSize: Int = 15
    //字体颜色
    @objc public var textColor: String = "#000000"
    //行距（单位大小）
    @objc public var lineSpacing: Int = 1
    //最大行数
    @objc public var maxLines: Int = 1
    //字体水平对其方向
    @objc public var textHorizontalAlignment: String = HorizontalAlignment.LEFT
    //字体垂直对其方向
    @objc public var textVerticalAlignment: String = VerticalAlignment.TOP
    //是否粗体
    @objc public var bold: Bool = false
    //是否斜体
    @objc public var italic: Bool = false
    
    @objc public required init() {
        super.init()
        self.type = WidgetModelType.TEXT_TYPE
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        text <- map["text"]
        textSize <- map["textSize"]
        textColor <- map["textColor"]
        lineSpacing <- map["lineSpacing"]
        maxLines <- map["maxLines"]
        textHorizontalAlignment <- map["textHorizontalAlignment"]
        textVerticalAlignment <- map["textVerticalAlignment"]
        bold <- map["bold"]
        italic <- map["italic"]
    }
    
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copyItem = super.copy(with: zone) as! TextWidgetModel
        copyItem.text = text
        copyItem.textSize = textSize
        copyItem.textColor = textColor
        copyItem.lineSpacing = lineSpacing
        copyItem.maxLines = maxLines
        copyItem.textHorizontalAlignment = textHorizontalAlignment
        copyItem.textVerticalAlignment = textVerticalAlignment
        copyItem.bold = bold
        copyItem.italic = italic
        return copyItem
    }
}
