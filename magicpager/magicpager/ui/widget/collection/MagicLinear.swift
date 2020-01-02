//
//  MagicLinear.swift
//  magicpager
//
//  Created by Sven on 06/12/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation
import TangramKit


@objc public class MagicLinear: ICollectionMagic, IMagicDelegate {
    
    private var _maxLinearHeight: CGFloat = 0
    private var _maxLinearWidth: CGFloat = 0
    
    override public func createContainerView<V, T>(model: T, frame: CGRect) -> V where V : UIView, T : LinearWidgetModel {
        let orientation = model.orientation == Orientation.HORIZONTAL ? TGOrientation.horz : TGOrientation.vert
        
        let layout = TGLinearLayout.init(frame: frame, orientation: orientation)
        
        layout.tg_gravity = [TGGravity.vert.bottom, TGGravity.horz.right]
        
        if let view = layout as? V  {
            model.items.forEach { (item) in
                if let magic = MagicViewCreator.createView(
                    model: item, 
                    maxWidth: _contentMaxWidth, 
                    maxHeight: _contentMaxHeight, 
                    delegate: self) {
                    
                    view.addSubview(magic)
                }
            }
            
            return view
        } else {
            return UIView.init(frame: frame) as! V
        }
        
    }
    
    
    //MARK:- IMagicDelegate method
    public func magicSizeDidChange(view:IMagic, width: CGFloat, height: CGFloat) {
        guard width > _maxLinearWidth || height > _maxLinearHeight else {
            return
        }
        _maxLinearWidth = width > _maxLinearWidth ? width : _maxLinearWidth
        _maxLinearHeight = height > _maxLinearHeight ? height : _maxLinearHeight
    }
}
