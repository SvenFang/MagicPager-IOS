//
//  ViewController.swift
//  demo
//
//  Created by Sven on 02/08/2019.
//  Copyright © 2019 Sven. All rights reserved.
//

import UIKit
import magicpager
import SDWebImage
import SDWebImageWebPCoder

class ViewController: UIViewController {
    
    @IBOutlet weak var image:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Webp支持
        SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
        SDWebImageDownloader.shared.setValue("image/webp,image/*,*/*;q=0.8", forHTTPHeaderField:"Accept")
        
        MagicPagerManager.instance.setLogger(logger: Test.instance)
        MagicPagerManager.instance.addPagerProvider(provider: TestPagerProvider.instance)
        
        
        let url = URL.init(string: "https://s10.mogucdn.com/mlcdn/c45406/190702_5gc489a8e9ihjc75id9855ih7e7aa_150x150.jpg_640x640.v1cAC.40.webp")
        image.sd_setImage(with: url)
    }

    @IBAction func testWidget(_ sender: Any) {
//    self.navigationController?.pushViewController(MagicViewController.createMagic(requestData:
//    PagerRequestData.init(type: "test", key: "testDemo")), animated: true)
    self.navigationController?.pushViewController(MagicViewController.createMagic(requestData:
        PagerRequestData.init(type: "test", key: "test")), animated: true)
    }
    
    @IBAction func testAd(_ sender: Any) {
        self.navigationController?.pushViewController(MagicViewController.createMagic(requestData: PagerRequestData.init(type: "test", key: "testAd")), animated: true)
    }
    
    @IBAction func testDynamic(_ sender: Any) {
        self.navigationController?.pushViewController(TestOCViewController.init(), animated: true)
    }
}

