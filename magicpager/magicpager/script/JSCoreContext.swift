//
//  JSCoreContext.swift
//  magicpager
//
//  Created by Sven on 17/12/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation
import JavaScriptCore

@objc protocol JSBridge: JSExport {
    @objc func call(_ type: String, _ key: String, _ params: String, _ callBack: JSValue)
    @objc func log(_ tag: String, _ info: String)
}

class JSCoreContext: NSObject {
    private var _context: JSContext
    
    init(vc: UIViewController) {
        
        _context = JSContext.init()
        _context.exceptionHandler = {(context, value) in 
            print("js exception -> \(String(describing: value))")   
        }
        
        
        let jsBridge = JSActionBridge()
        jsBridge._vc = vc
        _context.setObject(jsBridge, forKeyedSubscript: "native" as NSCopying & NSObjectProtocol)
    }
    
    func evaluateScript(script: String) {
        _context.evaluateScript(script)
    }
    
    deinit {
        print("JSCoreContext deinit")
    }
}


class JSActionBridge:NSObject, JSBridge {  
    weak var _vc: UIViewController?
    
    func call(_ type: String, _ key: String, _ params: String, _ callBack: JSValue)  {
        
        let realParam: String? = (params == "undefined") ? nil : params  
        
        JSCoreManager.instance._actionProviders.forEach { (provider) in
            if (provider.actionType() == type && nil != _vc) {
                
                let result = provider.invoke(vc:_vc!, key: key, param: realParam)                
                if (!callBack.isUndefined) {
                    callBack.call(withArguments: nil != result ? [result!] : [])    
                }
            }
        }
    }
    
    func log(_ tag: String, _ info: String) {
        print("\(tag), \(info)")
    }
    
    deinit {
        print("JSActionBridge deinit")
    }
}
