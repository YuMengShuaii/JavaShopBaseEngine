//
//  FirstPageViewModel.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/6.
//  Copyright © 2017年 LDD. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Moya

class FirstPageViewModel :BaseViewModel<FirstPage>{
    private let gankApi = RxMoyaProvider<GankApi>()
    let vhp = ViewPagerHelper.build(pageControllers: [TableControllerViewController(),TableControllerViewController(),TableControllerViewController()])
    public func getAndroid()-> Single<AndroidModle>{
        return  gankApi.request(.Girl("1"))
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
                .observeOn(MainScheduler.instance)
                .filterSuccessfulStatusCodes()
                .mapInstance(AndroidModle.self)
    }
    
    public func getIos() -> Single<AndroidModle>{
        return gankApi.request(.IOS())
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .observeOn(MainScheduler.instance)
            .filterSuccessfulStatusCodes()
            .mapInstance(AndroidModle.self)
    }
    
    override func bindData() {
        SJProgressHUD.showJavaShopLoading()
        getAndroid().subscribe(onSuccess: { (data) in
            self.pView?.allView().value = data
            SJProgressHUD.dismiss()
        }, onError: { (error) in
            SJProgressHUD.dismiss()
            Log.info(error.localizedDescription)
        }).addDisposableTo(disposeBag)
    }
    
    override func bindEvent() {
        self.pView?.button?.addTarget(self, action: #selector(postNotifa), for: UIControlEvents.touchUpInside)
    }
    
    @objc func postNotifa(){
//        NotificationUtils.post(name: "test", who: self, data: ["v1":"我草我草", "v2" : 110])
//        back()
        
        pView?.getViewController()?.navigationController?.pushViewController(TableControllerViewController(), animated: true)
    }
    
}
