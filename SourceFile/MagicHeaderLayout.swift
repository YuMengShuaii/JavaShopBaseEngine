//
//  MagicHeaderView.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/13.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit

public class MagicHeaderLayout: UIView  {
    private let topBar :     UIView
    private let contentView : MagicContentView
    private var anthorView : UIView?
    private var anthorHeight : CGFloat = 0
    private var scrollView :UIScrollView!
    private var oldScrollY :CGFloat = 0
    private var openScroll = false
    private var headerViewHeight :CGFloat = 0
    private var isFull :Bool = false
    
    /// 初始化操作
    ///
    /// - Parameters:
    ///   - tabBar: 标题栏视图
    ///   - contentView: 可伸缩Content视图
    ///   - anthorView: 其他视图
    ///   - isFull: contentView是否到顶部
    init(topBarHeight : CGFloat  ,contentHeight :CGFloat ,anthorHeight :CGFloat = 0, isFull: Bool = false) {
        self.isFull = isFull
        self.topBar = UIView().then({ (view) in
            view.frame.size = CGSize.init(width: SCREEN_WIDTH, height: topBarHeight)
        })
        self.contentView = MagicContentView().then({ (view) in
            view.frame.size = CGSize.init(width: SCREEN_WIDTH, height: contentHeight)
        })
        if(isFull){
         headerViewHeight =  contentView.frame.size.height
        }else{
         headerViewHeight =  topBar.frame.size.height+contentView.frame.size.height
        }

        if anthorHeight != 0{
          self.anthorView = UIView().then({ (view) in
            view.frame.size = CGSize.init(width: SCREEN_WIDTH, height: anthorHeight)
          })
            if (isFull){
            self.anthorView?.frame.origin.y = self.contentView.frame.size.height
            }else{
            self.anthorView?.frame.origin.y = topBar.frame.size.height + self.contentView.frame.size.height
            }
          headerViewHeight += (anthorView?.frame.size.height)!
        }
        super.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height:headerViewHeight))
        addSubview(topBar)
        if(isFull){
        contentView.frame.origin.y = 0
        }else{
        contentView.frame.origin.y = getHeight(view: topBar)
        }
        addSubview(contentView)
        if (anthorView != nil) {addSubview(anthorView!)}
        bringSubview(toFront: topBar)

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func contentScrollCloseEnable(){
        contentView.setCloseListener {[weak self] in
            self?.scrollView.setContentOffset(CGPoint.init(x: 0, y: (self?.getHeight(view: (self?.contentView)!))!), animated: true)
            self?.openScroll = false
        }
    }
    
    public func contentScrollOpenEnable(){
        contentView.setOpenListener {[weak self] in
            self?.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
            self?.openScroll = false
        }
    }
    
    
    
    /// 绑定宿主ScrollView
    ///
    /// - Parameter view: 宿主View
    public func bindView(view : UIScrollView){
        self.scrollView = view
        self.scrollView.bounces = false
        self.scrollView.decelerationRate = 1
    }
    
    
    /// 绑定宿主滑动事件
    ///
    /// - Parameter offset: 滑动的点
    public func bindScroll(offset : CGPoint){
        if(offset.y == 0){
            oldScrollY = 0
        }
        if (offset.y > 0) {
            let y = offset.y >  (isFull ? getHeight(view: contentView)-getHeight(view: topBar) : getHeight(view: contentView)) ? (isFull ? getHeight(view: contentView)-getHeight(view: topBar) : getHeight(view: contentView)) : offset.y;
            if (getOriginY(view: contentView) > getHeight(view: topBar) || getOriginY(view: contentView) < -(getHeight(view: contentView)-getHeight(view: topBar))){
                oldScrollY = offset.y
                return;
            }
            contentView.frame.origin.y = (isFull ? -y : getHeight(view: topBar) - y)
            if(anthorView != nil) {
                anthorView?.frame.origin.y = headerViewHeight-(anthorView?.frame.size.height)!-y
            }
            scrollView.frame.origin.y = headerViewHeight - y;
            if(y < (isFull ? getHeight(view: contentView)-getHeight(view: topBar) :getHeight(view: contentView)) && (oldScrollY>offset.y)&&openScroll){
                if(self.scrollView.isKind(of: UITableView.self)){
                    (self.scrollView as! UITableView).scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                }else if(self.scrollView.isKind(of: UICollectionView.self)){
                    (self.scrollView as! UICollectionView).scrollToItem(at: IndexPath.init(row: 0, section: 0), at: UICollectionViewScrollPosition.top, animated: true)
                }else{
                    self.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
                }
                self.openScroll = false
            }
            oldScrollY = offset.y
        }
        oldScrollY = offset.y
    }
    
    
    /// 开启滑动开关
    ///
    /// - Parameter point: 滑动的点
    public func ScrollEnable(point :CGPoint){
        if(point.y>100){
        openScroll = true
        }
    }
    
    
    /// 关闭滑动开关
    public func ScrollDisable(){
        openScroll = false
    }
    
    
    /// 获取View的高度
    ///
    /// - Parameter view: 需要获取高的View
    /// - Returns: 返回的View高度
    private func getHeight(view : UIView) -> CGFloat{
        return view.frame.size.height
    }
    
    
    /// 获取该View Y轴所在的点
    ///
    /// - Parameter view: 需要获取Y轴坐标的View
    /// - Returns: 返回该View Y轴坐标
    private func getOriginY(view : UIView) -> CGFloat{
        return view.frame.origin.y
    }
    
    public func TopBar() -> UIView {
        return topBar
    }
    
    public func Content() -> UIView {
        return contentView
    }
    
    public func AnthorView() -> UIView? {
        return anthorView
    }

    public func  minHeight() -> CGFloat{
        return ((anthorView != nil) ? ((anthorView?.frame.size.height)! + topBar.frame.size.height) : topBar.frame.size.height )
    }
}

class MagicContentView : UIView{
   
    typealias contentListener = () -> ()
    private var   close : contentListener?
    private var   open : contentListener?
    private var beginPoint :CGPoint!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        beginPoint = (touches.first?.location(in: self))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let endY = (touches.first?.location(in: self).y)!
        let result = beginPoint.y - endY
        let offX = beginPoint.x -  (touches.first?.location(in: self).x)!
        
        if  (offX < (SCREEN_WIDTH/3) && offX > -(SCREEN_WIDTH/3)) {
        if result > 0 {
            if(result>(frame.size.height/3)){
                if(close != nil){ close!()
             }
          }
        }else{
            if result < -(frame.size.height/3){
                if(open != nil){
                    open!()
                }
            }
        }
    }
}
    
    func setOpenListener(open : @escaping contentListener){
        self.open = open
    }
    
    func setCloseListener(close : @escaping contentListener){
        self.close = close
    }
}
