//
//  BaseView.swift
//  JavashopBaseEngine
//
//  Created by LDD on 2017/9/29.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit

open class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
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
