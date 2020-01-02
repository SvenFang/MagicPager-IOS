//
//  ICollectionMagic.swift
//  magicpager
//
//  Created by Sven on 14/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class ICollectionMagic : IMagic {
    
    override public func createContainerView<V, T>(model: T, frame: CGRect) -> V where V : UIView, T : BaseCollectionWidgetModel {
        let view = UIView.init(frame: frame) as! V
        return view
    }
    
    
}
