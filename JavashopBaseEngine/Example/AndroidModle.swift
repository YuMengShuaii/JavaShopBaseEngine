//
//  AndroidModle.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/7.
//  Copyright © 2017年 LDD. All rights reserved.
//

import Foundation
import HandyJSON
import RxDataSources

struct AndroidModle: HandyJSON{
    var error :Bool = true
    var results:[AndroidRes]=[AndroidRes]()
}

struct AndroidRes:HandyJSON {
    var _id:String = ""
    var createdAt:String = ""
    var desc:String = ""
    var images : [String]?
    var publishedAt:String = ""
    var source:String = ""
    var type:String = ""
    var url:String = ""
    var used:Bool = false
    var who:String = ""
}


