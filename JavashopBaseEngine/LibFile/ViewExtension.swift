//
//  ViewExtension.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/19.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView{
    
    public func setImage(url :String){
        self.kf.setImage(with: URL.init(string: url))
    }
    
    public func setImageWithAnthor(url :String,placeImageName :String? = HOLDER_IMAGE,imageTransition :KingfisherOptionsInfo? = [.transition(ImageTransition.fade(1))] , downListener : ((Int) -> ())? = nil){
        self.kf.setImage(with: URL.init(string: url), placeholder: UIImage.init(named: placeImageName!), options: imageTransition, progressBlock: { (downSize, totalSize) in
            if(downListener != nil){
                downListener!(Int(Float(downSize)/Float(totalSize)*100))
            }
        }, completionHandler: { image, error, cacheType, imageURL in
            if error != nil {
                self.image = UIImage.init(named: ERROR_IMAGE)
            }
        })
    }
}

extension UIButton {
    
    public func setFontSize(size :CGFloat){
        titleLabel?.font = UIFont.systemFont(ofSize: size)
    }
    
    public func setImage(url :String,state :UIControlState){
        self.kf.setImage(with: URL.init(string: url),for: state)
    }
    
    public func setImage(name :String, state :UIControlState){
        self.setImage(UIImage.init(named: name), for: state)
    }
    
    public func setTouchDownBackGround(name :String){
        setImage(name: name, state: UIControlState.highlighted)
    }
    
    public func setTouchDownBackGround(url :String){
        setImage(url: url, state: UIControlState.highlighted)
    }
    
    public func setNomalBackGround(name :String){
        setImage(name: name, state: UIControlState.normal)
    }
    
    public func setNomalBackGround(url :String){
        setImage(url: url, state: UIControlState.normal)
    }
    
    public func setSelectBackGround(name :String){
        setImage(name: name, state: UIControlState.selected)
    }
    
    public func setSelectBackGround(url :String){
        setImage(url: url, state: UIControlState.selected)
    }
    
    public func setNomalTitle(title :String){
        self.setTitle(title, for: UIControlState.normal)
    }
    
    public func setNomalTitleColor(hexColor :String){
        self.setTitleColor(UIColor.withHex(hexString: hexColor), for: UIControlState.normal)
    }
    
    public func setNomalTitleColor(color :UIColor){
        self.setTitleColor(color, for: UIControlState.normal)
    }
    
    public func setTouchDownTitle(title :String){
        self.setTitle(title, for: UIControlState.highlighted)
    }
    
    public func setTouchDownTitleColor(color :UIColor){
        self.setTitleColor(color, for: UIControlState.highlighted)
    }
    
    public func setTouchDownTitleColor(hexColor :String){
         self.setTitleColor(UIColor.withHex(hexString: hexColor), for: UIControlState.highlighted)
    }
    
    public func setSelectTitle(title :String){
        self.setTitle(title, for: UIControlState.selected)
    }
    
    public func setSelectTitleColor(color :UIColor){
        self.setTitleColor(color, for: UIControlState.selected)
    }
    
    public func setSelectTitleColor(hexColor :String){
        self.setTitleColor(UIColor.withHex(hexString: hexColor), for: UIControlState.selected)
    }
}

extension UILabel {
    
    public func setText(text : String){
        self.text = text
    }
    
    convenience public init(text :String , textColor : UIColor, textSize :CGFloat) {
        self.init()
        setText(text: text, textColor: textColor, textSize: textSize)
    }
    
    convenience public init(text :String , textColorStr : String, textSize :CGFloat) {
        self.init()
        setText(text: text, textColorStr: textColorStr, textSize: textSize)
    }
    
    convenience public init(text :String , textSize :CGFloat) {
        self.init()
        self.text = text
        self.font = UIFont.systemFont(ofSize: textSize)
    }
    
    convenience public init(text :String) {
        self.init()
        self.text = text
    }
    
    public func setFontSize(size :CGFloat){
        font = UIFont.systemFont(ofSize: size)
    }
    
    public func setText(text :String , textColor : UIColor, textSize :CGFloat){
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: textSize)
    }
    
    public func setText(text :String , textColorStr : String, textSize :CGFloat){
        self.text = text
        self.textColor = UIColor.withHex(hexString: textColorStr)
        self.font = UIFont.systemFont(ofSize: textSize)
    }
    
    public func setTextAlignment(alignment : NSTextAlignment){
        textAlignment = alignment
    }
    
}

