//
//  TableControllerViewController.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/12.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit

class TableControllerViewController: BaseViewController {

    let tableview = TableViewPage()
    let vm = TableViewModel()
    
    override func prepare() {
        navigationController?.navigationBar.isHidden = true
        bindView(tableview)
    }
    
    override func bindVVM() {
        vm.attachView(view: tableview)
        vm.bindData()
        vm.bindEvent()
    }

}
