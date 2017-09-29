//
//  EsayPagerView.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/12.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit

public class ViewPagerHelper :EasyPageViewController, EasyPageViewControllerDataSource,EasyPageViewControllerDelegate {
    
    @objc private var pageControllers:Array<UIViewController>!

    private var currentDelegate :ViewPagerHelperDelegate!
    
    public static func build(pageControllers:Array<UIViewController>) -> ViewPagerHelper{
        return ViewPagerHelper().with({ (vc) in
            vc.pageControllers = pageControllers
        })
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
    }
    
     func easy_pageViewController(_: EasyPageViewController, controllerAtIndex index: Int) -> UIViewController! {
        return self.pageControllers[index]
    }
    
     func easy_numberOfControllers(_: EasyPageViewController) -> Int {
        return self.pageControllers.count
    }
    
    public func setDelagate(delegate : ViewPagerHelperDelegate){
        self.currentDelegate = delegate
    }
    
    public func View() -> UIView {
        return self.view
    }
    
    override func easy_pageViewControllerDidTransitonFrom(_ fromIndex: Int, toIndex: Int) {
        currentDelegate.pageIndexListener(index: UInt.init(toIndex))
    }
    
    override func easy_pageViewControllerDidShow(_ fromIndex: Int, toIndex: Int, finished: Bool) {
        currentDelegate.pageIndexListener(index: UInt.init(toIndex))
    }
}
public protocol ViewPagerHelperDelegate {
    func pageIndexListener(index :UInt)
}

