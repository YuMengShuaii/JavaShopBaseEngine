//
//  AutoRefeshViewHelper.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/22.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import Then

public class AutoRefeshViewHelper {
    
    public static func insertLoadView(cv :UICollectionView , view : UIView? = nil){
        cv.viewWithTag(1212)?.removeFromSuperview()
        if view != nil{
            cv.addSubview((view?.with({ (view) in
                view.frame.origin.x = 0
                view.frame.origin.y = cv.contentSize.height
            }))!)
            return
        }
        cv.addSubview(createView(content: "正在加载...",view :cv))
    }
    
    public static func insertNoMore(cv :UICollectionView , view : UIView? = nil){
        cv.viewWithTag(1212)?.removeFromSuperview()
        if view != nil {
            cv.addSubview((view?.with({ (view) in
                view.frame.origin.x = 0
                view.frame.origin.y = cv.contentSize.height
            }))!)
            return
        }
        cv.addSubview(createView(content: "已经到底...",view :cv))
    }
    
    public static func insertNotFound(cv :UICollectionView , view :UIView? = nil){
        cv.viewWithTag(1212)?.removeFromSuperview()
        
        if view != nil {
            cv.addSubview((view?.with({ (view) in
                view.center = cv.center
            }))!)
            return
        }
        
        cv.addSubview(createView(content: "没有找到数据！",view :cv).with({  (text) in
            text.frame.origin.y = cv.frame.size.height/2
        }))
    }
    
    private static func createView(content :String,view :UICollectionView) ->UIView{
        let refreshView = UILabel.init(frame: CGRect.init(x: 0, y: view.contentSize.height, width: SCREEN_WIDTH, height: SCREEN_WIDTH/6))
        refreshView.setBackGroundColor(color: .white)
        refreshView.setTextAlignment(alignment: .center)
        refreshView.text = content
        refreshView.setFontSize(size: 12)
        refreshView.tag = 1212
        return refreshView
    }
    
    public static func remove(view :UICollectionView){
        view.viewWithTag(1212)?.removeFromSuperview()
    }
    
    
}
