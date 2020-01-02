//
//  MagicPagerManager.swift
//  magicpager
//
//  Created by Sven on 08/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit
import SDWebImage


@objc open class MagicPagerManager: NSObject {
    @objc public static let LOG_TAG = "[MAGIC_PAGER]"
    
    @objc public static let instance = MagicPagerManager()
    
    private var _log: ILog?
    
    @objc public func setLogger(logger: ILog) {
        _log = logger
    }
    

    private override init() {
    }
    
    private var pagerProviders = Dictionary<String, IMagicProvider>()
    
    @objc public func addPagerProvider(provider: IMagicProvider) {
        pagerProviders.updateValue(provider, forKey: provider.getProviderType()) 
    }
    
    public func getMagic(type: String, key: String, params: Dictionary<String, Any>?, callback: MagicProviderCallBack) {
        log(msg: "getMagic type:\(type), key:\(key), params:\(params ?? Dictionary())")
        
        pagerProviders[type]?.getMagicData(key: key, params: params, callBack: callback)
    }
    
    public func log(msg: String) {
        _log?.log(tag: MagicPagerManager.LOG_TAG, msg: msg)
    }
}
