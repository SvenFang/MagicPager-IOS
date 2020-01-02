//
//  WidgetModelTranformType.swift
//  magicpager
//
//  Created by Sven on 22/10/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation

open class WidgetsTranform: TransformType {
    
    public typealias Object = [BaseWidgetModel]
    public typealias JSON = [Any]
    public init() {}

    open func transformFromJSON(_ value: Any?) -> [BaseWidgetModel]? {
//        print("sss json-> \(String(describing: value))")
        var widgets:[BaseWidgetModel] = [BaseWidgetModel]()
        
        if (value is [Any]) {
            for item in (value as! [Any]) {
                if (item is [String: Any]) {
                    
                    let modelType = WidgetModelMapping.instance.getModelClass(type: (item as! [String: Any])["type"] as! String)
                    
                    let model = modelType?.init(map: Map.init(mappingType: MappingType.fromJSON, JSON: (item as? [String: Any])!))
                    
                    if (nil != model) {
                        widgets.append(model!)
                    } 
                }
            } 
        }
        
        return widgets
    }
    open func transformToJSON(_ value: [BaseWidgetModel]?) -> [Any]? {
        var list = [Any]()
        value?.forEach({ (item) in
            let itemJson = item.toJSON()
            list.append(itemJson)
        })
        
        return list
    }
}
