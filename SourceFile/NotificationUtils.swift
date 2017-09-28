//
//  NotificationUtils.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/7.
//  Copyright © 2017年 LDD. All rights reserved.
//

import Foundation

public class NotificationUtils{
    
    public static func  register(who:Any,name : String,selector : Selector,object:AnyObject? = nil){
        NotificationCenter.default.addObserver(who, selector:selector, name: NSNotification.Name(rawValue: name), object: object)
    }

    public static func post(name:String,who:Any,data:[AnyHashable : Any]? = nil){
        NotificationCenter.default.post(name:  Notification.Name(rawValue:name), object:who,userInfo: data)
    }
    
    public static func remove(who : Any){
        NotificationCenter.default.removeObserver(who)
    }
    
    public static func remove(who: Any,aName: NSNotification.Name?, anObject: Any? = nil){
        NotificationCenter.default.removeObserver(who, name: aName, object: anObject)
    }
}
