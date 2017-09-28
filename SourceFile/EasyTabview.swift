//
//  EasyTabview.swift
//  Ios组件化Demo
//
//  Created by LDD on 2017/9/25.
//  Copyright © 2017年 LDD. All rights reserved.
//

import UIKit
import HMSegmentedControl

public class EasyTabview: HMSegmentedControl {
    
    private var delegate : EasyTabViewDelegate?
    
    override init!(sectionTitles sectiontitles: [String]!) {
        super.init(sectionTitles: sectiontitles)
    }
    
    override init!(sectionImages: [UIImage]!, sectionSelectedImages: [UIImage]!, titlesForSections sectiontitles: [String]!) {
        super.init(sectionImages: sectionImages, sectionSelectedImages: sectionSelectedImages, titlesForSections: sectiontitles)
    }
    
    override init!(sectionImages: [UIImage]!, sectionSelectedImages: [UIImage]!) {
        super.init(sectionImages: sectionImages, sectionSelectedImages: sectionSelectedImages)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func config(indicatorLocation :HMSegmentedControlSelectionIndicatorLocation? = HMSegmentedControlSelectionIndicatorLocation.down , indicatorColor :UIColor? = UIColor.red ,indicatorHeight : CGFloat? = 1,selectTextColor :UIColor? = UIColor.red , selectTextSize : CGFloat? = 17,
                nomalTextColor:UIColor? = UIColor.black,nomalTextSize :CGFloat? = 15,selectionStyle : HMSegmentedControlSelectionStyle? = HMSegmentedControlSelectionStyle.fullWidthStripe,backgroundColor :UIColor? = UIColor.white){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.selectionIndicatorLocation = indicatorLocation!
        self.selectionIndicatorColor = indicatorColor
        self.selectionIndicatorHeight = indicatorHeight!
        self.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor:selectTextColor!,NSAttributedStringKey.font:UIFont.systemFont(ofSize: selectTextSize!)]
        self.titleTextAttributes = [NSAttributedStringKey.foregroundColor:nomalTextColor!,NSAttributedStringKey.font:UIFont.systemFont(ofSize: nomalTextSize!)]
        self.selectionStyle = selectionStyle!
        self.backgroundColor = backgroundColor
        self.addTarget(self, action: #selector(itemClick(_:)), for: .valueChanged)
    }
    
    @objc func itemClick(_ sender:AnyObject){
        let index = (sender as! EasyTabview).selectedSegmentIndex
        if(delegate != nil){
            delegate?.tabItemClick(index: index)
        }
    }
    
    public func setDelegate(delegate : EasyTabViewDelegate){
        self.delegate = delegate
    }
    
}

public protocol EasyTabViewDelegate {
     func tabItemClick(index :Int)
}
