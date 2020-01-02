//
//  MagicViewController.swift
//  magicpager
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit
import SnapKit

@objc open class MagicViewController: UIViewController {
    
    var containerView: MagicContainerView?
    var _requestData: PagerRequestData?
    var _pagerModel: MagicPagerModel?

    
    @objc static public func createMagic (requestData: PagerRequestData) -> MagicViewController {
        let magic = MagicViewController()
        magic._requestData = requestData
        return magic
    }
    
    @objc static public func createMagic (pagerModel: MagicPagerModel) -> MagicViewController {
        let magic = MagicViewController()
        magic._pagerModel = pagerModel
        return magic
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.layoutView()
    }
    
    private func layoutView() {
        
        guard nil != _requestData || nil != _pagerModel else {
            return
        }
        
        containerView = nil != _requestData ? 
            MagicContainerView.createMagic(requestData: _requestData!) :
            MagicContainerView.createMagic(pagerModel: _pagerModel!)
        
        self.view.addSubview(containerView!)
        containerView?.snp_makeConstraints({ (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
                make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            } else {
                make.top.bottom.left.right.equalTo(view)
            }
        })
        containerView?.layoutIfNeeded()
        containerView?.initSelf()
    }
    
    deinit {
        print("\(self.classForCoder) deinit")
    }
}
