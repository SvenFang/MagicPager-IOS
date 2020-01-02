//
//  MagicBlank.swift
//  magicpager
//
//  Created by Sven on 14/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc class MagicBlank: IMagic {
    
    override func createContainerView<V, T>(model: T, frame: CGRect) -> V where V : UIView, T : BlankWidgetModel {
        let view = UIView.init(frame: frame)
        return view as! V
    }
}
