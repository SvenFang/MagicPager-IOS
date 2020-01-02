//
//  IMagic.swift
//  magicpager
//
//  Created by Sven on 14/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit
@objc public protocol IMagicDelegate: NSObjectProtocol {
    func magicSizeDidChange(view:IMagic, width: CGFloat, height: CGFloat)
}

@objc public class IMagic: UIView {
    
    @objc public var containerView: UIView?
    @objc public private(set) var currentModel: BaseWidgetModel = BaseWidgetModel()
    
    //size 改变通知
    @objc public weak var delegate: IMagicDelegate?
    
    //父控件最大宽高
    private var _superMaxWidth: CGFloat = 0
    private var _superMaxHeight: CGFloat = 0
    
    //z子控件最大宽高
    var _contentMaxWidth: CGFloat = 0
    var _contentMaxHeight: CGFloat = 0
    
    var _originX = 0;
    var _originY = 0;
    
    /**
     传入父控件最大宽度，高度，-2 = 自适应
     */
    public required init(maxWidth: CGFloat, maxHeight: CGFloat, model: BaseWidgetModel) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear
        _superMaxWidth = maxWidth
        _superMaxHeight = maxHeight
        currentModel = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard nil == containerView else {
            return
        }
        
        if (_superMaxWidth == ModelConstants.MATCH_PARENT) {
            _superMaxWidth = self.superview?.frame.size.width ?? ModelConstants.MATCH_PARENT
        }
        
        if (_superMaxHeight == ModelConstants.MATCH_PARENT) {
            _superMaxHeight = self.superview?.frame.size.height ?? ModelConstants.MATCH_PARENT
        }
        
