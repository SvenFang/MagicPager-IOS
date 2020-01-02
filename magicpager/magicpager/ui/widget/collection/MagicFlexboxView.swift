//
//  MagicFlexboxView.swift
//  magicpager
//
//  Created by Sven on 14/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit
import TangramKit

@objc public class MagicFlexboxView: ICollectionMagic, IMagicDelegate {

    public override func createContainerView<V, T>(model: T, frame: CGRect) -> V where V : UIView, T : FlexboxWidgetModel {
        let layout = TGFlowLayout.init(frame: frame)
        
        //方向
        switch model.flexDirection {
        case MFlexDirection.ROW:
            layout.tg_orientation = TGOrientation.vert 
            layout.tg_gravity = TGGravity.vert.top
            break
        case MFlexDirection.COLUMN:
            layout.tg_orientation = TGOrientation.horz
            layout.tg_gravity = TGGravity.horz.left
            break
        case MFlexDirection.ROW_REVERSE:
            layout.tg_orientation = TGOrientation.vert
            layout.tg_gravity = TGGravity.vert.bottom
            break
        case MFlexDirection.COLUMN_REVERSE:
            layout.tg_orientation = TGOrientation.horz
            layout.tg_gravity = TGGravity.horz.right
            break
        default:
            layout.tg_orientation = TGOrientation.vert
            layout.tg_gravity = TGGravity.vert.top
            break
        }
    
        switch model.justifyContent {
        case MJustifyContent.FLEX_START:
            layout.tg_arrangedGravity = layout.tg_orientation == TGOrientation.vert ? TGGravity.vert.top : TGGravity.horz.left
            break
        case MJustifyContent.FLEX_END:
            layout.tg_arrangedGravity = layout.tg_orientation == TGOrientation.vert ? TGGravity.vert.bottom : TGGravity.horz.right
            break
        case MJustifyContent.CENTER:
            layout.tg_arrangedGravity = layout.tg_orientation == TGOrientation.vert ? TGGravity.vert.center : TGGravity.horz.center
            break
        default: 
            break
        }
        
        
        model.items.forEach { (item) in
            if let magic = MagicViewCreator.createView(
                model: item, 
                maxWidth: _contentMaxWidth, 
                maxHeight: _contentMaxHeight, 
                delegate: self) {
                
                layout.addSubview(magic)
            }
        }
        
        return layout as! V
    }
    
    //MARK:- IMagicDelegate method
    public func magicSizeDidChange(view:IMagic, width: CGFloat, height: CGFloat) {
        
    }
}
