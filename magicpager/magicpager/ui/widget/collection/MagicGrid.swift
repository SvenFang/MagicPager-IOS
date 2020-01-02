//
//  MagicGrid.swift
//  magicpager
//
//  Created by Sven on 14/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class MagicGrid: ICollectionMagic {
    override public func createContainerView<V, T>(model: T, frame: CGRect) -> V where V : UIView, T : GridWidgetModel {
        let view = UIView.init(frame: frame) as! V
        guard (_contentMaxWidth > 0 && _contentMaxHeight > 0) else {
            return view
        }
        
        let cellWidth = model.width / CGFloat(model.column)
        let cellHeight = model.height / CGFloat(model.row)
        
        model.items.forEach { (item) in
            
            let newItem = item.copy() as! BaseWidgetModel
            newItem.x = cellWidth * item.x 
            newItem.y = cellHeight * item.y 
            newItem.width = cellWidth * item.width
            newItem.height = cellHeight * item.height
            
            let magic = MagicViewCreator.createView(
                model: newItem, 
                maxWidth: LengthUtil.instance.length2px(length: CGFloat(cellWidth)), 
                maxHeight: LengthUtil.instance.length2px(length: CGFloat(cellHeight)),
                delegate: nil)
            
            if (nil != magic) {
                view.addSubview(magic!)
            }
        }
        
        return view
    }
    
    
    
}
