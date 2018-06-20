//
//  PagerControllerViewController.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/18.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import SnapKit
class PagerControllerViewController: UIViewController,ViewPagerHelperDelegate {
    var pager :ViewPagerHelper!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.white
        pager = ViewPagerHelper.build(pageControllers: [ViewController(),ViewController(),ViewController()])
        pager.setDelagate(delegate: self)
        self.view.addSubview(pager.view)
        pager.view.snp.makeConstraints {[weak self] (view) in
            view.left.right.equalTo((self?.view)!)
            view.bottom.equalTo((self?.view)!).offset(STATUS_HEIGHT)
        }
    }
    
    func pageIndexListener(index: UInt) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }

    deinit {
        Log.info("ViewPagerController销毁")
    }
}
