//
//  ListCell.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/9.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import Then
import SnapKit
import Reusable

class ListCell:UICollectionViewCell,Reusable{
    
      var imageview: UIImageView!
      var lable: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUi()
    }
    
    
    private func createUi(){
        self.contentView.backgroundColor = UIColor.gray
        imageview = UIImageView().then({ (imageview) in
        imageview.layer.cornerRadius = 10
        imageview.layer.masksToBounds = true;
        imageview.backgroundColor = UIColor.white
        imageview.contentMode = UIViewContentMode.scaleAspectFill
        })
        lable = UILabel().then({ (lable) in
            lable.font = UIFont.systemFont(ofSize: 10)
            lable.backgroundColor = UIColor.clear
            lable.textColor = UIColor.white
            lable.numberOfLines = 0
            lable.textAlignment = .left
        })
        self.contentView.addSubview(imageview)
        self.contentView.addSubview(lable)
        imageview.snp.makeConstraints { (make) in
            make.height.width.equalTo(100)
            make.left.equalTo(self.contentView)
        }
        lable.snp.makeConstraints {[weak self] (make) in
            make.left.equalTo((self?.imageview.snp.right)!)
            make.right.equalTo(self!)
            make.height.equalTo(100)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
