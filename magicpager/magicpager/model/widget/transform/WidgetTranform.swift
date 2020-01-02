//
//  WidgetTranform.swift
//  magicpager
//
//  Created by Sven on 13/12/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation
open class WidgetTranform: TransformType {
    
    public typealias Object = BaseWidgetModel
    public typealias JSON = Any
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> BaseWidgetModel? {
        //        print("sss json-> \(String(describing: value))")
        var widget:BaseWidgetModel = BaseWidgetModel()
        
        if (value is [String: Any]) {
            
            let modelType = WidgetModelMapping.instance.getModelClass(type: (value as! [String: Any])["type"] as! String)
            
            let model = modelType?.init(map: Map.init(mappingType: MappingType.fromJSON, JSON: (value as? [String: Any])!))
            
            if (nil != model) {
                widget = model!
            } 
        }
        return widget
    }
    
    public func transformToJSON(_ value: BaseWidgetModel?) -> Any? {
        
        guard nil != value else {
            return nil
        }
        return value?.toJSON()
    }

}
