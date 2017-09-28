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
public class BaseViewModel<T : BasePageView> :NSObject{
    
    var pView :T!
    
    func attachView(view:T) {
        pView = view
    }
    
    func bindData(){}
    
    func bindEvent(){}
 
    func bindNatification(){}
    
    func back(){
        pView?.getViewController()?.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        Log.info("ViewModel销毁")
    }
}
