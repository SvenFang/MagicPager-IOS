//
//  JSCoreManager.swift
//  magicpager
//
//  Created by Sven on 10/12/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation
import JavaScriptCore

@objc public protocol ActionProvider {
    @objc func actionType() -> String
    @objc func invoke(vc:UIViewController, key:String, param: String?)-> String?
}

@objc open class JSCoreManager: NSObject {
    
    @objc public static let instance = JSCoreManager()
    
    public var _actionProviders = [ActionProvider]()
    
    private override init() {
        super.init()
        addActionProvider(provider: MagicProvider.init())
        addActionProvider(provider: TestProvider.init())

    }
    
    @objc public func addActionProvider(provider: ActionProvider) {
        _actionProviders.append(provider)
    }
    
    @objc public func evaluateScript(vc:UIViewController, script: String) {
        var context: JSCoreContext? = vc.jsCoreContex
        if (nil == context) {
            context = JSCoreContext.init(vc: vc)
            vc.jsCoreContex = context
            context?.evaluateScript(script: script)
        } else {
            context?.evaluateScript(script: script)
        }
        
    }
    
    
}

//MARK: - 
@objc class MagicProvider: NSObject, ActionProvider {
    func actionType() -> String {
        return "magic"
    }
    
    func invoke(vc:UIViewController ,key:String, param: String?)-> String? {
        switch key {
        case "dismiss":
            vc.navigationController?.popViewController(animated: true)
            break
            
        case "show":
            guard nil != param else {
                return nil
            }
            
            let requestParam = PagerRequestData.init(JSONString: param!)
            
            guard nil != requestParam?.key && nil != requestParam?.type else {
                return nil
            }
            
            let magicVC = MagicViewController.createMagic(requestData: requestParam!)
            vc.navigationController?.pushViewController(magicVC, animated: true);
            return nil
            
        default: 
            break
            
        }
        
        return nil
    }
}

class TestProvider: ActionProvider {
    func actionType() -> String {
        return "test"
    }
    
    func invoke(vc:UIViewController ,key:String, param: String?)-> String? {
        switch key {
        case "test1":
            
            return "test1"
            
        case "test2":
            
            return "test2"
            
        default: 
            break
            
        }
        
        return nil
    }
}

