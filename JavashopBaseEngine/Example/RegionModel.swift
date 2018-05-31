//
//  RegionModel.swift
//  JavashopBaseEngine
//
//  Created by LDD on 2017/10/11.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import HandyJSON

struct RegionData: HandyJSON {
    var result : Int? = 0
    var message:String? = ""
    var data :[RegionListBean]? = [RegionListBean]()
}

struct RegionListBean :HandyJSON , RegionIInter{
    
    var region_id :Int = 0
    var local_name:String = ""
    var region_grade:Int = 0
    var p_region_id:Int = 0
    var childnum:Int = 0
    var cod:String = ""
    var zipcode:String = ""
    
    func getLevel() -> RegionLevel {
        switch region_grade {
        case 1:
            return RegionLevel.FIRST
        case 2:
            return RegionLevel.SECOND
        case 3:
            return RegionLevel.THIRD
        case 4:
            return RegionLevel.FOURTH
        default:
            return RegionLevel.ERROR
        }
    }
    
    func getName() -> String {
        return local_name
    }
    
    func getId() -> Int {
        return region_id
    }
}
