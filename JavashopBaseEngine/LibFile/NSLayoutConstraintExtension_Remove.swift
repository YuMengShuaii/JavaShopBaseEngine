

import UIKit

extension NSLayoutConstraint {
    func easy_autoRemove() {
        if #available(iOS 8.0, *) {
            self.isActive = false
            return
        }
        
        if self.secondItem != nil {
            var commonSuperview:UIView?
            commonSuperview = (self.firstItem as! UIView).easy_commonSuperviewWithView(self.secondItem as! UIView)
            while commonSuperview != nil {
                if commonSuperview?.constraints.contains(self) == true {
                    commonSuperview?.removeConstraint(self)
                    return
                }
                commonSuperview = commonSuperview?.superview
            }
        }
        else {
            self.firstItem?.removeConstraint(self)
            return
        }
        assert(false, "Failed to remove constraint: \(self)")
    }
}

