//
//  PagerRequestData.swift
//  magicpager
//
//  Created by Sven on 12/12/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation
@objc public class PagerRequestData: NSObject, Mappable {
    
    var type: String = ""
    var key: String = ""
    var param: [String: NSObject]?
    
    required public init?(map: Map) {
    }
    
    @objc public init(type: String, key: String, param: [String: NSObject]? = nil) {
        self.type = type
        self.key = key
        self.param = param
    }
    
    
    public func mapping(map: Map) {
        type <- map["type"]
        key <- map["key"]
        param <- map["param"]
    }
    
    @objc public func jsonString() -> String? {
        toJSONString(prettyPrint: false)
    }
}
