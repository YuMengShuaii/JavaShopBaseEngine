//
//  NetExtension.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/28.
//  Copyright © 2017年 LDD. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import HandyJSON


extension ObservableType where E == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return map({ rs -> T in
            return rs.mapModel(T.self)
        })
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response  {
    
    public func mapInstance<T: HandyJSON>(_ type: T.Type) -> Single<T> {
        return flatMap { response -> Single<T> in
            return Single.just(response.mapModel(T.self))
        }
    }
}

extension Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> T {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: jsonString)!
    }
}

