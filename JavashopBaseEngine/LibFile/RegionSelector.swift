//
//  RagionSelector.swift
//  JavashopBaseEngine
//
//  Created by LDD on 2017/10/7.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxDataSources

/// 地区选择器
public class RegionSelector<T :RegionIInter>: UIView,RegionSelectorIInter {
    public func setEngine(data: [T]) {
    
    }
    
    public typealias DataType = T
    
   
    //======================视图========================
    
    private var backgroundView :UIView!
    
    private var titleLable : UILabel!
    
    private var topBar :UIView!
    
    private var titleScrollView :UIScrollView!
    
    private var regionView :EasyCollectionView<T>!
    
    private var backButton :UIButton!
    
    private var commitButton :UIButton!
    
    //======================参数============================
    
    /// 返回值
    private var result = RegionResult<T>()
    
    /// 结果回调
    private var resultMethod : JavaShopVoidMethod1<RegionResult<T>>!
    
    /// 更新地区信息代码块
    private var dataSource :JavaShopVoidMethod1<[T]>!
    
    /// 地区更新回调
    private var dataEngine :JavaShopVoidMethod2<T?,JavaShopVoidMethod1<[T]>>!
    
    /// 初始化
    ///
    /// - Parameter frame: 视图布局信息
    override private init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
        layout()
        config()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// 构建地区选择器 静态初始化
    ///
    /// - Returns: 地区选择器
    public static func build() ->RegionSelector{
        return RegionSelector.init(frame: UIScreen.main.bounds)
    }
    
    /// 初始化UI控件
    private func createUI(){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        backgroundView = UIView().then({ (view) in
            view.backgroundColor = UIColor.white
            view.setRaduis(rSize: GET_SCREEN_WIDTH(2))
        })
        titleLable = UILabel().then({ (view) in
            view.setFontSize(size: 15)
            view.setText(text: "未选择")
            view.setTextAlignment(alignment: .center)
            view.setTextColor(color: UIColor.white)
        })
        
        titleScrollView = UIScrollView().then({ (view) in
            view.showsVerticalScrollIndicator = false
            view.showsHorizontalScrollIndicator = false
        })
        
        topBar = UIView().then({ (view) in
            view.setBackGroundColor(color:UIColor.red)
        })
        
        backButton = UIButton().then({ (view) in
            view.setImage(UIImage.init(named: "ImageResource.bundle/region_back"), for: UIControlState.normal)
        })
        
        commitButton = UIButton().then({ (view) in
            view.setImage(UIImage.init(named: "ImageResource.bundle/region_commit"), for: UIControlState.normal)
        })
        
        let regionLay = UICollectionViewFlowLayout.init().then { (layout) in
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
            layout.itemSize = CGSize.init(width: GET_SCREEN_WIDTH(80), height: GET_SCREEN_HEIGHT(5))
        }
        
        regionView = EasyCollectionView.init(frame: CGRect.init(), collectionViewLayout: regionLay).then({ (view) in
            view.setBackGroundColor(color: .white)
            view.register(cellType: RegionCell.self)
        })

        topBar.addSubview(backButton)
        topBar.addSubview(commitButton)
        titleScrollView.addSubview(titleLable)
        topBar.addSubview(titleScrollView)
        backgroundView.addSubview(topBar)
        backgroundView.addSubview(regionView)
        addSubview(backgroundView)
    }
    
