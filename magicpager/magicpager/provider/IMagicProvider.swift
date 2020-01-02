//
//  IMagicProvider.swift
//  magicpager
//
//  Created by Sven on 08/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation
@objc public protocol IMagicProvider {
    @objc func getProviderType()-> String
    @objc func getMagicData(key: String, params: Dictionary<String, Any>?, callBack: MagicProviderCallBack)
}

@objc public protocol MagicProviderCallBack {
    @objc func onSuccess(resp: MagicPagerModel)
    @objc func onError(error: String)
}
