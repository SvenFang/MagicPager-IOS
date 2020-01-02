//
//  MagicButton.swift
//  magicpager
//
//  Created by Sven on 14/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class MagicButton: IMagic {
    
    override public func createContainerView<V, T>(model: T, frame: CGRect) -> V where V : UIButton, T : ButtonWidgetModel {
        let btn:V = UIButton.init(frame: frame) as! V
        
        guard (nil != model.text && model.text!.count>0) else {
            return btn
        }
        
        btn.isUserInteractionEnabled = false
        
        let attStr = NSMutableAttributedString.init(string: model.text!)
        let textSize = LengthUtil.instance.length2px(length: CGFloat(model.textSize))
        attStr.addAttributes(
            [NSAttributedString.Key.font:UIFont.systemFont(ofSize: textSize), 
             NSAttributedString.Key.foregroundColor:UIColor.init(hex: model.textColor)],
            range: NSRange.init(location: 0, length: model.text!.count))
        
        
        let rect = attStr.boundingRect(
            with: 
            CGSize.init(
                width: _contentMaxWidth>=0 ? _contentMaxWidth : CGFloat.greatestFiniteMagnitude, 
                height: _contentMaxHeight>=0 ? _contentMaxHeight : CGFloat.greatestFiniteMagnitude
            ), 
            options: [NSStringDrawingOptions.truncatesLastVisibleLine, NSStringDrawingOptions.usesFontLeading], 
            context: nil)
        
        let size = getContextSize(width: rect.size.width,
                                  height: rect.size.height)
        var nFrame = frame
        nFrame.size.width = size.0
        nFrame.size.height = size.1
        btn.frame = nFrame
        
        btn.setAttributedTitle(attStr, for: UIControl.State.normal)
        
        return btn
    }
}
