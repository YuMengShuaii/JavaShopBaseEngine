//
//  AppMacro.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/8.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import SwiftyBeaver
import RxCocoa
import RxSwift

/// 屏幕宽度
public let SCREEN_WIDTH   = UIScreen.main.bounds.width

/// 屏幕高度
public let SCREEN_HEIGHT  = UIScreen.main.bounds.height

/// 状态栏高度
public let STATUS_HEIGHT =  UIApplication.shared.statusBarFrame.height
/// 根据百分比获取屏幕宽度 例如： GET_SCREEN_WIDTH（20）获取20%的屏幕宽度
///
/// - Parameter percentage: 百分比 0-100
/// - Returns: 所需要的宽度
public func GET_SCREEN_WIDTH(_ percentage:CGFloat) -> CGFloat{
    return UIScreen.main.bounds.width*(percentage/100)
}

/// 根据百分比获取屏幕高度 例如： GET_SCREEN_HEIGHT（20）获取20%的屏幕高度
///
/// - Parameter percentage: 百分比 0-100
/// - Returns: 所需要的高度
public func GET_SCREEN_HEIGHT(_ percentage:CGFloat) -> CGFloat{
    return UIScreen.main.bounds.height*(percentage/100)
}

public func AS_OBSERVABLE<T>(type:T)->Variable<T>{
    return Variable(type)
}

/// 全局日志工具
public let Log = SwiftyBeaver.self

public let HOLDER_IMAGE = "ImageResource.bundle/holder"

public let ERROR_IMAGE  = "ImageResource.bundle/error"

public let IMAGE_CACHE_MAX : UInt = 1024*1024*300
