//
//  ListViewController.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/9.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit

class ListViewController:BaseViewController{
    private let lisview = ListViewPage()
    private let vm = ListViewModel()
    override func prepare() {
         navigationController?.navigationBar.isHidden = true
         bindView(lisview)
    }
    
    override func bindVVM() {
         vm.attachView(view: lisview)
         vm.bindData()
    }
    
}