        analysis(model: currentModel)
    }
    
    @objc public func updateWidget(model: BaseWidgetModel) {
        analysis(model: model)
    }
    
    private func analysis<T:BaseWidgetModel>(model : T) {
        
        //判断是刷新还是
        guard (nil == containerView || currentModel != model) else {
            return
        }
        
        containerView?.removeFromSuperview()
        
        currentModel = model;
        
        layoutBaseInfo()
        
        //刷新父布局最大宽高
        if (model.width >= 0) {
            _superMaxWidth = LengthUtil.instance.length2px(length: model.width)
        }
        if (model.height >= 0) {
            _superMaxHeight = LengthUtil.instance.length2px(length: model.height)
        }
        
        //计算子控件最大宽高 传入并创建子控件
        _contentMaxWidth = getContentMaxWidth() 
        _contentMaxHeight = getContentMaxHeight()
        
        let frame = getFirstContentSize()
        containerView = createContainerView(model: model, frame: frame)
        containerView?.isUserInteractionEnabled = !model.disable
        let tapActionRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(tap:)))
        containerView?.addGestureRecognizer(tapActionRecognizer)
        
        self.addSubview(containerView!)
        resizeMagicView()
        magicDidAppear()
    }
    
    open func createContainerView<V: UIView, T:BaseWidgetModel>(model: T, frame: CGRect)-> V {
        return V.init()
    }
    
    open func magicDidAppear() {
        
    }
    
    //计算初始化尺寸
    private func getFirstContentSize() -> CGRect {
        var frame = CGRect.init();
        frame.origin.x = LengthUtil.instance.length2px(length: currentModel.padding.left)
        frame.origin.y = LengthUtil.instance.length2px(length: currentModel.padding.right)
        
        var width: CGFloat = 0;
        var height: CGFloat = 0
        
        switch currentModel.width {
        case ModelConstants.WRAP_CONTENT:
            width = 1
            break
        case ModelConstants.MATCH_PARENT:
            width = _contentMaxWidth
            break
        default:
            width = LengthUtil.instance.length2px(length: currentModel.width)
        }
        
        switch currentModel.height {
        case ModelConstants.WRAP_CONTENT:
            height = 1
            break
        case ModelConstants.MATCH_PARENT:
            height = _contentMaxHeight
            break
        default:
            height = LengthUtil.instance.length2px(length: currentModel.height)
        }
        
        let size = getContextSize(width: width, height: height)
        frame.size.width = size.0
        frame.size.height = size.1
        
        return frame
    }
    
    private func getContentMaxWidth() -> CGFloat {
        //父控件宽度自适应
        guard _superMaxWidth >= 0 else {
            return ModelConstants.WRAP_CONTENT
        }
            
        let maxWidth =  _superMaxWidth - LengthUtil.instance.length2px(length: currentModel.margin.left + currentModel.margin.right + currentModel.padding.left + currentModel.padding.right)
        
        return maxWidth > 0 ? maxWidth : 0
    }
    
    private func getContentMaxHeight() -> CGFloat {
        
        //父控件高度自适应
        guard _superMaxHeight >= 0 else {
            return ModelConstants.WRAP_CONTENT
        }
        
        let maxHeight = _superMaxHeight - LengthUtil.instance.length2px(length: currentModel.margin.top + currentModel.margin.bottom + currentModel.padding.top + currentModel.padding.bottom)
        
        return maxHeight > 0 ? maxHeight : 0
    }
    
    private func layoutBaseInfo() {
        self.layer.borderColor = UIColor.init(hex: currentModel.borderColor).cgColor
        self.layer.borderWidth = LengthUtil.instance.length2px(length: currentModel.border)
        self.backgroundColor = UIColor.init(hex: currentModel.bgColor)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = LengthUtil.instance.length2px(length: currentModel.corner)
        resizeMagicView()
    }
    
    @objc func tapAction(tap: UITapGestureRecognizer) {
        guard nil != currentModel.action else {
            //运行本地delegate
            currentModel.actionDelegate?.magicViewDidClick(view: self, controller: self.firstViewController())
            return
        } 
        
        //运行js脚本
        if let vc = self.firstViewController() {
            JSCoreManager.instance.evaluateScript(vc: vc, script: currentModel.action!)
        }
        
    }
    
    /**
     * 重设父容器大小
     */
    private func resizeMagicView() {

        frame.origin.x = LengthUtil.instance.length2px(length: currentModel.margin.left + currentModel.x)
        
        frame.origin.y = LengthUtil.instance.length2px(length: currentModel.margin.top + currentModel.y)
        
        frame.size.width = (containerView?.frame.size.width ?? 0) 
            + LengthUtil.instance.length2px(length: 
                currentModel.padding.left + currentModel.padding.right)
        
        frame.size.height = (containerView?.frame.size.height ?? 0) 
            + LengthUtil.instance.length2px(length: currentModel.padding.top + currentModel.padding.bottom)
        
        //判断相等则跳出
//        guard frame != self.frame else {
//            return
//        }
        
        self.frame = frame
        
        print("\(self.classForCoder) w->\(frame.size.width), iMagicH->\(frame.size.height)")
        
        //调用sizeCallBack 通知上层更新尺寸
        delegate?.magicSizeDidChange(
            view: self,
            width: frame.size.width + LengthUtil.instance.length2px(length: currentModel.margin.left + currentModel.margin.right),
            height: frame.size.height + LengthUtil.instance.length2px(length: currentModel.margin.left + currentModel.margin.right))
    }
    
    /**
     根据子布局宽高 重新设置父布局
     传入内容视图初始宽高，
     定时器处理
     */
    private var _resizeTimer: Timer?
    @objc func needResizeContentSize(width: CGFloat, height: CGFloat) {
        print("\(self.classForCoder) needResize w-> \(width) h->\(height)")
        _resizeTimer?.invalidate()
        let userInfo = (width, height)
        _resizeTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction(timer:)), userInfo: userInfo, repeats: false)
    }
    
    @objc private func timerAction(timer: Timer) {
        let userInfo:(CGFloat, CGFloat)? = timer.userInfo as? (CGFloat, CGFloat)
        guard nil != userInfo else {
            return
        }
        resizeContentSize(width: userInfo!.0, height: userInfo!.1)
    }
    
    private func resizeContentSize(width: CGFloat, height: CGFloat) {
        
        guard nil != containerView else {
            return
        }
        
        //子控件宽高不为零
        guard width != 0 && height != 0 else {
            return
        }
        
        //判断是否可调整宽高
        guard currentModel.width == ModelConstants.WRAP_CONTENT || currentModel.height == ModelConstants.WRAP_CONTENT else {
            return
        }
        
        var frame = containerView!.frame
        let size = getContextSize(width: width, height: height)
        
        //判断是否需要刷新
        guard frame.size.width != size.0 || frame.size.height != size.1 else {
            return
        }
        
        frame.size.width = size.0
        frame.size.height = size.1
        containerView!.frame = frame
        resizeMagicView()
    }
    
    func getContextSize(width: CGFloat, height: CGFloat) -> (CGFloat, CGFloat) {
        if (currentModel.width == ModelConstants.WRAP_CONTENT && currentModel.height == ModelConstants.WRAP_CONTENT ) {
            //宽高均自适应
            return getSizeForWrapWidthAndHeight(width: width, height: height);
        }else if(currentModel.width == ModelConstants.WRAP_CONTENT) {
            //宽度自适应
            return getSizeForwrapWidth(width: width, height: height);
        }else if(currentModel.height == ModelConstants.WRAP_CONTENT) {
            //高度自适应
            return getSizeForwrapHeight(width: width, height: height);
        } else {
            //非自适应
            return (_contentMaxWidth, _contentMaxHeight)
        }
    }
    
    //当宽高都是wrapContext 计算出调整后宽高
    func getSizeForWrapWidthAndHeight(width: CGFloat, height: CGFloat) -> (CGFloat, CGFloat) {
        
        let w_multiple:CGFloat = _contentMaxWidth >= 0 ? (_contentMaxWidth/width) : 1
        let h_multiple:CGFloat = _contentMaxHeight >= 0 ? (_contentMaxHeight/height) : 1
        
        //是否需要压缩
        let multiple = (w_multiple > h_multiple ? h_multiple : w_multiple)
        
        return multiple < 1 ? (width * multiple, height * multiple) : (width, height)
    }
    
    //当只有宽是wrapContext
    func getSizeForwrapWidth(width: CGFloat, height: CGFloat) -> (CGFloat, CGFloat) {
        let multiple = _contentMaxHeight / height
        let nW = multiple < 1 ? width * multiple : width
        
        return ((_contentMaxWidth>=0 && nW>_contentMaxWidth) ? _contentMaxWidth : nW,
                _contentMaxHeight)
    }
    
    //当只高是wrapContext
    func getSizeForwrapHeight(width: CGFloat, height: CGFloat) -> (CGFloat, CGFloat) {
        
        let multiple = _contentMaxWidth / width
        let nH = multiple < 1 ? height * multiple : height
        
        return (_contentMaxWidth,
                (_contentMaxHeight>=0 && nH>_contentMaxHeight) ? _contentMaxHeight : nH)
    }
    
    deinit {
        print("\(self.classForCoder) deinit")
    }
}
