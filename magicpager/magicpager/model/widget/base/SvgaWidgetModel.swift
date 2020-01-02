//
//  SvgaWidgetModel.swift
//  magicpager
//
//  Created by Sven on 13/12/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation
@objc public class SvgaWidgetModel: BaseWidgetModel {

    //网络加载
    @objc public var sourceUrl: String?
    //asset加载
    @objc public var assetUrl: String?
    //svga播放次数
    @objc public var loops: Int = 1
    //播放时长 当duration = 0时 不自动停止
    @objc public var duration: Int = 0
    //停止动画后是否还原
    @objc public var cleanAfterStop: Bool = true

    //注入svga text属性
    @objc public var textMap: [String: SvgaText] = [String: SvgaText]()
    @objc public var imageMap: [String: String] = [String: String]()
    
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        sourceUrl <- map["sourceUrl"]
        assetUrl <- map["assetUrl"]
        loops <- map["loops"]
        duration <- map["duration"]
        cleanAfterStop <- map["cleanAfterStop"]
        textMap <- map["textMap"]
        imageMap <- map["imageMap"]
    }
    
    @objc public required init() {
        super.init()
        self.type = WidgetModelType.SVGA_TYPE
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copyItem = super.copy(with: zone) as! SvgaWidgetModel
        copyItem.sourceUrl = sourceUrl
        copyItem.assetUrl = assetUrl
        copyItem.loops = loops
        copyItem.duration = duration
        copyItem.cleanAfterStop = cleanAfterStop
        copyItem.textMap = textMap
        copyItem.imageMap = imageMap
    
        return copyItem
    }
}


@objc public class SvgaText: NSObject, Mappable{
    @objc public var text: String = ""
    @objc public var textSize: CGFloat = 20
    @objc public var color: String = "#000000"
    @objc public var alignment: String = SvgaTextAlignment.LEFT
    
    @objc public override init() {
    }
    
    public required init?(map: Map) {
        super.init()
    }
    
    public func mapping(map: Map) {
        text <- map["text"]
        textSize <- map["textSize"]
        color <- map["color"]
        alignment <- map["alignment"]
    }
}

@objc public class SvgaTextAlignment: NSObject {
    @objc public static let LEFT = "LEFT"
    @objc public static let CENTER = "CENTER"
    @objc public static let RIGHT = "RIGHT"
}
