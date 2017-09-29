

import UIKit

extension NSArray {
    
    func easy_autoRemoveConstraints() {
        if #available(iOS 8.0, *) {
            if NSLayoutConstraint.responds(to: #selector(NSLayoutConstraint.deactivate(_:))) {
                NSLayoutConstraint.deactivate(self as! [NSLayoutConstraint])
                return
            }
        }
        
        for object in self {
            if (object as AnyObject).isKind(of: NSLayoutConstraint.self) {
                (object as! NSLayoutConstraint).easy_autoRemove()
            }
        }
    }
}

