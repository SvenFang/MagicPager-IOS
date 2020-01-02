//
//  BaseWidgetModel.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit
@_exported import ObjectMapper

//充满父控件

@objc public class ModelConstants: NSObject {
    @objc public static let MATCH_PARENT: CGFloat = -1 
    @objc public static let WRAP_CONTENT: CGFloat = -2
}

@objc public class Margin:NSObject, Mappable{
    public var left: CGFloat = 0
    public var  top: CGFloat = 0
    public var right: CGFloat = 0
    public var bottom: CGFloat = 0
    
    required public init?(map: Map) {
    }
    
    @objc public init(left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) {
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
    }
    
    public func mapping(map: Map) {
        left <- map["left"]
        top <- map["top"]
        right <- map["right"]
        bottom <- map["bottom"]
    }
}

@objc public class Padding:NSObject, Mappable{
    public var left: CGFloat = 0
    public var  top: CGFloat = 0
    public var right: CGFloat = 0
    public var bottom: CGFloat = 0
    
    required public init?(map: Map) {
    }
    
    @objc public init(left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) {
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
    }
    
    public func mapping(map: Map) {
        left <- map["left"]
        top <- map["top"]
        right <- map["right"]
        bottom <- map["bottom"]
    }
}

@objc public protocol ModelActionDelegate: NSObjectProtocol {
    @objc func magicViewDidClick(view: IMagic, controller: UIViewController?)
}

@objc public class BaseWidgetModel: NSObject, NSCopying, Mappable {
    
    @objc public func toMagicJSON()-> String? {
        self.toJSONString()
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let theCopyObj = Swift.type(of: self).init()
        theCopyObj.type = self.type 
        theCopyObj.bgColor = self.bgColor 
        theCopyObj.width = self.width 
        theCopyObj.height = self.height 
        theCopyObj.border = self.border 
        theCopyObj.borderColor = self.borderColor 
        theCopyObj.corner = self.corner 
        theCopyObj.padding = self.padding 
        theCopyObj.margin = self.margin 
        theCopyObj.x = self.x 
        theCopyObj.y = self.y 
        theCopyObj.position = self.position 
        theCopyObj.action = self.action 
        theCopyObj.disable = self.disable 
        theCopyObj.reuseId = self.reuseId
        return theCopyObj
    }
    
    public static func == (lhs: BaseWidgetModel, rhs: BaseWidgetModel) -> Bool {
        return lhs.type == rhs.type &&
            lhs.bgColor == rhs.bgColor &&
            lhs.width == rhs.width &&
            lhs.height == rhs.height &&
            lhs.border == rhs.border &&
            lhs.borderColor == rhs.borderColor &&
            lhs.corner == rhs.corner &&
            lhs.padding == rhs.padding &&
            lhs.margin == rhs.margin &&
            lhs.x == rhs.x &&
            lhs.y == rhs.y &&
            lhs.position == rhs.position &&
            lhs.action == rhs.action &&
            lhs.disable == rhs.disable &&
            lhs.reuseId == rhs.reuseId
    }
    
    public func mapping(map: Map) {
        type <- map["type"]
        bgColor <- map["bgColor"]
        width <- map["width"]
        height <- map["height"]
        border <- map["border"]
        borderColor <- map["borderColor"]
        corner <- map["corner"]
        padding <- map["padding"]
        margin <- map["margin"]
        x <- map["x"]
        y <- map["y"]
        position <- map["position"]
        action <- map["action"]
        disable <- map["disable"]
        reuseId <- map["reuseId"]
    }
    
    public required init?(map: Map) {
        super.init()
        self.mapping(map: map)
    }
    
    @objc public required override init() {
        
    }
    
    //控件类型
    @objc public var type: String = WidgetModelType.BLANK_TYPE
    //控件背景颜色 默认透明
    @objc public var bgColor: String = "#00000000"
    //控件宽度/高度 -2:自适应宽度，-1:充满父控件 其他:单位长度
    @objc public var width: CGFloat = ModelConstants.WRAP_CONTENT
    @objc public var height: CGFloat = ModelConstants.WRAP_CONTENT
    //边框 单位长度边宽
    @objc public var border: CGFloat = 0
    //边框颜色
    @objc public var borderColor: String = "#00000000"
    //控件圆角角度
    @objc public var corner: CGFloat = 0
    //内边距
    @objc public var padding: Padding = Padding.init(left: 0, top: 0, right: 0, bottom: 0)
    //外边距
    @objc public var margin: Margin = Margin.init(left: 0, top: 0, right: 0, bottom: 0)
    //控件xy坐标
    @objc public var x: CGFloat = 0 //根据某些父容器适用
    @objc public var y: CGFloat = 0 //根据某些父容器适用
    //控件位置 NONE:默认线性排布 FIX:固定于上下左右 FLOAT:上下左右浮动
    @objc public var position: String = WidgetModelPosition.NONE
    
    //action 控件点击事件，可解析js方法
    @objc public var action: String? = nil
    //本地构建model使用 传入
    @objc public weak var actionDelegate: ModelActionDelegate? = nil
    //不可点击，不拦截点击事件
    @objc public var disable = false
    //view 重用id 0表示不重用 至少同个type下唯一
    @objc public var reuseId: Int32 = 0
}
