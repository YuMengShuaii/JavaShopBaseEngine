//
//  MagicDialog.swift
//  JavashopBaseEngine
//
//  Created by LDD on 2017/9/29.
//  Copyright © 2017年 LDD. All rights reserved.
//

//
//  MagicDialog.swift
//  JavaShop
//
//  Created by LDD on 2017/9/29.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import SnapKit
import Then

public class MagicDialog :UIView , MagicDialogIInter {
    
    private var backgroundView :UIView!
    
    private var topbar : UILabel!
    
    private var lable :UILabel!
    
    private var agreeButton :UIButton!
    
    private var passButton :UIButton!
    
    private var agreeListener : JavaShopVoidMethod!
    
    private var passListener : JavaShopVoidMethod!
    
    private var line : UIView!
    
    private var passButtonMask :UIView!
    
    private var agreeButtonMask :UIView!
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
        layout()
    }
    
    private func createUI() {
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        backgroundView = UIView().then { (view) in
            view.setBackGroundColor(color: UIColor.white)
            view.setRaduis(rSize: GET_SCREEN_WIDTH(2))
        }
        topbar = UILabel().then { (lable) in
            lable.setBackGroundColor(color: UIColor.red)
            lable.setFontSize(size: 15)
            lable.setTextAlignment(alignment: .center)
            lable.setTextColor(color: UIColor.white)
            lable.setText(text: "提示")
        }
        lable = UILabel().then { (lable) in
            lable.setTextAlignment(alignment: .center)
            lable.setBackGroundColor(color: UIColor.white)
            lable.setFontSize(size: 15)
            lable.setText(text: "是否执行该操作！")
        }
        agreeButton = UIButton().then { (button) in
            button.setBackGroundColor(color: UIColor.red)
            button.setFontSize(size: 15)
            button.setNomalTitle(title: "确定")
            button.addTarget(self, action: #selector(agree), for: UIControlEvents.touchUpInside)
            button.addTarget(self, action: #selector(touchDown(sender:)), for: UIControlEvents.touchDragInside)
            button.addTarget(self, action: #selector(touchUpOutSide(sender:)), for: UIControlEvents.touchUpOutside)
            button.setTag(tag: 1)
        }
        passButton = UIButton().then { (button) in
            button.setBackGroundColor(color: UIColor.white)
            button.setFontSize(size: 15)
            button.setNomalTitleColor(color: UIColor.black)
            button.addTarget(self, action: #selector(pass), for: UIControlEvents.touchUpInside)
            button.addTarget(self, action: #selector(touchDown(sender:)), for: UIControlEvents.touchDragInside)
            button.addTarget(self, action: #selector(touchUpOutSide(sender:)), for: UIControlEvents.touchUpOutside)
            button.setNomalTitle(title: "取消")
            button.setTag(tag: 0)
        }
        line = UIView().then({ (view) in
            view.setBackGroundColor(color: UIColor.gray)
        })
        passButtonMask = UIView().then({ (view) in
            view.isUserInteractionEnabled = false
            view.setBackGroundColor(color: UIColor.black.withAlphaComponent(0.4))
            view.isHidden = true
        })
        agreeButtonMask = UIView().then({ (view) in
            view.isUserInteractionEnabled = false
            view.setBackGroundColor(color: UIColor.black.withAlphaComponent(0.4))
            view.isHidden = true
        })
    }
    
    private func layout(){
        self.addSubview(backgroundView)
        backgroundView.addSubview(topbar)
        backgroundView.addSubview(lable)
        backgroundView.addSubview(agreeButton)
        backgroundView.addSubview(passButton)
        backgroundView.addSubview(line)
        backgroundView.addSubview(passButtonMask)
        backgroundView.addSubview(agreeButtonMask)
        backgroundView.snp.makeConstraints {[weak self] (make) in
            make.center.equalTo((self?.snp.center)!)
            make.height.equalTo(GET_SCREEN_WIDTH(40))
            make.width.equalTo(GET_SCREEN_WIDTH(80))
        }
        topbar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(backgroundView)
            make.height.equalTo(GET_SCREEN_WIDTH(10))
            make.width.equalTo(GET_SCREEN_WIDTH(80))
        }
        lable.snp.makeConstraints { (make) in
            make.top.equalTo(topbar.snp.bottom)
            make.left.right.equalTo(backgroundView)
            make.height.equalTo(GET_SCREEN_WIDTH(20))
            make.width.equalTo(GET_SCREEN_WIDTH(80))
        }
        passButton.snp.makeConstraints { (make) in
            make.top.equalTo(lable.snp.bottom)
            make.left.equalTo(backgroundView)
            make.height.equalTo(GET_SCREEN_WIDTH(10))
            make.width.equalTo(GET_SCREEN_WIDTH(40))
        }
        passButtonMask.snp.makeConstraints { (make) in
            make.top.equalTo(lable.snp.bottom)
            make.left.equalTo(backgroundView)
            make.height.equalTo(GET_SCREEN_WIDTH(10))
            make.width.equalTo(GET_SCREEN_WIDTH(40))
        }
        agreeButton.snp.makeConstraints { (make) in
            make.top.equalTo(lable.snp.bottom)
            make.right.equalTo(backgroundView)
            make.height.equalTo(GET_SCREEN_WIDTH(10))
            make.width.equalTo(GET_SCREEN_WIDTH(40))
        }
        agreeButtonMask.snp.makeConstraints { (make) in
            make.top.equalTo(lable.snp.bottom)
            make.right.equalTo(backgroundView)
            make.height.equalTo(GET_SCREEN_WIDTH(10))
            make.width.equalTo(GET_SCREEN_WIDTH(40))
        }
        line.snp.makeConstraints { (make) in
            make.top.equalTo(passButton)
            make.width.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public static func build() ->MagicDialogIInter{
        return MagicDialog.init(frame: UIScreen.main.bounds)
    }
    
    public func setTitle(title :String) -> MagicDialogIInter{
        topbar.setText(text: title)
        return self
    }
    
    public func setTopBarBackgroundColor(color :UIColor) ->MagicDialogIInter{
        topbar.setBackGroundColor(color: color)
        return self
    }
    
    public func setTopBarBackgroundColor(colorHex :String) ->MagicDialogIInter{
        topbar.setBackGroundColor(colorHex: colorHex)
        return self
    }
    
    public func setTitleWithColorSize(text :String ,color :UIColor,textSize :CGFloat) ->MagicDialogIInter{
        topbar.setText(text: text, textColor: color, textSize: textSize)
        return self
    }
    
    public func setContentTextColor(text: String, textColor: UIColor, textSize: CGFloat) ->MagicDialogIInter{
        lable.setText(text: text, textColor: textColor, textSize: textSize)
        return self
    }
    
    public func setContentBackgroundColor(colorHex :String) ->MagicDialogIInter{
        lable.setBackGroundColor(colorHex: colorHex)
        return self
    }
    
    public func setContentBackgroundColor(color :UIColor) ->MagicDialogIInter{
        lable.setBackGroundColor(color: color)
        return self
    }
    
    public func setPassButtonBackgroundColor(color :UIColor) ->MagicDialogIInter{
        passButton.setBackGroundColor(color: color)
        return self
    }
    
    public func setPassButtonBackgroundColor(colorHex :String) ->MagicDialogIInter{
        passButton.setBackGroundColor(colorHex: colorHex)
        return self
    }
    
    public func setAgreeButtonBackgroundColor(color :UIColor) ->MagicDialogIInter{
        agreeButton.setBackGroundColor(color: color)
        return self
    }
    
    public func setAgreeButtonBackgroundColor(colorHex :String) ->MagicDialogIInter{
        agreeButton.setBackGroundColor(colorHex: colorHex)
        return self
    }
    
    public func setPassButtonTextColor(color :UIColor) ->MagicDialogIInter{
        passButton.setNomalTitleColor(color: color)
        return self
    }
    
    public func setPassButtonTextColor(colorHex :String) ->MagicDialogIInter{
        passButton.setNomalTitleColor(hexColor: colorHex)
        return self
    }
    
    public func setAgreeButtonTextColor(color :UIColor) ->MagicDialogIInter{
        agreeButton.setNomalTitleColor(color: color)
        return self
    }
    
    public func setAgreeButtonTextColor(colorHex :String) ->MagicDialogIInter{
        agreeButton.setNomalTitleColor(hexColor: colorHex)
        return self
    }
    
    public func setContentText(contentText :String) ->MagicDialogIInter{
        lable.setText(text: contentText)
        return self
    }
    
    public func setAgreeText(agreeText :String) -> MagicDialogIInter{
        agreeButton.setNomalTitle(title: agreeText)
        return self
    }
    
    public func setPassText(passText :String) ->MagicDialogIInter{
        passButton.setNomalTitle(title: passText)
        return self
    }
    
    public func setAgreeListener(agreeListener :@escaping ()->()) ->MagicDialogIInter{
        self.agreeListener = agreeListener
        return self
    }
    
    public func setPassListener(passListener :@escaping ()->()) ->MagicDialogIInter{
        self.passListener = passListener
        return self
    }
    
    public func show(vc :UIViewController){
        vc.view.addSubview(self)
    }
    
    public func remove(){
        self.removeFromSuperview()
    }
    
    @objc  func agree(){
        if (agreeListener != nil){
            agreeListener()
        }
        remove()
    }
    
    @objc  func pass(){
        if (passListener != nil){
            passListener()
        }
        remove()
    }
    
    @objc func touchDown(sender:UIButton){
        if sender.tag == 0 {
            passButtonMask.isHidden = false
        }else{
            agreeButtonMask.isHidden = false
        }
    }
    
    @objc func touchUpOutSide(sender:UIButton){
        if sender.tag == 0 {
            passButtonMask.isHidden = true
        }else{
            agreeButtonMask.isHidden = true
        }
    }
}

public protocol MagicDialogIInter {
    func setTitle(title :String) -> MagicDialogIInter
    func setContentText(contentText :String) ->MagicDialogIInter
    func setAgreeText(agreeText :String) -> MagicDialogIInter
    func setPassText(passText :String) ->MagicDialogIInter
    func setAgreeListener(agreeListener :@escaping ()->()) ->MagicDialogIInter
    func setPassListener(passListener :@escaping ()->()) ->MagicDialogIInter
    func setTopBarBackgroundColor(color :UIColor) ->MagicDialogIInter
    func setTopBarBackgroundColor(colorHex :String) ->MagicDialogIInter
    func setTitleWithColorSize(text :String ,color :UIColor,textSize :CGFloat) ->MagicDialogIInter
    func setContentTextColor(text: String, textColor: UIColor, textSize: CGFloat) ->MagicDialogIInter
    func setContentBackgroundColor(colorHex :String) ->MagicDialogIInter
    func setContentBackgroundColor(color :UIColor) ->MagicDialogIInter
    func setPassButtonBackgroundColor(color :UIColor) ->MagicDialogIInter
    func setPassButtonBackgroundColor(colorHex :String) ->MagicDialogIInter
    func setAgreeButtonBackgroundColor(color :UIColor) ->MagicDialogIInter
    func setAgreeButtonBackgroundColor(colorHex :String) ->MagicDialogIInter
    func setPassButtonTextColor(color :UIColor) ->MagicDialogIInter
    func setPassButtonTextColor(colorHex :String) ->MagicDialogIInter
    func setAgreeButtonTextColor(color :UIColor) ->MagicDialogIInter
    func setAgreeButtonTextColor(colorHex :String) ->MagicDialogIInter
    func show(vc :UIViewController)
    func remove()
}
