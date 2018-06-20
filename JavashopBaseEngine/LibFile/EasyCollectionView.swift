//
//  EasyCollectionView.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/11.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa
import AudioToolbox

/// 简化操作的UICollectionView
public class EasyCollectionView<DataType>: UICollectionView {

    /// 数据源
    private var datasource : RxCollectionViewInsertSectionDataSource<SectionModel<String,DataType>>!
    
    /// 数据集合
    private let dataArr = Variable([SectionModel<String, DataType>]())
    
    ///点击代码块
    private var click :JavaShopVoidMethod1<DataType>!
    
    private var longClick :JavaShopVoidMethod1<DataType>!
    
    private var canBindData = true
    
    /// 是否开启刷新加载
    private var isRefresh = false
    
    ///
    /// - Parameters:初始化方法
    ///   - frame:  frame信息
    ///   - layout: 初始布局
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
            rx.modelSelected(DataType.self)
            .bind(onNext: {[weak self] (data) in
                self?.click(data)
            }).disposed(by: rx.disposeBag)
        }
    
    
    
    /// 设置Item点击事件
    ///
    /// - Parameter click: 点击回调代码块
    public func setOnItemClickListener(click: JavaShopVoidMethod1<DataType>!){
        self.click = click
    }
    
    /// 设置Item长按事件
    ///
    /// - Parameter longClick: 长按事件回调代码块
    public func setOnItemLongClickListener(longClick: JavaShopVoidMethod1<DataType>!){
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
    @objc private func longClickEvnet(sender :UILongPressGestureRecognizer){
        let longTouchPoint = sender.location(in: self)
        if sender.state == UIGestureRecognizerState.began {
            let touchIndex = self.indexPathForItem(at: longTouchPoint)
            if touchIndex != nil{
                AudioServicesPlaySystemSound(1520)
                if (touchIndex?.section)! >= dataArr.value.count { return }
                if (touchIndex?.row)! >= dataArr.value[(touchIndex?.section)!].items.count { return }
                longClick(dataArr.value[(touchIndex?.section)!].items[(touchIndex?.row)!])
            }
        }
    }
    
    
    /// 开启自动加载
    ///
    /// - Parameter loadMore: 加载更多
    public func autoLoadMore(loadMore : @escaping JavaShopVoidMethod){
        rx.willDisplayCell.bind {[weak self] (data:(cell: UICollectionViewCell, at: IndexPath)) in
            if data.at.section == (self?.dataArr.value.count)! - 1 && data.at.row == ((self?.numberOfItems(inSection: data.at.section))!/3) {
                loadMore()
            }
            }.disposed(by: rx.disposeBag)
    }
    
    /// 创建Cell布局
    ///
    /// - Parameter cellBlack: 布局创建代码块
    public func createCell(cellBlack: @escaping JavaShopMethod4<CollectionViewSectionedDataSource<SectionModel<String,DataType>>, UICollectionView, IndexPath, DataType,UICollectionViewCell>){
        datasource = RxCollectionViewInsertSectionDataSource<SectionModel<String,DataType>>(configureCell: cellBlack)
            dataArr.asObservable()
                .filter({ (data) -> Bool in
                    return data.count > 0
                })
                .bind(to: (rx.items(dataSource: datasource)))
                .disposed(by: rx.disposeBag)
    }
    
    /// 添加数据
    ///
    /// - Parameter datas: 数据集合
    public func addData(datas:[DataType]){
        addData(title: "", datas: datas)
    }
    
    public func getData() -> [SectionModel<String, DataType>]{
        return dataArr.value
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
        super.init(coder: aDecoder)
    }
    
    
}