extension UITextField{
    public func setText(text : String){
        self.text = text
    }
    
    public func  setRound(){
        borderStyle = UITextBorderStyle.roundedRect
    }
    
    public func setPlaceholder(placeholder :String){
        self.placeholder = placeholder
    }
    
    public func setFontSize(size :CGFloat){
        font = UIFont.systemFont(ofSize: size)
    }
    
    public func setBackImage(imageName :String){
        borderStyle = .none //先要去除边框样式
        background = UIImage(named : imageName);
    }
    
    public func showClearBtn(){
        clearButtonMode = .unlessEditing
    }
    
    public func setReturnKeyType(type :UIReturnKeyType){
        self.returnKeyType = type
    }
    
    public func autoFontSzie(fontMinSize :CGFloat){
        adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        minimumFontSize = fontMinSize    //最小可缩小的字号
    }
    
    public func setTextAlignment(alignment : NSTextAlignment){
        textAlignment = alignment
    }
    
    public func setContentVerticalAlignment(alignment : UIControlContentVerticalAlignment){
        contentVerticalAlignment = alignment
    }

}

extension UITextView{
    public func setText(text : String){
        self.text = text
    }
    
    convenience public init(text :String , textColor : UIColor, textSize :CGFloat) {
        self.init()
        setText(text: text, textColor: textColor, textSize: textSize)
    }
    
    convenience public init(text :String , textColorStr : String, textSize :CGFloat) {
        self.init()
        setText(text: text, textColorStr: textColorStr, textSize: textSize)
    }
    
    public func openScroll(){
        isScrollEnabled = true
    }
    
    public func setText(text :String , textColor : UIColor, textSize :CGFloat){
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: textSize)
    }
    
    public func setText(text :String , textColorStr : String, textSize :CGFloat){
        self.text = text
        self.textColor = UIColor.withHex(hexString: textColorStr)
        self.font = UIFont.systemFont(ofSize: textSize)
    }
    
    public func setFontSize(size :CGFloat){
        font = UIFont.systemFont(ofSize: size)
    }
}

extension UIView{
    
    public func setTag(tag :Int){
        self.tag = tag
    }
    
    /// 设置背景色
    ///
    /// - Parameter color: UIColor
    public func setBackGroundColor(color : UIColor){
        backgroundColor = color
    }
    
    /// 设置背景色
    ///
    /// - Parameter colorHex: 颜色Hex字符串
    public func setBackGroundColor(colorHex : String){
        backgroundColor = UIColor.withHex(hexString: colorHex)
    }
    
    
    /// 设置点击事件
    ///
    /// - Parameters:
    ///   - target: 事件所在对象
    ///   - action: 事件Selector
    public func setOnClickListener(target: Any?, action: Selector?){
        isUserInteractionEnabled = true
        let clickEvent = UITapGestureRecognizer.init(target: target, action: action)
        clickEvent.numberOfTapsRequired = 1
        addGestureRecognizer(clickEvent)
    }
    
    
    /// 添加长按事件
    ///
    /// - Parameters:
    ///   - target: 事件所在对象
    ///   - action: 事件Selector
    public func setOnLongClickListener(target: Any?, action: Selector?){
         isUserInteractionEnabled = true
         let longClickEvent = UILongPressGestureRecognizer.init(target: target, action: action)
         longClickEvent.minimumPressDuration = 1.5
         longClickEvent.numberOfTapsRequired = 1
         addGestureRecognizer(longClickEvent)
    }
    
    
    /// 设置全部圆角
    ///
    /// - Parameter rSize: 圆角大小
    public func setRaduis(rSize:CGFloat){
        layer.cornerRadius = rSize
        layer.masksToBounds = true;
    }
    
    
    /// 设置部分圆角
    ///
    /// - Parameters:
    ///   - rSize: 圆角大小
    ///   - corners: 需要设置圆角的部位
    public func setRadius(rSize:CGFloat,corners : UIRectCorner){
        
        /// 运用贝塞尔曲线 绘制圆角
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: rSize, height: rSize))
        
        /// 使用CaShapeLayer将渲染提交到GPU
        
        let maskLayer = CAShapeLayer.init()
        
            ///设置frame 使用view本身的frame
            maskLayer.frame = bounds
        
            ///将第一步绘制的path设置到layer
            maskLayer.path = maskPath.cgPath
        
            ///设置到layer 绘制
            layer.mask = maskLayer;
    }

}
