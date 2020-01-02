//
//  MagicImage.swift
//  magicpager
//
//  Created by Sven on 14/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit
import SDWebImage

@objc public class MagicImage: IMagic {
    
    override public func createContainerView<V, T>(model: T, frame: CGRect) -> V where V : UIImageView, T : ImageWidgetModel {
        let image = UIImageView.init(frame: frame)
        
        switch model.scaleType {
        case ScaleType.CROP:
            image.contentMode = UIView.ContentMode.scaleAspectFill
            break
        case ScaleType.FIX:
            image.contentMode = UIView.ContentMode.scaleToFill
            break
        case ScaleType.INSIDE:
            image.contentMode = UIView.ContentMode.scaleAspectFit
            break
        default:
            image.contentMode = UIView.ContentMode.scaleAspectFill
        }
        
        if (model.imgSrc?.count ?? 0 > 0 ) {
            let charSet = CharacterSet.urlQueryAllowed
            let url = model.imgSrc!.addingPercentEncoding(withAllowedCharacters: charSet )
            let u = URL.init(string: url!)
            image.sd_setImage(with: u) { [weak self](img, error, cacheType, url) in
                guard nil != img else {
                    return
                } 
                
                self?.needResizeContentSize(width: img!.size.width, height: img!.size.height)
                                    
                self?.reziseImage(view: image, width: img!.size.width, height: img!.size.height)
            }
        }
        
        return image as! V
    }
    
    private func reziseImage(view: UIImageView, width: CGFloat, height: CGFloat) {
        guard nil == containerView else {
            return
        }
        
        var frame = view.frame
        let size = getContextSize(width: width, height: height)
        frame.size.width = size.0
        frame.size.height = size.1
        view.frame = frame
    }

}
