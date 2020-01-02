//
//  MagicCell.swift
//  magicpager
//
//  Created by Sven on 19/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit

@objc public protocol MagicCellDelegate:NSObjectProtocol {
    @objc func magicCellResizeSize(width: CGFloat, height: CGFloat, index: Int)
}

@objc public class MagicCell: UITableViewCell, IMagicDelegate {
    private var _magicView: IMagic? 
    
    private weak var _delegate: MagicCellDelegate?
    
    private var _index: Int = 0
    
    func setIndex(index: Int) {
        _index = index
    }
    
    @objc public func setDelegate(delegate: MagicCellDelegate) {
        _delegate = delegate
    }
    
    /**
     传入父控件最大宽度，高度，-2 = 自适应
     */
    @objc public func analysis(model: BaseWidgetModel, maxWidth:CGFloat, maxHeight:CGFloat){
        
        self.backgroundColor = UIColor.clear
        
        //update
        if (_magicView != nil && model.type == _magicView?.currentModel.type) {
            _magicView?.updateWidget(model: model)
        } else {
        //new 
            _magicView?.removeFromSuperview()
            
            let magicView = MagicViewCreator.createView(model: model,
                                                        maxWidth: maxWidth,
                                                        maxHeight: maxHeight,
                                                        delegate: self)
            
            _magicView = magicView
            self.contentView.addSubview(_magicView!)
        }
    }
    
    
    
    //MARK:- IMagicDelegate method
    public func magicSizeDidChange(view:IMagic, width: CGFloat, height: CGFloat) {
        self._delegate?.magicCellResizeSize(
            width: width,
            height: height,
            index: self._index )
    }
}
