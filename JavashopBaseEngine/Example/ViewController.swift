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
    var remainingSeconds = Variable(113)
    var timer :Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.white
//        let text = UITextView(frame:CGRect(x:10, y:100, width:200, height:100))
//        text.text = "测试"
//        text.delegate = self
        let image = UIImageView(frame:CGRect(x:10, y:100, width:SCREEN_WIDTH, height:SCREEN_HEIGHT))
        //self.view.addSubview(text)
        self.view.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        let lableView = UILabel.init(text: "3", textColorStr: "#ffffff", textSize: 12).then { (lable) in
            lable.backgroundColor = UIColor.clear
            lable.frame = CGRect.init(x:2, y:0, width: 30, height: 20)
            lable.setTextAlignment(alignment: NSTextAlignment.center)
        }
        
        let view = UIView.init(frame: CGRect.init(x: SCREEN_WIDTH-80, y: 35, width: 70, height: 20)).then { (view) in
            view.backgroundColor = UIColor.withHex(hexString: "000000", alpha: 0.5)
            view.setRaduis(rSize: 10)
        }
        view.addSubview(lableView)
        
        let button = UIButton.init(frame: CGRect.init(x: 30, y: 0, width: 40, height: 20)).then { (button) in
            button.backgroundColor = UIColor.clear
            button.setNomalTitle(title: "跳过")
            button.setFontSize(size: 12)
            button.setNomalTitleColor(hexColor: "#ffffff")
            button.addTarget(self, action: #selector(click), for: UIControlEvents.touchUpInside)
        }
        view.addSubview(button)
        self.view.addSubview(view)
        if SCREEN_HEIGHT == 736 {
            image.image = UIImage.init(named: "iPhone8P.png")
        }else if SCREEN_HEIGHT == 667 {
            image.image = UIImage.init(named: "iPhone8.png")
        }else if SCREEN_HEIGHT == 568 {
            image.image = UIImage.init(named: "iPhoneSE.png")
        }else if SCREEN_HEIGHT == 812 {
             image.image = UIImage.init(named: "iPhoneX.png")
        }
        
        image.setImage(url: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1515415617875&di=346cb3fbc6b971ee84aef3de8b189a64&imgtype=0&src=http%3A%2F%2Fimage.tianjimedia.com%2FuploadImages%2F2015%2F131%2F42%2F1Q177R2I7739.jpg")
        remainingSeconds.asDriver().drive(onNext: { (value) in
            lableView.setText(text: "\(value)")
        }, onCompleted:nil, onDisposed: nil).addDisposableTo(dispose)
        
        startClicked()
        
//        image.kf.setImage(with: URL.init(string: "https://avatars1.githubusercontent.com/u/1019875?v=4&s=40"), for: UIControlState.normal)
//        image.addTarget(self, action:#selector(click), for: UIControlEvents.touchUpInside)
//        provider.request(.Login(name: "yumengshuai", pass: "111111"))
//        .filterSuccessfulStatusCodes()
//        .mapString()
//        .subscribe(onSuccess: { (rs) in
//            Log.info(rs)
//        }) { (e) in
//            Log.error(e.localizedDescription)
//        }.addDisposableTo(dispose)
        
//
//        count.asDriver()
//        .drive(onNext: { (v) in
//            text.text = text.text+"\(v)"
//        }, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
//        NotificationUtils.register(who: self, name: "test", selector: #selector(notifa(notifa:)))
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        print("输入中")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidDisappear(_ animated: Bool) {
       
    }
    
    deinit {
         Log.info("视图消失")
    }
    
    @objc func notifa(notifa:Notification){
        let info = notifa.userInfo  as! [String: AnyObject]
        let value1 = info["v1"] as! String
        let value2 = info["v2"] as! Int
        count.value = value1
        Log.info("收到通知\(value1)  \(value2)")
    }
    
    func startClicked() {
        //获取该计时器的剩余时间
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(tickDown), userInfo: nil, repeats: true)
    }
    
    func tickDown() {
        //将剩余时间减少1秒
        remainingSeconds.value -= 1
        //如果剩余时间小于等于0
        if remainingSeconds.value <= 0 {
            //取消定时器
            timer.invalidate()
           
                let vc = PagerControllerViewController();
                UIApplication.shared.keyWindow?.rootViewController =
                UINavigationController.init(rootViewController: vc)
                self.navigationController?.popViewController(animated: false)
                //self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @objc func click() {
        //取消定时器
        timer.invalidate()
        let vc = PagerControllerViewController();
        UIApplication.shared.keyWindow?.rootViewController =
            UINavigationController.init(rootViewController: vc)
        self.navigationController?.popViewController(animated: false)
//        provider.request(.isLogin())
//            .filterSuccessfulStatusCodes()
//            .mapString()
//            .subscribe(onSuccess: { (rs) in
//                 self.count.value+="\(rs)"
//            }) { (e) in
//               self.log.error(e.localizedDescription)
//        }.addDisposableTo(dispose)
//        navigationController?.pushViewController(PagerControllerViewController(), animated: true)
//      let regionApi = RxMoyaProvider<RegionApi>()
//        regionApi.request(.get(parentId: 0))
//            .subscribeOn(ConcurrentDispatchQueueScheduler(qos :.userInteractive))
//            .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInteractive))
//            .mapString()
//            .subscribe(onSuccess: { (data) in
//                Log.info(data)
//            }) { (error) in
//                Log.error(error)
//        }.addDisposableTo(disposeBag)
//        RegionSelector<RegionListBean>.build()
//            .setDataEngine {[weak self] (data, dataSource) in
//                regionApi.request(.get(parentId:  data == nil ? 0 :(data?.getId())!))
//                    .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
//                    .observeOn(MainScheduler.instance)
//                    .filterSuccessfulStatusCodes()
//                    .mapInstance(RegionData.self)
//                    .subscribe(onSuccess: { (datas) in
//                        dataSource(datas.data!)
//                    }, onError: { (error) in
//                        Log.error(error)
//                    }).addDisposableTo((self?.disposeBag)!)
//            }.setResultListener { (result) in
//                Log.info(result.toString())
//            }.show(vc: self)
//        MagicDialog.build()
//                   .setPassListener {
//                    Log.info("取消")
//                   }.setAgreeListener {
//                    Log.info("确定")
//                   }.show(vc: self)
        
    }
    
}
