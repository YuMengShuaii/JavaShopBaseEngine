//

import UIKit
import Foundation
public enum ShowType {
    case success
    case error
    case info
}

public extension SJProgressHUD {
    
    /**
     加载动画图片
     
     - parameter images:       图片数组
     - parameter timeInterval: 动画每次执行时间
     */
    public static func showWaitingWithImages(_ images : Array<UIImage>, timeInterval : TimeInterval = 0) {
        SJProgressHUD.showWaitWithImages(images, timeInterval: timeInterval)
    }
    /**
     显示菊花
     
     - parameter text:       需要显示的文字,如果不设置文字,则只显示菊花
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showWaiting(_ text: String = "", autoRemove: Bool = false) {
        SJProgressHUD.showWaitingWithText(text, autoRemove: autoRemove)
    }
    /**
     状态栏显示
     
     - parameter text:       需要显示的文字
     - parameter color:      背景颜色
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showStatusBarWithText(_ text: String = "OK", color: UIColor = UIColor(red: 131 / 255.0, green: 178 / 255.0, blue: 158 / 255.0, alpha: 1), autoRemove: Bool = true) {
        SJProgressHUD.showStatusBar(text, color: color, autoRemove: autoRemove)
    }
    /**
     只显示文字
     
     - parameter text:       需要显示的文字
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showOnlyText(_ text: String, autoRemove: Bool = true) {
        SJProgressHUD.onlyText(text, autoRemove: autoRemove)
    }
    /**
     Success样式
     
     - parameter successText: 需要显示的文字,默认为 Success!
     - parameter autoRemove:  是否自动移除,默认3秒后自动移除
     */
    public static func showSuccess(_ successText: String = "Success!", autoRemove: Bool = true) {
        SJProgressHUD.showText(.success, text: successText, autoRemove: autoRemove)
    }
    /**
     Error样式
     
     - parameter errorText:  需要显示的文字,默认为 Error!
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showError(_ errorText: String = "Error!", autoRemove: Bool = true) {
        SJProgressHUD.showText(.error, text: errorText, autoRemove: autoRemove)
    }
    /**
     Info样式
     
     - parameter infoText:   需要显示的文字,默认为 Info!
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showInfo(_ infoText: String = "info!", autoRemove: Bool = true) {
        SJProgressHUD.showText(.info, text: infoText, autoRemove: autoRemove)
    }
    /**
     移除HUD,会移除所有
     */
    public static func dismiss() {
        SJProgressHUD.clear()
    }
}


private let circleSize = CGSize(width: 40, height: 40)
private let windowBgColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.002)
private func bgColor(_ alpha: CGFloat) -> UIColor {
    return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
}

open class SJProgressHUD : NSObject {
    
    static var windows = Array<UIWindow!>()
    static var angle: Double {
        return [0, 0, 180, 270, 90][UIApplication.shared.statusBarOrientation.hashValue] as Double
    }
    static open func showWaitWithImages(_ images : Array<UIImage>, timeInterval : TimeInterval) {
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let imageView = UIImageView()
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = bgColor(0.7)
        imageView.layer.cornerRadius = 10
        imageView.animationImages = images
        imageView.animationDuration = timeInterval == 0 ? TimeInterval(images.count) * 0.07 : timeInterval
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
        
        _ = SJProgressHUD.createWindow(frame, view: imageView)
        
    }
    
