

import UIKit
import HMSegmentedControl

@objc protocol EasyTabPageViewControllerDelegate {
    @objc optional func pageViewDidSelectedIndex(_ index:Int)
}

public class EasyTabPageViewController: EasyPageViewController {
    var segmentedControl:HMSegmentedControl?
    var pageTitles:Array<String>!
    var segmentHeight = 44.0
    
    //MARK: - Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(pageTitles:Array<String>) {
        super.init(nibName: nil, bundle: nil)
        self.pageTitles = pageTitles
        if self.pageTitles.count > 1 {
            self.segmentedControl = HMSegmentedControl(sectionTitles: self.pageTitles)
            self.setupSegmentedControl(segmentedControl: self.segmentedControl)
        }
    }
    
    //MARK: - Lift Cycles
    override public func viewDidLoad() {
        super.viewDidLoad()
        assert((pageTitles.count == self.pageCount), "title count is not equal controllers count")
        
        if self.pageTitles.count > 1 {
            self.layoutSegmentedControl(self.segmentedControl)
        }
        
        self.resetScrollViewLayoutConstraints(self.scrollView)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: - Target & Action
    @objc fileprivate func segmentValueChanged(_ sender:AnyObject) {
        if let segControl = self.segmentedControl {
            self.showPageAtIndex(segControl.selectedSegmentIndex, animated: true)
        }
    }
    
    //MARK: - Subviews Configuration
    @objc fileprivate func resetScrollViewLayoutConstraints(_ scrollView:UIScrollView) {
        scrollView.easy_removeConstraintsAffectingView()
        var constraints = Array<NSLayoutConstraint>()
        let constraintAttributes = Array<NSLayoutAttribute>(arrayLiteral: .bottom,.leading,.trailing)
        
        let topConstraint = NSLayoutConstraint(item: scrollView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.segmentedControl,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 0)
        constraints.append(topConstraint)
        
        for attribute in constraintAttributes {
            let constraint = NSLayoutConstraint(item: scrollView,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: self.view,
                                                attribute: attribute,
                                                multiplier: 1.0,
                                                constant: 0)
            constraints.append(constraint)
        }
        self.view.addConstraints(constraints)
    }
    
    @objc private func setupSegmentedControl(segmentedControl:HMSegmentedControl?) {
        if let segControl = segmentedControl {
            segControl.translatesAutoresizingMaskIntoConstraints = false
            segControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.down
            segControl.selectionIndicatorColor = UIColor(red: 0xdc/0xff, green: 0xb6/0xff, blue: 0x65/0xff, alpha: 1.0)
            segControl.selectionIndicatorHeight = 3.0
            segControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName:UIColor(red: 0xdc/0xff, green: 0xb6/0xff, blue: 0x65/0xff, alpha: 1.0),NSFontAttributeName:UIFont.systemFont(ofSize: 22)]
            segControl.titleTextAttributes = [NSForegroundColorAttributeName:UIColor(red: 0x84/0xff, green: 0xb0/0xff, blue: 0xdf/0xff, alpha: 1.0),NSFontAttributeName:UIFont.systemFont(ofSize: 18)]
            segControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
            segControl.backgroundColor = UIColor.blue
            segControl.addTarget(self, action: #selector(EasyTabPageViewController.segmentValueChanged), for: .valueChanged)
        }
    }
    
    @objc fileprivate func layoutSegmentedControl(_ segmentedControl:HMSegmentedControl?) {
        if let segControl = segmentedControl {
            self.view.addSubview(segControl)
            
            var constraints = Array<NSLayoutConstraint>()
            let constraintAttributes = Array<NSLayoutAttribute>(arrayLiteral:.leading,.trailing)
            for attribute in constraintAttributes {
                let constraint = NSLayoutConstraint(item: segControl,
                                                    attribute: attribute,
                                                    relatedBy: .equal,
                                                    toItem: self.view,
                                                    attribute: attribute,
                                                    multiplier: 1.0,
                                                    constant: 0)
                constraints.append(constraint)
            }
            
            let topConstraint = NSLayoutConstraint(item: segControl,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: self.topLayoutGuide,
                                                   attribute: .bottom,
                                                   multiplier: 1.0,
                                                   constant: 0)
            constraints.append(topConstraint)
            
            let heightConstraint = NSLayoutConstraint(item: segControl,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 0.0,
                                                      constant: CGFloat(segmentHeight))
            constraints.append(heightConstraint)
            self.view.addConstraints(constraints)
        }
    }
    
    //MARK: - Override super class methods
    
    // Sent when a gesture-initiated transition ends.
    @objc override func easy_pageViewControllerDidTransitonFrom(_ fromIndex:Int, toIndex:Int)
    {
        super.easy_pageViewControllerDidTransitonFrom(fromIndex, toIndex: toIndex)
        self.segmentedControl?.setSelectedSegmentIndex(UInt(toIndex), animated: true)
    }
    
    // Sent after method(func showPageAtIndex(index:Int,animated:Bool)) finished.
    @objc override func easy_pageViewControllerDidShow(_ fromIndex:Int, toIndex:Int, finished:Bool)
    {
        super.easy_pageViewControllerDidShow(fromIndex, toIndex:toIndex, finished:finished)
        self.segmentedControl?.setSelectedSegmentIndex(UInt(toIndex), animated: true )
    }
}

