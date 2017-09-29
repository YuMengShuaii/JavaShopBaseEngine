//
//  PagerControllerViewController.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/18.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import SnapKit
class PagerControllerViewController: UIViewController,EasyTabViewDelegate,ViewPagerHelperDelegate {
    var pager :ViewPagerHelper!
    var tabber :EasyTabView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        pager = ViewPagerHelper.build(pageControllers: [TableControllerViewController(),TableControllerViewController(),TableControllerViewController()])
        pager.setDelagate(delegate: self)
        self.view.addSubview(pager.view)
        tabber = EasyTabView.init(sectionTitles:["商品","详情","评论"])
        tabber.setDelegate(delegate: self)
        tabber.config()
        self.view.addSubview(tabber)
        tabber.snp.makeConstraints { (make) in
            make.top.equalTo(STATUS_HEIGHT)
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(40)
        }
        pager.view.snp.makeConstraints {[weak self] (view) in
            view.bottom.left.right.equalTo((self?.view)!)
            view.top.equalTo(tabber.snp.bottom)
        }
    }
    
    func pageIndexListener(index: UInt) {
        tabber.setSelectedSegmentIndex(index, animated: true)
    }
    
    func tabItemClick(index: Int) {
        pager.showPageAtIndex(index, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }

    deinit {
        Log.info("ViewPagerController销毁")
    }
}
