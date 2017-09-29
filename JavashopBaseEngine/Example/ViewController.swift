//
//  ViewController.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/5.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import Kingfisher
import SnapKit
import Then
import RealmSwift
import NSObject_Rx

class ViewController: UIViewController,UITextViewDelegate {
    private let provider = RxMoyaProvider<ApiManager>()
    private let dispose = DisposeBag()
    let  count = Variable("")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let text = UITextView(frame:CGRect(x:10, y:100, width:200, height:100))
        text.text = "测试"
        text.delegate = self
        let image = UIButton(frame:CGRect(x:10, y:100, width:200, height:100))
        self.view.addSubview(text)
        self.view.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        image.kf.setImage(with: URL.init(string: "https://avatars1.githubusercontent.com/u/1019875?v=4&s=40"), for: UIControlState.normal)
        image.addTarget(self, action:#selector(click), for: UIControlEvents.touchUpInside)
        provider.request(.Login(name: "yumengshuai", pass: "111111"))
        .filterSuccessfulStatusCodes()
        .mapString()
        .subscribe(onSuccess: { (rs) in
            Log.info(rs)
        }) { (e) in
            Log.error(e.localizedDescription)
        }.addDisposableTo(dispose)
        
        
        count.asDriver()
        .drive(onNext: { (v) in
            text.text = text.text+"\(v)"
        }, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
        
        NotificationUtils.register(who: self, name: "test", selector: #selector(notifa(notifa:)))
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        print("输入中")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidDisappear(_ animated: Bool) {
        Log.info("视图消失")
    }
    
    @objc func notifa(notifa:Notification){
        let info = notifa.userInfo  as! [String: AnyObject]
        let value1 = info["v1"] as! String
        let value2 = info["v2"] as! Int
        count.value = value1
        Log.info("收到通知\(value1)  \(value2)")
    }
    @objc func click() {
//        provider.request(.isLogin())
//            .filterSuccessfulStatusCodes()
//            .mapString()
//            .subscribe(onSuccess: { (rs) in
//                 self.count.value+="\(rs)"
//            }) { (e) in
//               self.log.error(e.localizedDescription)
//        }.addDisposableTo(dispose)
        navigationController?.pushViewController(FirstPageController(), animated: true)
    }
}