    /// 布局
    private func layout(){
        backgroundView.snp.makeConstraints { (make) in
            make.width.equalTo(GET_SCREEN_WIDTH(80))
            make.height.equalTo(GET_SCREEN_HEIGHT(80))
            make.center.equalToSuperview()
        }
        topBar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(backgroundView)
            make.width.equalTo(GET_SCREEN_WIDTH(80))
            make.height.equalTo(GET_SCREEN_HEIGHT(8))
        }
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(topBar).offset(GET_SCREEN_WIDTH(2))
            make.width.height.equalTo(GET_SCREEN_WIDTH(8))
            make.centerY.equalTo(topBar)
        }
        
        commitButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(GET_SCREEN_WIDTH(8))
            make.centerY.equalTo(topBar)
            make.right.equalTo(topBar).offset(-GET_SCREEN_WIDTH(2))
        }
        
        titleScrollView.snp.makeConstraints { (make) in
            make.height.equalTo(GET_SCREEN_WIDTH(8))
            make.width.equalTo(GET_SCREEN_WIDTH(60))
            make.left.equalTo(backButton.snp.right)
            make.right.equalTo(commitButton.snp.left)
            make.centerY.equalTo(topBar)
        }
        
        titleLable.snp.makeConstraints { (make) in
            make.left.height.top.bottom.centerY.equalToSuperview()
        }
        
        regionView.snp.makeConstraints { (make) in
            make.top.equalTo(topBar.snp.bottom)
            make.bottom.equalTo(backgroundView.snp.bottom)
            make.right.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(GET_SCREEN_HEIGHT(72))
        }
    }
    
    /// 配置相关参数及信息
    private func config(){
        titleLable.frame.size.width = GET_SCREEN_WIDTH(60)
        regionView.createCell { (dataSource, cv, ip, data) -> (UICollectionViewCell) in
            let cell :RegionCell = cv.dequeueReusableCell(for: ip)
            cell.Render(data: data)
            return cell
        }
        regionView.setOnItemClickListener {[weak self] (data) in
            self?.result.setData(data: data)
            self?.updataTitle()
            self?.updateData(region: data)
        }
        backButton.addTarget(self, action: #selector(onBack), for: UIControlEvents.touchUpInside)
        commitButton.addTarget(self, action: #selector(onCommit), for: UIControlEvents.touchUpInside)
        setDataSource {[weak self] (data) in
            if data.count > 0 {
                self?.setData(datas: data)
            }
        }
    }
    
    
    /// 设置地区更新操作
    ///
    /// - Parameter method: 地区更新代码块
    private func setDataSource(method :@escaping JavaShopVoidMethod1<[T]>){
        self.dataSource = method
    }
    
    /// 返回操作
    @objc private func onBack(){
        if regionView.getData()[0].items.count > 0 {
            if regionView.getData()[0].items[0].getLevel() == RegionLevel.FIRST{
                remove()
                return
            }
            let currentRegion = regionView.getData()[0].items[0]
            updateData(region: (result.getParent(data: currentRegion)))
            result.clean(currentRegion.getLevel())
            updataTitle()
        }else{
            remove()
        }
    }
    
    /// 提交操作
    @objc private func onCommit(){
        resultMethod(result)
        remove()
    }
    
    /// 更新标题（已选地区信息）
    private func updataTitle(){
        let attributes = [NSAttributedStringKey.font: titleLable.font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = result.toString().boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: GET_SCREEN_WIDTH(60)), options: option, attributes:attributes as Any as? [NSAttributedStringKey : Any], context: nil)
        titleLable.frame.size.width = rect.size.width
        titleScrollView.contentSize.width = rect.size.width
        titleLable.setText(text: result.toString())
        if rect.size.width > titleScrollView.frame.size.width{
            Log.info(rect)
            titleScrollView.setContentOffset(CGPoint.init(x: 150, y: 0), animated: true)
        }
    }
    
    /// 设置地区列表数据
    ///
    /// - Parameter datas: 数据
    private func setData(datas :[T]?){
        if datas==nil {
            resultMethod(result)
            remove()
        }
        regionView.clearData()
        regionView.addData(datas: datas!)
    }
    
    /// 获取下级地区数据
    ///
    /// - Parameter region: 当前层级地区数据
    private func updateData(region :T?){
        dataEngine(region,dataSource)
    }
    
    /// 显示地区选择器
    ///
    /// - Parameter vc: 调用UIController
    public func show(vc :UIViewController) {
        updateData(region: nil)
        vc.view.addSubview(self)
    }
    
    
    /// 设置数据引擎
    ///
    /// - Parameter engine: 数据引擎
    /// - Returns: 地区选择器
    public func setDataEngine(engine :@escaping JavaShopVoidMethod2<T?,JavaShopVoidMethod1<[T]>>) ->RegionSelector{
       self.dataEngine = engine
       return self
    }
    
    /// 移除地区选择器
    public func remove(){
        removeFromSuperview()
    }
    
    /// 设置地区选择完毕的回调代码块
    ///
    /// - Parameter listener: 回调代码块
    /// - Returns: 地区选择器
    public func setResultListener(listener :@escaping JavaShopVoidMethod1<RegionResult<T>>) ->RegionSelector{
        self.resultMethod = listener
        return self
    }
    
    public func setTopBarBackgroundColor(color :UIColor) -> RegionSelector{
        topBar.setBackGroundColor(color: color)
        return self
    }
    
    public func setTopBarBackgroundColor(colorHex :String) ->RegionSelector{
        topBar.setBackGroundColor(colorHex: colorHex)
        return self
    }
    
    public func setTitleFontColor(color :UIColor) ->RegionSelector{
        titleLable.setTextColor(color: color)
        return self
    }
    
    public func setTitleFontColor(colorHex :String) ->RegionSelector{
        titleLable.setTextColor(colorHex: colorHex)
        return self
    }
    
    public func setTitleFontSize(size :CGFloat) -> RegionSelector{
        titleLable.setFontSize(size: size)
        return self
    }
    
    public func setBackButtonImage(name :String) ->RegionSelector{
        backButton.setImage(UIImage.init(named: name), for: UIControlState.normal)
        return self
    }
    
    public func setBackButtonImage(url :String) ->RegionSelector{
        backButton.kf.setImage(with: URL.init(string: url), for: UIControlState.normal)
        return self
    }
    
    public func setCommitButtonImage(name :String) ->RegionSelector{
        commitButton.setImage(UIImage.init(named: name), for: UIControlState.normal)
        return self
    }
    
    public func setCommitButtonImage(url :String) ->RegionSelector{
        commitButton.kf.setImage(with: URL.init(string: url), for: UIControlState.normal)
        return self
    }
    
    public func setRegionViewBackgroundColor(color :UIColor) ->RegionSelector{
        regionView.setBackGroundColor(color: color)
        return self
    }
    
    public func setRegionViewBackgroundColor(colorHex :String) ->RegionSelector{
        regionView.setBackGroundColor(colorHex: colorHex)
        return self
    }
    
    public func setBackgroundColor(colorHex :String) ->RegionSelector{
        backgroundView.setBackGroundColor(colorHex: colorHex)
        return self
    }
    
    public func setBackgroundColor(color :UIColor) ->RegionSelector{
        backgroundView.setBackGroundColor(color: color)
        return self
    }
    
    public func setBackgoundRadius(rSize :CGFloat) ->RegionSelector{
        backgroundView.setRaduis(rSize: rSize)
        return self
    }
    
    public func setMask(color :UIColor) ->RegionSelector{
        setBackGroundColor(color: color)
        return self
    }
    
    public func setMask(colorHex :String) ->RegionSelector{
        setBackGroundColor(colorHex: colorHex)
        return self
    }
    
    public func setRegionItemBackgroundColor(color :UIColor) ->RegionSelector{
        RegionCell.lableBackgroundColor = color
        return self
    }
    
    public func setRegionItemBackgroundColor(colorHex :String) ->RegionSelector{
        RegionCell.lableBackgroundColor = UIColor.withHex(hexString: colorHex)
        return self
    }
    
    public func setRegionItemTextColor(color :UIColor) ->RegionSelector{
        RegionCell.lableFontColor = color
        return self
    }
    
    public func setRegionItemTextColor(colorHex :String) ->RegionSelector{
        RegionCell.lableFontColor = UIColor.withHex(hexString: colorHex)
        return self
    }
    
    public func setRegionItemFontSize(fSize :CGFloat) ->RegionSelector{
        RegionCell.lableFontSize = fSize
        return self
    }
    
}

