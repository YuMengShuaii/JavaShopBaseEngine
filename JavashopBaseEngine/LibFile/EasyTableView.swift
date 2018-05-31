//
//  EasyTableView.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/12.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift
import AudioToolbox

public class EasyTableView<DataType>: UITableView {
    
    /// 数据源
    private let dataArr = Variable([SectionModel<String, DataType>]())
    
    /// RxDataSource
    private let datasource = RxTableViewSectionedReloadDataSource<SectionModel<String, DataType>>()
    
    ///点击代码块
    public var click :JavaShopVoidMethod1<DataType>!
    
    public var longClick :JavaShopVoidMethod1<DataType>!
    
    /// 初始化
    ///
    /// - Parameters:
    ///   - frame: layout参数
    ///   - style: 默认样式
    override public init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        rx.modelSelected(DataType.self)
          .bind { [weak self](data) in
            if(self?.click != nil){
              self?.click(data)
            }
        }.addDisposableTo(disposeBag)
    }
    
    /// 创建Cell布局
    ///
    /// - Parameter cellBlack: 布局创建代码块
    public func createCell(cellBlack: JavaShopMethod4<TableViewSectionedDataSource<SectionModel<String, DataType>>, UITableView, IndexPath, DataType,UITableViewCell>!){
        datasource.configureCell = cellBlack
        dataArr.asDriver()
            .filter({ (data) -> Bool in
                return data.count > 0
            }).drive(rx.items(dataSource: datasource))
            .addDisposableTo(disposeBag)
    }
    
    /// 设置点击事件
    ///
    /// - Parameter click: 点击回调代码块
    public func setOnItemClickListener(click: @escaping JavaShopVoidMethod1<DataType>){
        self.click = click
    }
    
    /// 设置Item长按事件
    ///
    /// - Parameter longClick: 长按事件回调代码块
    public func setOnItemLongClickListener(longClick: @escaping JavaShopVoidMethod1<DataType>){
        self.openItemLongClick()
        self.longClick = longClick
    }
    
    /// 开启Item长按事件
    private func openItemLongClick(){
        let onLongClickEvent = UILongPressGestureRecognizer.init(target: self, action: #selector(longClickEvnet(sender:)))
        onLongClickEvent.minimumPressDuration = 1
        onLongClickEvent.numberOfTouchesRequired = 1
        addGestureRecognizer(onLongClickEvent)
    }
    
    
    /// 长按接收事件
    ///
    /// - Parameter sender: 长按事件
    @objc public func longClickEvnet(sender :UILongPressGestureRecognizer){
        let longTouchPoint = sender.location(in: self)
        if sender.state == UIGestureRecognizerState.began {
            let touchIndex =  self.indexPathForRow(at: longTouchPoint)
            if touchIndex != nil{
                AudioServicesPlaySystemSound(1520)
                if (touchIndex?.section)! >= dataArr.value.count { return }
                if (touchIndex?.row)! >= dataArr.value[(touchIndex?.section)!].items.count { return }
                longClick(dataArr.value[(touchIndex?.section)!].items[(touchIndex?.row)!])
            }
        }
    }
    
    
    /// 是否开启自动加载
    ///
    /// - Parameter loadMore: 加载Black
    public func autoLoadMore(loadMore : @escaping JavaShopVoidMethod){
        rx.willDisplayCell.observeOn(MainScheduler.instance).bind {[weak self] (dispaly: (cell: UITableViewCell, indexPath: IndexPath)) in
            if dispaly.indexPath.section == (self?.dataArr.value.count)! - 1 && dispaly.indexPath.row == ((self?.numberOfRows(inSection: dispaly.indexPath.section))!/3) {
                loadMore()
            }
        }.addDisposableTo(disposeBag)
    }
    
    /// 添加数据
    ///
    /// - Parameter datas: 数据集合
    public func addData(datas:[DataType]){
        addData(title: "", datas: datas)
    }
    
    /// 添加带标题的数据集合
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - datas: 数据集合
    public func addData(title : String,datas : [DataType]){
        dataArr.value.append(SectionModel.init(model: title, items: datas))
    }
    
    
    /// 清空数据
    public func clearData(){
        dataArr.value.removeAll()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

