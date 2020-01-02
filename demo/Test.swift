//
//  Test.swift
//  demo
//
//  Created by Sven on 09/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit
import magicpager
@objc class Test:NSObject, ILog {
    @objc public static let instance = Test()
    private override init() {
        
    }
    
    
    @objc public func log(tag:String, msg: String) {
        print("\(tag): \(msg)")
    }
}