    static open func showJavaShopLoading(){
          let parent = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
          parent.backgroundColor = UIColor.clear
          let imageview = UIImageView()
          imageview.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width/15, height: UIScreen.main.bounds.width/15)
          imageview.image = UIImage.init(named: "ImageResource.bundle/js_load")
          imageview.center = getCenter()
          let lable = SJProgressHUD.createLable()
          lable.frame = CGRect.init(x: 0, y: 0,width:UIScreen.main.bounds.width/25, height: UIScreen.main.bounds.width/25)
          lable.center = getCenter()
          lable.text="JS"
          lable.textColor = UIColor.withHex(hexString: "ffcccccc")
          parent.addSubview(imageview)
          parent.addSubview(lable)
          _ = SJProgressHUD.createWindow(parent.frame, view: parent)
          let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z") // 让其在z轴旋转
          rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0) // 旋转角度
          rotationAnimation.duration = 0.6 // 旋转周期
          rotationAnimation.isCumulative = true // 旋转累加角度
          rotationAnimation.repeatCount = 100000 // 旋转次数
          imageview.layer.add(rotationAnimation, forKey: "rotationAnimation")
          
    }
    
    static open func showWaitingWithText(_ text: String, autoRemove: Bool) {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = bgColor(0.7)
        view.layer.cornerRadius = 10
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
        if !text.isEmpty {
            activity.frame = CGRect(x: 35, y: 25, width: 30, height: 30)
            
            let lable = SJProgressHUD.createLable()
            lable.frame = CGRect(x: 0, y: 55, width: 100, height: 45)
            lable.text = text
            view.addSubview(lable)
        }
        activity.frame = CGRect(x: 30, y: 30, width: 40, height: 40)
        activity.startAnimating()
        view.center = getCenter()
        view.addSubview(activity)
        let parent = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        parent.backgroundColor = UIColor.clear
        parent.addSubview(view)
        let window = SJProgressHUD.createWindow(parent.frame, view: parent)
        
        if autoRemove {
            let sel = #selector(removeHUD(_:))
            perform(sel, with: window, afterDelay: 3)
        }
        
    }
    static open func showStatusBar(_ text: String, color: UIColor, autoRemove: Bool) {
        
        let frame = UIApplication.shared.statusBarFrame
        
        let lable = SJProgressHUD.createLable()
        lable.text = text
        
        let window = SJProgressHUD.createWindow(frame, view: lable)
        window.backgroundColor = color
        window.windowLevel = UIWindowLevelStatusBar
        lable.frame = frame
        window.center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        lable.center = window.center
        
        if autoRemove {
            let sel = #selector(removeHUD(_:))
            perform(sel, with: window, afterDelay: 3)
        }
    }
    static open func onlyText(_ text: String, autoRemove: Bool) {
        
        let view = UIView()
        view.backgroundColor = bgColor(0.7)
        view.layer.cornerRadius = 10
        
        
        let label = SJProgressHUD.createLable()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12)
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        view.addSubview(label)
        
        let frame = CGRect(x: 0, y: 0, width: 210, height: 110)
        view.frame = frame
        label.center = view.center
        
        let window = SJProgressHUD.createWindow(frame, view: view)
        
        if autoRemove {
            let sel = #selector(removeHUD(_:))
            perform(sel, with: window, afterDelay: 3)
        }
    }
    static open func showText(_ type: ShowType, text: String, autoRemove: Bool) {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        let view = UIView(frame: frame)
        view.layer.cornerRadius = 10
        view.backgroundColor = bgColor(0.7)
        
        var image = UIImage()
        switch type {
        case .success:
            image = drawImage.imageOfSuccess
        case .error:
            image = drawImage.imageOfError
        case .info:
            image = drawImage.imageOfInfo
        }
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(origin: CGPoint(x: 30, y: 25), size: circleSize)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        let lable = SJProgressHUD.createLable()
        lable.frame = CGRect(x: 0, y: 70, width: 100, height: 30)
        lable.text = text
        view.addSubview(lable)
        
        let window = SJProgressHUD.createWindow(frame, view: view)
        
        if autoRemove {
            let sel = #selector(removeHUD(_:))
            perform(sel, with: window, afterDelay: 3)
        }
        
    }
    
    static fileprivate func createLable() -> UILabel {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 10)
        lable.backgroundColor = UIColor.clear
        lable.textColor = UIColor.white
        lable.numberOfLines = 0
        lable.textAlignment = .center
        return lable
    }
    static fileprivate func createWindow(_ frame: CGRect, view: UIView) -> UIWindow {
        
        let window = UIWindow(frame: frame)
        window.backgroundColor = windowBgColor
        window.windowLevel = UIWindowLevelAlert
        window.transform = CGAffineTransform(rotationAngle: CGFloat(angle * M_PI / 180))
        window.isHidden = false
        window.center = getCenter()
        window.addSubview(view)
        windows.append(window)
        return window
    }
    @objc static open func removeHUD(_ object: AnyObject) {
        if let window = object as? UIWindow {
            if let index = windows.index(where: { (item) -> Bool in
                return item == window
            }) {
                windows.remove(at: index)
            }
        }
    }
    static open func clear() {
        if windows.isEmpty { return }
        self.cancelPreviousPerformRequests(withTarget: self)
        windows.removeAll(keepingCapacity: false)
    }
    static func getCenter() -> CGPoint {
        let view = UIApplication.shared.keyWindow?.subviews.first as UIView!
        if UIApplication.shared.statusBarOrientation.hashValue >= 3 {
            return CGPoint(x: view!.center.y, y: view!.center.x)
        } else {
            return view!.center
        }
    }
}


class drawImage  {
    
    struct imageCache {
        static var imageOfSuccess: UIImage?
        static var imageOfError: UIImage?
        static var imageOfInfo: UIImage?
    }
    
    class func draw(_ type : ShowType) {
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 40, y: 20))
        path.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 19, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        path.close()
        
        switch type {
        case .success:
            path.move(to: CGPoint(x: 15, y: 20))
            path.addLine(to: CGPoint(x: 20, y: 25))
            path.addLine(to: CGPoint(x: 30, y: 15))
            path.move(to: CGPoint(x: 15, y: 20))
            path.close()
        case .error:
            path.move(to: CGPoint(x: 10, y: 10))
            path.addLine(to: CGPoint(x: 30, y: 30))
            path.move(to: CGPoint(x: 10, y: 30))
            path.addLine(to: CGPoint(x: 30, y: 10))
            path.move(to: CGPoint(x: 10, y: 10))
            path.close()
        case .info:
            path.move(to: CGPoint(x: 20, y: 8))
            path.addLine(to: CGPoint(x: 20, y: 28))
            path.move(to: CGPoint(x: 20, y: 8))
            path.close()
            
            let tmpPath = UIBezierPath()
            tmpPath.move(to: CGPoint(x: 20, y: 30))
            tmpPath.addArc(withCenter: CGPoint(x: 20, y: 30), radius: 1, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
            tmpPath.close()
            UIColor.white.setFill()
            tmpPath.fill()
        }
        UIColor.white.setStroke()
        path.stroke()
    }
    
    class var imageOfSuccess: UIImage {
        if imageCache.imageOfSuccess != nil {
            return imageCache.imageOfSuccess!
        }
        UIGraphicsBeginImageContextWithOptions(circleSize, false, 0)
        drawImage.draw(.success)
        imageCache.imageOfSuccess = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageCache.imageOfSuccess!
    }
    class var imageOfError: UIImage {
        if imageCache.imageOfError != nil {
            return imageCache.imageOfError!
        }
        UIGraphicsBeginImageContextWithOptions(circleSize, false, 0)
        drawImage.draw(.error)
        imageCache.imageOfError = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageCache.imageOfError!
    }
    class var imageOfInfo: UIImage {
        if imageCache.imageOfInfo != nil {
            return imageCache.imageOfInfo!
        }
        UIGraphicsBeginImageContextWithOptions(circleSize, false, 0)
        drawImage.draw(.info)
        imageCache.imageOfInfo = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageCache.imageOfInfo!
    }
}
