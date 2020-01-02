//
//  UIViewExten.swift
//  magicpager
//
//  Created by Sven on 11/12/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation

extension UIView {
    //返回该view所在VC
    @objc public func firstViewController() -> UIViewController? {
        var n = self.next
        while n != nil {
            if (n is UIViewController) {   
                return n as? UIViewController
            }
            n = n?.next
        }
        return nil
    }
}

