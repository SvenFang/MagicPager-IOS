//
//  MagicSvga.swift
//  magicpager
//
//  Created by Sven on 13/12/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import Foundation
import SVGAPlayer

@objc public protocol MagicSvgaDelegate: NSObjectProtocol {
    @objc func onFinished(svga: MagicSvga)
    @objc func onStart(svga: MagicSvga)
    @objc func onError(svga: MagicSvga)
}

@objc public class MagicSvga: IMagic, SVGAPlayerDelegate{
    
    @objc public weak var svgaDelegate: MagicSvgaDelegate?
    
    override public func createContainerView<V, T>(model: T, frame: CGRect) -> V where V : SVGAPlayer, T : SvgaWidgetModel {
        
        let v = SVGAPlayer.init(frame: frame) as! V
        v.delegate = self
        
        model.imageMap.forEach { (item) in
            let imgUrl = URL.initPercent(string: item.value)
            if (nil != imgUrl) {
                v.setImageWith(imgUrl, forKey: item.key)
            }
        }
        
        model.textMap.forEach { [weak self](item) in
            if (nil != self) {
                v.setDrawing({ (layer, index) in
                    if let svgaLayer = layer as? SVGAContentLayer {
                        if (nil != self && nil == svgaLayer.textLayer && svgaLayer.frame != CGRect.zero) {
                            let textLayer = self!.createTextLayerFor(svgaText: item.value)
                            textLayer.frame = CGRect.init(x: 0, y: 0, width: svgaLayer.frame.size.width, height: svgaLayer.frame.size.height)
                            svgaLayer.addSublayer(textLayer)
                            svgaLayer.textLayer = textLayer
                        }
                    }
                    
                }, forKey: item.key)
            }
        }
        
        let parser = SVGAParser.init()
        
        if (nil != model.sourceUrl) {
            
            parser.parse(with: URL.init(string: model.sourceUrl!)!, completionBlock: { [weak self](entity) in
                if (nil != entity) {
                    self?.refreshEntity(entity: entity!, player: v, model: model)
                }
            }) { [weak self](_) in
                self?.svgaDelegate?.onError(svga: self!)
            }
            
        } else if (nil != model.assetUrl) {
            parser.parse(withNamed: model.assetUrl!, in: nil, completionBlock: { [weak self](entity) in
                self?.refreshEntity(entity: entity, player: v, model: model)
            }) { [weak self](_) in
                self?.svgaDelegate?.onError(svga: self!)
            }
        }
        
        return v
    }
    
    private func refreshEntity(entity: SVGAVideoEntity,
                               player: SVGAPlayer,
                               model: SvgaWidgetModel) {
        player.videoItem = entity
        player.clearsAfterStop = model.cleanAfterStop
        player.loops = Int32(model.loops)
        
        needResizeContentSize(width: entity.videoSize.width, height: entity.videoSize.height)
        
        startAnimation()
    }
    
    private var _svgaTimer: Timer?
    private func startTimer() {
        _svgaTimer?.invalidate()
        
        let model = currentModel as? SvgaWidgetModel
        
        if (nil != model && model!.loops <= 0 && model!.duration > 0) {
            //无限循环 & 播放时长>0 设置定时停止
            _svgaTimer = Timer.scheduledTimer(timeInterval: TimeInterval(model!.duration), target: self, selector: #selector(svgaTimerAction(timer:)), userInfo: nil, repeats: false)
        }
    }
    
    @objc private func svgaTimerAction(timer: Timer) {
        stopAnimation()
    }
    
    
    @objc public func startAnimation() {
        
        if let svga = containerView as? SVGAPlayer {
            startTimer()
            svga.startAnimation()
            svgaDelegate?.onStart(svga: self)
        }
    }

    @objc public func stopAnimation() {
        (containerView as? SVGAPlayer)?.stopAnimation()
        _svgaTimer?.invalidate()
    }
    
    private func createTextLayerFor(svgaText: SvgaText)-> CATextLayer {
        
        let textLayer = CATextLayer.init()
        
        switch svgaText.alignment 
        {
            case HorizontalAlignment.LEFT:
                textLayer.alignmentMode = CATextLayerAlignmentMode.left
                break
            case HorizontalAlignment.CENTER:
                textLayer.alignmentMode = CATextLayerAlignmentMode.center
                break
            case HorizontalAlignment.RIGHT:
                textLayer.alignmentMode = CATextLayerAlignmentMode.right
                break
        
        default:
            textLayer.alignmentMode = CATextLayerAlignmentMode.left
        }
        textLayer.string = svgaText.text
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.fontSize = LengthUtil.instance.length2px(length: svgaText.textSize)
        textLayer.foregroundColor = UIColor.init(hex: svgaText.color).cgColor
        textLayer.isWrapped = true
        
        return textLayer
    } 
    
    
    private func createAttrStringFor(svgaText: SvgaText)-> NSAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = 4 
        paragraphStyle.lineBreakMode = NSLineBreakMode.byClipping
        
        switch svgaText.alignment 
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
        
        let string = NSAttributedString.init(
            string: svgaText.text, 
            attributes: 
            [NSAttributedString.Key.paragraphStyle: paragraphStyle,
             NSAttributedString.Key.foregroundColor: UIColor.init(hex: svgaText.color),
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: LengthUtil.instance.length2px(length: svgaText.textSize))])
        
        return string
    } 

    

    //MARK:- SVGAPlayerDelegate method
    public func svgaPlayerDidAnimated(toFrame frame: Int) {
    }
    
    public func svgaPlayerDidFinishedAnimation(_ player: SVGAPlayer!) {
        svgaDelegate?.onFinished(svga: self)
    }
    
    public func svgaPlayerDidAnimated(toPercentage percentage: CGFloat) {
    }
    
    
}
