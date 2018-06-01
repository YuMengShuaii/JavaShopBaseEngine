//
//  BaseParentView.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/7.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
open class BaseParentView:UIView{

    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.reSize()
        self.createUI()
    }
    
    private func reSize(){
       self.frame.size = CGSize.init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    open func createUI(){}
    
    final public func getViewController()->UIViewController?{
        var parentViewController :UIViewController?
        var nextRes :UIResponder? = self.superview?.next
        repeat{
            if ((nextRes?.isKind(of: UIViewController.self))! && !(nextRes?.isKind(of: UINavigationController.self))!) {
                parentViewController =  (nextRes as! UIViewController)
            }
            nextRes = nextRes?.next
        }while nextRes != nil
        
        return parentViewController
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
