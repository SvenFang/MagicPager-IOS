//
//  MagicText.swift
//  magicpager
//
//  Created by Sven on 14/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public class MagicText: IMagic {
    
    override public func createContainerView<V, T>(model: T, frame: CGRect) -> V where V : UILabel, T : TextWidgetModel {
        
        let text:V = UILabel.init(frame: frame) as! V;
        text.numberOfLines = model.maxLines
        let attrStr = magicText(model: model)
        text.attributedText = attrStr
        
        let rect = attrStr?.boundingRect(
            with: CGSize.init(
                width: _contentMaxWidth>0 ? _contentMaxWidth : CGFloat.greatestFiniteMagnitude, 
                height: _contentMaxHeight>0 ? _contentMaxHeight : CGFloat.greatestFiniteMagnitude), 
            options: [NSStringDrawingOptions.truncatesLastVisibleLine, NSStringDrawingOptions.usesFontLeading], 
            context: nil)

        let size = getContextSize(width: rect?.size.width ?? 0, height: rect?.size.height ?? 0 )
        var nFrame = frame
        nFrame.size.width = size.0
        nFrame.size.height = size.1
        text.frame = nFrame
    
        return text
    }
    
    private func magicText(model: TextWidgetModel) -> NSAttributedString? {
        guard nil != model.text else {
            return nil
        }
        let attrStr = NSMutableAttributedString.init(string: model.text!)
        let textRange = NSRange.init(location: 0, length: model.text?.count ?? 0)
        let textColor = UIColor.init(hex: model.textColor)
        let textSize = LengthUtil.instance.length2px(length: CGFloat(model.textSize))
        let font = model.bold ? UIFont.boldSystemFont(ofSize: textSize) : UIFont.systemFont(ofSize: textSize)
        
        attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: textRange)
        
        attrStr.addAttribute(NSAttributedString.Key.font, value: font, range: textRange)
        
        if (model.italic) {
            attrStr.addAttribute(NSAttributedString.Key.obliqueness, value: 0.3, range: textRange)
        }
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = LengthUtil.instance.length2px(length: CGFloat(model.lineSpacing))
        
        switch model.textHorizontalAlignment 
        {
            case HorizontalAlignment.LEFT:
                paragraphStyle.alignment = NSTextAlignment.left
                break
            case HorizontalAlignment.CENTER:
                paragraphStyle.alignment = NSTextAlignment.center
                break
            case HorizontalAlignment.RIGHT:
                paragraphStyle.alignment = NSTextAlignment.right
                break
        
        default:
            paragraphStyle.alignment = NSTextAlignment.left
        }
        
        attrStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        
        return attrStr
    }
}
