//
//  TableViewCell.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/12.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import Reusable

class TableViewCell: UITableViewCell,Reusable {

    var imageview: UIImageView!
    var lable: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
          self.createUi()
    }
    
    func createUi(){
        self.contentView.backgroundColor = UIColor.gray
        self.selectionStyle = UITableViewCellSelectionStyle.none
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
