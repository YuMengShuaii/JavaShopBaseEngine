//
//  CommonUtils.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/6.
//  Copyright © 2017年 LDD. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher
import NSObject_Rx

public class CommonUtils{
    
    public static func autoClearImageCache(dis :DisposeBag){
        Observable<UInt>.create { (obser) -> Disposable in
            KingfisherManager.shared.cache.calculateDiskCacheSize(completion: { (size) in
                obser.onNext(size)
            })
            return Disposables.create()
         }
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInteractive))
        .observeOn(ConcurrentDispatchQueueScheduler(qos : .userInteractive))
        .filter { (size) -> Bool in
            return size > IMAGE_CACHE_MAX
        }.subscribe { (size) in
            KingfisherManager.shared.cache.clearDiskCache()
        }.addDisposableTo(dis)
    }
    
}

