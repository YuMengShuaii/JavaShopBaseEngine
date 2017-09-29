//
//  TableViewModel.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/12.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import RxDataSources
import Reusable

class TableViewModel : BaseViewModel <TableViewPage> , UITableViewDelegate {
   
    private let gankApi = RxMoyaProvider<GankApi>()
    var count = 1
    private var refreshHelper:RefreshHelper!
    public func getGirl()-> Single<AndroidModle>{
        return  gankApi.request(.Girl("\(count)"))
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .filterSuccessfulStatusCodes()
            .mapInstance(AndroidModle.self)
            .observeOn(MainScheduler.instance)
    }

    override func bindData() {
        self.pView?.tableView.delegate = self
        self.pView?.tableView.createCell(cellBlack: { (datasource, tv, ip, data) -> UITableViewCell in
            let cell : TableViewCell = tv.dequeueReusableCell(for: ip)
            cell.lable.text = data.url
            cell.imageview.setImageWithAnthor(url: data.url)
            return cell
        })
    }
    
    override func bindEvent() {
        self.pView?.tableView.setOnItemClickListener(click: {[weak self] (data) in
            self?.pView?.getViewController()?.navigationController?.pushViewController(ListViewController(), animated: true)
        })
        self.pView.tableView.setOnItemLongClickListener { (data) in
            SJProgressHUD.showOnlyText(data.url)
        }
        refreshHelper =  RefreshHelper.init(sv: (pView?.tableView)!)
        
        self.pView?.tableView.autoLoadMore {
            [weak self] in
            self?.count+=1
            self?.loadData()
        }
        loadData()
    }
    
    override func bindNatification() {
        
    }
    
    func loadData(){
        getGirl().subscribe(onSuccess: {[weak self] (data) in
            self?.pView?.tableView.addData(title :"\(String(describing: self?.count))",datas: data.results)
            self?.refreshHelper.endRefresh()
        }).addDisposableTo(disposeBag)
    }
    
    deinit {
        if(refreshHelper != nil){
        refreshHelper.destoryRefresh()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 10{
        return 100
        }
        return 0.001;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 10{
            return 100
        }
        return 0.001;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section==10 {
            return UIView().then({ (view) in
                view.frame.size = CGSize.init(width: SCREEN_WIDTH, height: 200)
                view.backgroundColor = UIColor.black
            })
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section==10 {
            return UIView().then({ (view) in
                view.frame.size = CGSize.init(width: SCREEN_WIDTH, height: 200)
                view.backgroundColor = UIColor.white
            })
        }
        return nil
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

