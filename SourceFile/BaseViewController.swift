//
//  BaseViewController.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/7.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit

public class BaseViewController :UIViewController{
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        prepare()
        bindVVM()
    }
    
    
    public func bindView(_ view:UIView){
        
        self.view.addSubview(view)
    }
    
    /**
     * 初始化操作
     */
    public func prepare(){}
    
    /**
     * 绑定数据
     */
    public func bindVVM(){}
    
    /**
     * 返回上一层页面
     */
    public func back(){
        self.navigationController?.popViewController(animated: true)
    }

}
