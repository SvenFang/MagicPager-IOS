//
//  ImageWidgetModel.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class ImageWidgetModel: BaseWidgetModel {
    //图片在线url
    @objc public var imgSrc: String? = nil
    //本地图片资源Res
    @objc public var imgRes: String? = nil
    //图片填充方式
    @objc public var scaleType: String = ScaleType.INSIDE
    
    @objc public required init() {
        super.init()
        self.type = WidgetModelType.IMAGE_TYPE
    }
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        imgSrc <- map["imgSrc"]
        imgRes <- map["imgRes"]
        scaleType <- map["scaleType"]
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override public func copy(with zone: NSZone? = nil) -> Any {
        let copyItem = super.copy(with: zone) as! ImageWidgetModel
        copyItem.imgSrc = imgSrc
        copyItem.imgRes = imgRes
        copyItem.scaleType = scaleType
        return copyItem
    }
}
