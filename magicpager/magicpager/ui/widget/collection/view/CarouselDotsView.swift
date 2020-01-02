//
//  CarouselDotsView.swift
//  magicpager
//
//  Created by Sven on 15/11/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation
import SnapKit

class CarouselDotsView: UIView {
    
    private var _dots: [UIView] = [UIView]()
    
    private var _defaultColor = "#777777"
    private var _selectedColor = "#444444"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setSelectIndex(index: Int) {
        for i in 0..<_dots.count {
            let view = _dots[i]
            view.backgroundColor = UIColor.init(hex: i == index ? _selectedColor : _defaultColor )
        }
    }
    
    func setDots(count:Int,
                 dotSelectedColor: String,
                 dotDefaultColor: String,
                 dotSpace: CGFloat,
                 dotWidth: CGFloat) {
        self.subviews.forEach { (v) in
            v.removeFromSuperview()
        }
        
        _dots.removeAll()
        
        _defaultColor = dotDefaultColor
        _selectedColor = dotSelectedColor
        
        let totalLength: CGFloat = dotWidth * CGFloat(count) + dotSpace * CGFloat(count - 1)
        let centerX: CGFloat = totalLength / 2 
        
        for i in 0..<count {
            let dot = UIView.init(frame: CGRect.init(x: 0, y: 0, width: dotWidth, height: dotWidth))
            
            if (i == 0 ) {
                dot.backgroundColor = UIColor.init(hex: dotSelectedColor)
            } else {
                dot.backgroundColor = UIColor.init(hex: dotDefaultColor)
            }
            
            dot.layer.masksToBounds = true
            dot.layer.cornerRadius = dotWidth/2
            
            self.addSubview(dot)
            _dots.append(dot)
            
            dot.snp_makeConstraints { (make) in
                make.centerY.equalTo(self)
                make.height.equalTo(dotWidth)
                make.width.equalTo(dotWidth)
                make.centerX.equalTo(self)
                    .offset(CGFloat(i) * (dotSpace + dotWidth) - dotWidth / 2 - centerX)
            }
            
        }
    }
    
    
    
    
}
