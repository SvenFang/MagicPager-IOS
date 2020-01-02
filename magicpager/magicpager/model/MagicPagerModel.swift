//
//  MagicPagerModel.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class MagicPagerModel: NSObject, Mappable {
    public func mapping(map: Map) {
        bgColor <- map["bgColor"]
        bgImage <- map["bgImage"]
        desc <- map["desc"]
        refreshable <- map["refreshable"]
        widget <- (map["widget"], WidgetTranform())
        navigationBar <- map["navigationBar"]
    }
    
    public required init?(map: Map) {

    }
    
    @objc public static func pager(jsonStr: String)->MagicPagerModel? {
        return MagicPagerModel.init(JSONString: jsonStr)
    }
    
    @objc public func toMagicJSON()-> String? {
        self.toJSONString()
    }
    
    //页面背景颜色
    @objc public var bgColor: String = "#ffffff"
    //页面背景图片
    @objc public var bgImage: String?
    //页面描述 （仅用于json查看）
    @objc public var desc: String?
    //页面是否支持下拉刷新 默认false
    @objc public var refreshable: Bool = false
    //页面控件列表
    @objc public var widget: BaseWidgetModel = BaseWidgetModel()
    //页面导航栏
    @objc public var navigationBar: NavigationBarModel? = nil
}