//======================================================================================================================================
//                                        -----------------其他----------------
//======================================================================================================================================

public protocol RegionSelectorIInter {
    associatedtype DataType
    
    func setEngine(data :[DataType])
    
}


/// 地区列表 Item视图
public class RegionCell :UICollectionViewCell,Reusable{
    
    private var lable :UILabel!
    public static var lableBackgroundColor = UIColor.white
    public static var lableFontColor = UIColor.black
    public static var lableFontSize:CGFloat = 15
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
        layout()
    }
    
    private func createUI(){
        lable = UILabel().then({ (view) in
            view.setBackGroundColor(color: RegionCell.lableBackgroundColor)
            view.setTextColor(color: RegionCell.lableFontColor)
            view.setFontSize(size: RegionCell.lableFontSize)
            view.setTextAlignment(alignment: .center)
        })
        addSubview(lable)
    }

    private func layout(){
        lable.snp.makeConstraints { (make) in
            make.left.right.top.bottom.size.equalToSuperview()
        }
    }
    
    public func Render(data :RegionIInter){
        lable.setText(text: data.getName())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


/// 返回结果封装
public class RegionResult<T : RegionIInter>{
    private var first :T!  = nil
    private var second :T! = nil
    private var third :T!  = nil
    private var fourth :T! = nil
    
    public init(first :T,second:T,third:T,fourth:T) {
        self.first = first
        self.second = second
        self.third = third
        self.fourth = fourth
    }
    
    public init() {
        
    }
    
    public func getParent(data :T) ->T?{
        if data.getLevel()==RegionLevel.FOURTH {
            return second
        }else if data.getLevel()==RegionLevel.THIRD {
            return first
        }else {
            return nil
        }
    }
    
    public func setData(data : T){
        switch data.getLevel() {
        case RegionLevel.FIRST:
            first = data
            second = nil
            third = nil
            fourth = nil
            break
        case RegionLevel.SECOND:
            second = data
            third = nil
            fourth = nil
            break
        case RegionLevel.THIRD:
            third = data
            fourth = nil
            break
        case RegionLevel.FOURTH:
            fourth = data
            break
        case RegionLevel.ERROR:
            Log.error("地区等级错误！")
            break
        }
    }
    
    public func clean(_ level :RegionLevel){
        switch level {
        case RegionLevel.FIRST:
            first = nil
            second = nil
            third = nil
            fourth = nil
            break
        case RegionLevel.SECOND:
            second = nil
            third = nil
            fourth = nil
            break
        case RegionLevel.THIRD:
            third = nil
            fourth = nil
            break
        case RegionLevel.FOURTH:
            fourth = nil
            break
        case RegionLevel.ERROR:
            Log.error("地区等级错误！")
            break
        }
    }
    
    public func getFirst() ->T{
        return first
    }
    
    public func getSecond() ->T{
        return second
    }
    
    public func getThird() ->T{
        return third
    }
    
    public func getFourth() ->T{
        return fourth
    }
    
    public func toString() ->String{
        let str = "\(first == nil ? "" :first.getName()) \(second == nil ? "" :second.getName()) \(third == nil ? "" :third.getName()) \(fourth == nil ? "" :fourth.getName())"
        return str
    }
    
}


/// 地区Model必须实现该协议
public protocol RegionIInter{
    func getLevel() -> RegionLevel
    
    func getName() -> String
    
    func getId() -> Int
}


/// 地区等级枚举
///
/// - FIRST: 一级
/// - SECOND: 二级
/// - THIRD: 三级
/// - FOURTH: 四级
/// - ERROR: 等级错误
public enum RegionLevel{
    case  FIRST
    case  SECOND
    case  THIRD
    case  FOURTH
    case  ERROR
}
