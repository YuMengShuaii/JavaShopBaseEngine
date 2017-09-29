//
//  RefreshHelper.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/11.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit


/// 刷新辅助类
public class RefreshHelper {
    
    
    /// 基于ScrollView
    private let sv:UIScrollView
    
    /// 默认头部
    private let top =    PullToRefresh.init(height: GET_SCREEN_HEIGHT(17), position: .top)
    
    /// 默认尾部
    private let bottom = PullToRefresh.init(height: GET_SCREEN_HEIGHT(17), position: .bottom)
    
    /// action事件类型
    public typealias actionType = ()->()
    
    /// 初始化
    ///
    /// - Parameter cv: UIScrollView
    init(sv:UIScrollView) {
        self.sv = sv
    }
    
    
    /// 开启刷新 默认刷新视图
    ///
    /// - Parameters:
    ///   - topAction: 下拉刷新回调代码块
    ///   - bottomAction: 上拉刷新回调大妈快
    public func openRefresh(topAction : @escaping ()->() , bottomAction : @escaping ()->()) {
        sv.addPullToRefresh(top, action:topAction)
        sv.addPullToRefresh(bottom,action: bottomAction)
    }
    
    
    /// 开启下拉刷新
    ///
    /// - Parameters:
    ///   - topRefresh: 下拉刷新视图
    ///   - topAction:  下拉刷新回调代码块
    public func openTopRefresh(topRefresh : PullToRefresh?=nil ,topAction : @escaping ()->()){
        if topRefresh==nil {
            sv.addPullToRefresh(top, action:topAction)
        }else{
            sv.addPullToRefresh(topRefresh!, action:topAction)
        }
    }
    
    
    /// 开启上拉刷新
    ///
    /// - Parameters:
    ///   - bottomRefresh: 上拉刷新视图
    ///   - bottomAction:  上拉刷新回调代码块
    public func openBottomRefresh(bottomRefresh : PullToRefresh?=nil ,bottomAction : @escaping ()->()){
        if bottomRefresh==nil {
            sv.addPullToRefresh(bottom, action:bottomAction)
        }else{
            sv.addPullToRefresh(bottomRefresh!, action:bottomAction)
        }
    }
    
    
    ///   同时开启所有刷新
    /// - Parameters:
    ///   - topRefresh:     下拉刷新视图
    ///   - bottomRefresh:  上拉刷新视图
    ///   - topAction:      下拉刷新代码块
    ///   - bottomAction:   上拉刷新代码块
    public func openRefresh(topRefresh : PullToRefresh ,bottomRefresh : PullToRefresh ,topAction : @escaping actionType  , bottomAction : @escaping actionType ){
        sv.addPullToRefresh(topRefresh, action: topAction)
        sv.addPullToRefresh(bottomRefresh, action: bottomAction)
    }
    
    
    /// 开启刷新
    ///
    /// - Parameter at:  判断使用上拉刷新还是下拉刷新
    public func startRefresh(at:Position){
        sv.startRefreshing(at: at)
    }
    
    
    /// 停止下拉刷新
    public func endTopRefresh(){
        sv.endRefreshing(at: .top)
    }
    
    ///停止上拉刷新
    public func endBottomRefresh(){
        sv.endRefreshing(at: .bottom)
    }
    
    
    /// 停止所有刷新
    public func endRefresh(){
        sv.endRefreshing(at: .top)
        sv.endRefreshing(at: .bottom)
    }
    
    
    /// 调用类 在deinit方法必须调用  否则内存泄漏
    public func destoryRefresh(){
        if sv.bottomPullToRefresh != nil {sv.removePullToRefresh(sv.bottomPullToRefresh!)}
        if sv.topPullToRefresh    != nil {sv.removePullToRefresh(sv.topPullToRefresh!)}
    }
    
}
