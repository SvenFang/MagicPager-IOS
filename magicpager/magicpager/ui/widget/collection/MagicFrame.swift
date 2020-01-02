//
//  MagicFrame.swift
//  magicpager
//
//  Created by Sven on 14/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class MagicFrame: ICollectionMagic {

    override public func createContainerView<V, T>(model: T, frame: CGRect) -> V where V : UIView, T : FrameWidgetModel {
        let view = UIView.init(frame: frame) as! V
        
        model.items.forEach { (item) in
            let maxSize = getItemMaxSize(item: item)
            
            let magic = MagicViewCreator.createView(
                model: item, 
                maxWidth: maxSize.0, 
                maxHeight: maxSize.1, 
                delegate: nil) 
            
            if (nil != magic) {
                self.addSubview(magic!)
            }
        }
        
        return view
    }
    
    private func getItemMaxSize(item: BaseWidgetModel) -> (maxItemWidth: CGFloat, maxItemHeight: CGFloat) {
        
        var maxWidth = _contentMaxWidth
        var maxHeight = _contentMaxHeight
        
        if (_contentMaxWidth >= 0) {
            maxWidth = _contentMaxWidth - LengthUtil.instance.length2px(length: item.x)
            maxWidth = maxWidth > 0 ? maxWidth :0
        }
        
        if (_contentMaxHeight >= 0) {
            maxHeight = _contentMaxHeight - LengthUtil.instance.length2px(length: item.y)
            maxHeight = maxHeight > 0 ? maxHeight :0
        }
        
        return (maxWidth, maxHeight)
    }

    
}
