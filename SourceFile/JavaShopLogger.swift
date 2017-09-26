
//
//  JavaShopLogger.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/26.
//  Copyright © 2017年 LDD. All rights reserved.
//

import Foundation

class JavaShopLogger {
    public static func build() -> JavaShopLogger{
        return JavaShopLogger()
    }
    
    func e(_ message :String){
        NSLog(message)
    }
}
