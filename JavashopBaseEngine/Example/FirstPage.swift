//
//  FirstPage.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/6.
//  Copyright © 2017年 LDD. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift
import RxOptional
import RxDataSources
import Kingfisher
import NSObject_Rx
class FirstPage :BasePageView{
    let viewObser :Variable<AndroidModle> = Variable(AndroidModle())
    var button:UIButton? = nil

    override func createUI(){
        backgroundColor = UIColor.white
        let textView   = UITextView().then { (view) in
            view.backgroundColor = UIColor.white
        }
        let imageView  = UIImageView().then { (view) in
            view.setRaduis(rSize: 10)
        }
        button = UIButton().then { (view) in
            view.setTitle("测试退出", for: UIControlState.normal)
            view.setTitleColor(UIColor.red, for: UIControlState.normal)
        }
        addSubview(button!)
        addSubview(imageView)
        addSubview(textView)
        imageView.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(self)
            make.height.width.equalTo(300)
        }
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom)
            make.height.width.equalTo(150)
        }
        button?.snp.makeConstraints { (make) in
            make.height.width.equalTo(100)
            make.top.equalTo(textView.snp.bottom)
            make.centerX.equalTo(self)
        }
    
        viewObser.asDriver()
            .filter({ (data) -> Bool in
                return data.results.count>1
            })
        .drive(onNext: { (data) in
            Log.info("UI\(Thread.current)")
            textView.text = data.results[3].images?[0]
            imageView.kf.setImage(with: URL.init(string: (data.results[2].url)))
        }, onCompleted: nil, onDisposed: nil)
        .addDisposableTo(disposeBag)
        
    }
    
    public func allView() -> Variable<AndroidModle>{
        return viewObser
    }
}
