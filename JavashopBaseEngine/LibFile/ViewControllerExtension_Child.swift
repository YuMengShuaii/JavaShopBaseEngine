//
//  UIViewController+ChildController.swift
//  PreciousMetals
//
//  Created by GaoYu on 16/5/29.
//  Copyright © 2016年 Dev-GY. All rights reserved.
//

import UIKit

extension UIViewController {
    func easy_addChildViewController(_ viewController:UIViewController) {
        self.easy_addChildViewController(viewController,frame: self.view.bounds)
    }
    
    func easy_addChildViewController(_ viewController:UIViewController,inView:UIView,withFrame:CGRect) {
        self.easy_addChildViewController(viewController) { (superViewController,childViewController) in
            childViewController.view.frame = withFrame;
            
            if inView.subviews.contains(viewController.view) == false {
                inView.addSubview(viewController.view)
            }
        }
    }
    
    func easy_addChildViewController(_ viewController:UIViewController,frame:CGRect) {
        self.easy_addChildViewController(viewController) { (superViewController,childViewController) in
            childViewController.view.frame = frame;
            
            if superViewController.view.subviews.contains(viewController.view) == false {
                superViewController.view.addSubview(viewController.view)
            }
        }
    }
    
    func easy_addChildViewController(_ viewController:UIViewController,
                                   setSubViewAction:((_ superViewController:UIViewController,_ childViewController:UIViewController) -> Void)?) {
        
        let containsVC = self.childViewControllers.contains(viewController)
        
        if containsVC == false {
            self.addChildViewController(viewController)
        }
        
        setSubViewAction?(self,viewController)
        
        if containsVC == false {
            viewController.didMove(toParentViewController: self)
        }
    }
    
    func easy_removeFromParentViewControllerOnly() {
        self.willMove(toParentViewController: nil)
        self.removeFromParentViewController()
    }
    
    func easy_removeFromParentViewController() {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}

