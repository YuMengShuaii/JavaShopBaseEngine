//
//  ListViewPage.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/8.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import Kingfisher
import Reusable

class ListViewPage:BasePageView{
    var collectionView : EasyCollectionView<AndroidRes>!
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
        
        magicHeaderView = MagicHeaderLayout.init(topBarHeight: 60, contentHeight: 300, anthorHeight: 60, isFull: false).then({ (layout) in
            layout.backgroundColor = UIColor.white
            layout.TopBar().backgroundColor = UIColor.red.withAlphaComponent(0.2)
            layout.Content().backgroundColor = UIColor.black
            layout.AnthorView()?.backgroundColor = UIColor.blue
            layout.contentScrollOpenEnable()
            layout.contentScrollCloseEnable()
        })
        
        addSubview(magicHeaderView)
        
        let listLay = UICollectionViewFlowLayout.init().then { (layout) in
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
            layout.itemSize = CGSize.init(width: SCREEN_WIDTH, height: 100)
        }
        var tableFrame = UIScreen.main.bounds
        tableFrame.origin.y = magicHeaderView.frame.size.height
        tableFrame.size.height -= magicHeaderView.minHeight()
        collectionView = EasyCollectionView.init(frame:tableFrame, collectionViewLayout: listLay).then { (view) in
            view.register(cellType: ListCell.self)
            view.backgroundColor = UIColor.white
        }
        addSubview(collectionView)
        magicHeaderView.bindView(view: collectionView)
    }
}
