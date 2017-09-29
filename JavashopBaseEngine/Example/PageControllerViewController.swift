//
//  PageControllerViewController.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/15.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit

class PageControllerViewController: UIPageViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    private var pages :[UIViewController]? = nil
    private var pageView : UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageView = UIPageViewController.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
        pageView.setViewControllers(getDataSource(), direction: UIPageViewControllerNavigationDirection.reverse, animated: true) { (flag) in
            Log.info(flag)
        }
        pages = getDataSource()
        pageView.delegate = self
        pageView.dataSource = self
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = self.pages?.index(of: viewController)
        
        if ((index == nil)||(index!+1 >= (self.pages?.count)!)) {
            return nil;
        }
        let a = index! + 1
        return self.pages?[a];
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 4
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.pages?.index(of: viewController)
        
        if ((index == nil) || (index == 0)) {
            return nil;
        }
        let a = index!-1
        
        return pages?[a]
    }
    
    private func getDataSource() -> [UIViewController]{
        return [TableControllerViewController(),TableControllerViewController(),TableControllerViewController(),TableControllerViewController()]
    }
}
