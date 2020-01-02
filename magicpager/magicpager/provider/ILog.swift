//
//  ILog.swift
//  magicpager
//
//  Created by Sven on 08/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation

@objc public protocol ILog: NSObjectProtocol {
    @objc func log(tag:String, msg: String)
}
