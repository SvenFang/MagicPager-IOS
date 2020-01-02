//
//  UIViewControllerExtension.swift
//  magicpager
//
//  Created by Sven on 18/12/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation

private var jsCoreKey = 100001 

extension UIViewController {
    var jsCoreContex: JSCoreContext? {
        set {
            objc_setAssociatedObject(self, &jsCoreKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        
        get {
            if let rs = objc_getAssociatedObject(self, &jsCoreKey) as? JSCoreContext {
                return rs
            }
            return nil
        }
    }
    
}
