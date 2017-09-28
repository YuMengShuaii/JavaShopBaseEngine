//
//  RxCollectionViewSectionedReloadDataSource.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 7/2/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

open class RxCollectionViewInsertSectionDataSource <S: SectionModelType>
    : CollectionViewSectionedDataSource<S>
, RxCollectionViewDataSourceType {
    
    public typealias Element = [S]
    
    public override init() {
        super.init()
    }
    
    open func collectionView(_ collectionView: UICollectionView, observedEvent: Event<Element>) {
        UIBindingObserver(UIElement: self) { dataSource, element in
            dataSource.setSections(element)
            if(dataSource.numberOfSections(in: collectionView) == 1){
                collectionView.reloadData()
            }else{
                collectionView.insertSections(IndexSet.init(integer: dataSource.numberOfSections(in: collectionView)-1))
            }
            collectionView.collectionViewLayout.invalidateLayout()
            }.on(observedEvent)
    }
    
}

