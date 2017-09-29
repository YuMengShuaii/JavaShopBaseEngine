//
//  BaseViewModel.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/6.
//  Copyright © 2017年 LDD. All rights reserved.
//


import RxSwift
/**
 *  ViewModel基础接口
 */
open class BaseViewModel<T : BasePageView> :NSObject{
    
    var pView :T!
    
    func attachView(view:T) {
        pView = view
    }
    
    open func bindData(){}
    
    open func bindEvent(){}
 
    open func bindNatification(){}
    
    func back(){
        pView?.getViewController()?.navigationController?.popViewController(animated: true)
    }
}
