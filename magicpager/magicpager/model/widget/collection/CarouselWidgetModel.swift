//
//  CarouselWidgetModel.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class CarouselWidgetModel: BaseCollectionWidgetModel {
    //轮播间隔(单位毫秒)
    @objc public var duration: Int64 = 5000
    //自动播放（默认是）
    @objc public var autoPlay: Bool = true
    //是否展示滑点
    @objc public var dots: Bool = true
    @objc public var dotSelectedColor: String = "#444444"
    @objc public var dotDefaultColor: String = "#bbbbbb"
    @objc public var dotSpace: CGFloat = 4
    @objc public var dotWidth: CGFloat = 4
    @objc public var dotsContainerHeight: CGFloat = 10.0

    @objc public required init() {
        super.init()
        self.type = WidgetModelType.CAROUSEL_TYPE
    }

    required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        duration <- map["duration"]
        autoPlay <- map["autoPlay"]
        dots <- map["dots"]
        dotSelectedColor <- map["dotSelectedColor"]
        dotDefaultColor <- map["dotDefaultColor"]
        dotSpace <- map["dotSpace"]
        dotWidth <- map["dotWidth"]
        dotsContainerHeight <- map["dotsContainerHeight"]
    }
    
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copyItem = super.copy(with: zone) as! CarouselWidgetModel
        copyItem.duration = self.duration
        copyItem.autoPlay = self.autoPlay
        copyItem.dotSelectedColor = self.dotSelectedColor
        copyItem.dotDefaultColor = self.dotDefaultColor
        copyItem.dotSpace = self.dotSpace
        copyItem.dotWidth = self.dotWidth
        copyItem.dotsContainerHeight = self.dotsContainerHeight
        return copyItem
    }
}
