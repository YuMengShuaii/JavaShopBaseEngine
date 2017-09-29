//
//  ListViewModel.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/9.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import RxDataSources
import Reusable

class ListViewModel :BaseViewModel<ListViewPage> ,UICollectionViewDelegate{
    
    private let gankApi = RxMoyaProvider<GankApi>()
    var count = 1
    private var refreshHelper:RefreshHelper!
    public func getGirl()-> Single<AndroidModle>{
        return  gankApi.request(.Girl("\(count)"))
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
                .observeOn(MainScheduler.instance)
                .filterSuccessfulStatusCodes()
                .mapInstance(AndroidModle.self)
    }
    
    override func bindData() {
        self.pView?.collectionView.delegate = self
        self.pView?.collectionView.setOnItemClickListener(click: {[weak self] (data) in
        self?.pView?.getViewController()?.navigationController?.pushViewController( TableControllerViewController(), animated: true)
        })
        self.pView.collectionView.setOnItemLongClickListener { (data) in
            SJProgressHUD.showOnlyText(data.url)
        }
        self.pView?.collectionView.createCell(cellBlack: { (datasource, cv, indexpath, data) -> (UICollectionViewCell) in
            let cell :ListCell = cv.dequeueReusableCell(for: indexpath)
            cell.lable.text = data.url
            cell.imageview.setImageWithAnthor(url: data.url)
            return cell
        })
        refreshHelper =  RefreshHelper.init(sv: (pView?.collectionView)!)
        refreshHelper.openTopRefresh {[weak self] in
            self?.count=1
            self?.pView?.collectionView.clearData()
            self?.loadData()
        }
        self.pView?.collectionView.autoLoadMore { [weak self] in
            self?.count+=1
            AutoRefeshViewHelper.insertLoadView(cv:  (self?.pView.collectionView)!)
            self?.loadData()
        }
        refreshHelper.startRefresh(at: .top)
    }
    
    func loadData(){
            getGirl().subscribe(onSuccess: {[weak self] (data) in
                self?.refreshHelper.endRefresh()
                if  data.results.count == 0 {
                    if (self?.pView?.collectionView.getData().count == 0){
                       AutoRefeshViewHelper.insertNotFound(cv: (self?.pView.collectionView)!)
                    }else{
                       AutoRefeshViewHelper.insertNoMore(cv: (self?.pView.collectionView)!)
                    }
                }else{
                 AutoRefeshViewHelper.remove(view: (self?.pView.collectionView)!)
                }
                self?.pView?.collectionView.addData(datas: data.results)
            }).addDisposableTo(disposeBag)
    }
    
    override func bindEvent() {
        
    }

    deinit {
        refreshHelper.destoryRefresh()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        Log.error(scrollView.contentOffset.y)
        pView?.magicHeaderView.bindScroll(offset:scrollView.contentOffset)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        pView?.magicHeaderView.ScrollEnable(point: scrollView.contentOffset)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pView?.magicHeaderView.ScrollDisable()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        pView?.magicHeaderView.ScrollDisable()
    }
}


