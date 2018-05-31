//
//  TableViewPage.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/12.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import Reusable
class TableViewPage: BasePageView {
    
    var tableView : EasyTableView<AndroidRes>!
    var magicHeaderView : MagicHeaderLayout!
    var tabBarView :UIView!
    var bannerView :UIView!
    var menuTab :UIView!
    override func createUI() {
        tabBarView = UIView().then({ (view) in
          view.frame.size = CGSize.init(width: SCREEN_WIDTH, height: 60)
          view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        })
        
        bannerView = UIView().then({ (view) in
          view.frame.size = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_WIDTH)
          view.backgroundColor = UIColor.black
        })
        
        menuTab = UIView().then({ (view) in
          view.frame.size = CGSize.init(width: SCREEN_WIDTH, height: 60)
          view.backgroundColor = UIColor.blue
        })
        
        magicHeaderView = MagicHeaderLayout.init(topBarHeight: 60, contentHeight: SCREEN_WIDTH, anthorHeight: 60, isFull: false).then({ (layout) in
            layout.backgroundColor = UIColor.white
            layout.TopBar().backgroundColor = UIColor.red.withAlphaComponent(0.2)
            layout.Content().backgroundColor = UIColor.black
            layout.AnthorView()?.backgroundColor = UIColor.blue
            layout.contentScrollOpenEnable()
            layout.contentScrollCloseEnable()
        })
        
        addSubview(magicHeaderView)
        
        var tableFrame = UIScreen.main.bounds
        tableFrame.origin.y = magicHeaderView.frame.size.height
        tableFrame.size.height -= (magicHeaderView.minHeight() + STATUS_HEIGHT + 40)
        tableView = EasyTableView<AndroidRes>.init(frame:tableFrame, style: .plain).then({ (view) in
        view.register(cellType: TableViewCell.self)
        view.separatorStyle = UITableViewCellSeparatorStyle.none})
        addSubview(tableView)
        magicHeaderView.bindView(view: tableView)
    }
    
}
