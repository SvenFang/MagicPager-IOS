//
//  TestPagerProvider.swift
//  demo
//
//  Created by Sven on 15/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit
import magicpager

class TestPagerProvider: Any, IMagicProvider {
    
    public static let instance = TestPagerProvider()
    private init() {
        
    }
    
    func getProviderType()-> String {
        return "test"
    }
    
    func getMagicData(key: String, params: Dictionary<String, Any>?, callBack: MagicProviderCallBack) {
    
    
        let path = Bundle.main.path(forResource: key, ofType: "geojson");
        if (path != nil) {
            do {
                let d = try Data(contentsOf: URL(fileURLWithPath: path!))
                
                let jsonString = String(data: d, encoding: String.Encoding.utf8)
                let pager = MagicPagerModel.init(JSONString: jsonString!)
            
                if (nil != pager) {
                    callBack.onSuccess(resp: pager!)
                } else {
                    callBack.onError(error: "解析失败")
                }
                
            } catch let error {
                print("error -> \(String(describing: error))");
                callBack.onError(error: String(describing: error))
            }
        } else {
            callBack.onError(error: "没有此文件-> \(key)")
        }
        
        
    }
}
