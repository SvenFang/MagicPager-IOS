//
//  MagicCollectionCell.swift
//  magicpager
//
//  Created by Sven on 14/11/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation
class MagicCollectionCell: UICollectionViewCell, IMagicDelegate {
    private var _magicView: IMagic? 
    
    private var _currentModel: BaseWidgetModel?
    
    private weak var _delegate: MagicCellDelegate?
    
    private var _index: Int = 0
    
    func setIndex(index: Int) {
        _index = index
    }
    
    func setDelegate(delegate: MagicCellDelegate) {
        _delegate = delegate
    }
    
    /**
     传入父控件最大宽度，高度，-2 = 自适应
     */
    func analysis(model: BaseWidgetModel, maxWidth:CGFloat, maxHeight:CGFloat){
        
        self.backgroundColor = UIColor.clear
        
        //update
        if (_magicView != nil && _currentModel != nil && model == _currentModel!) {
            // isSame
            _magicView?.updateWidget(model: model)
        } else {
            //new 
            _magicView?.removeFromSuperview()
            
            let magicView = MagicViewCreator.createView(model: model,
                                                        maxWidth: maxWidth,
                                                        maxHeight: maxHeight,
                                                        delegate: self)
            
            _magicView = magicView
            _currentModel = model
            self.contentView.addSubview(_magicView!)
        }
    }
    
    //MARK:- IMagicDelegate method
    func magicSizeDidChange(view:IMagic, width: CGFloat, height: CGFloat) {
        self._delegate?.magicCellResizeSize(
            width: width,
            height: height,
            index: self._index)
    }
} 
