//
//  MagicContainerView.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit



@objc public class MagicContainerView: UIView ,MagicProviderCallBack{
    
    private var _requestData: PagerRequestData?
    
    private var _pagerModel: MagicPagerModel?
    
    private var _magicView: IMagic?
    
    //MARK: - create magic view
    @objc static public func createMagic(requestData: PagerRequestData) -> MagicContainerView {
        let magicContainer = MagicContainerView.init()
        magicContainer._requestData = requestData
        return magicContainer
    }
    
    @objc static public func createMagic(pagerModel: MagicPagerModel) -> MagicContainerView {
        let magicContainer = MagicContainerView.init()
        magicContainer._pagerModel = pagerModel
        return magicContainer
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        initSelf()
    }
    
    @objc public func initSelf() {
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(initTimerAction(timer:)), userInfo: nil, repeats: false)
    }
    
    @objc func initTimerAction(timer: Timer) {
        guard nil == _magicView else {
            return
        }
        initData()
    }
    
    private func initData() {
        
        guard nil == _pagerModel else {
            onSuccess(resp: _pagerModel!)
            return
        }
        
        guard nil != _requestData else {
            return
        }
        
        MagicPagerManager.instance.getMagic(type: _requestData!.type, key: _requestData!.key, params: _requestData!.param, callback: self)
    }
    
    private func refreshView() {
        guard nil != _pagerModel else {
            return
        }
        
        self.backgroundColor = UIColor.init(hex: _pagerModel!.bgColor)
        
        guard nil == _magicView else {
            _magicView!.updateWidget(model: _pagerModel!.widget)
            return
        }
        
        _magicView = MagicViewCreator.createView(
            model: _pagerModel!.widget, 
            maxWidth: self.frame.size.width, 
            maxHeight: self.frame.size.height, delegate: nil)
        
        guard nil != _magicView else {
            return
        }
        
        self.addSubview(_magicView!)
    }
    
    
    
    //MARK: - MagicProviderCallBack 
    public func onSuccess(resp: MagicPagerModel) {
        _pagerModel = resp
        refreshView()
    }
    
    public func onError(error: String) {
        
    }
    
    deinit {
        print("\(self.classForCoder) deinit")
    }
}
