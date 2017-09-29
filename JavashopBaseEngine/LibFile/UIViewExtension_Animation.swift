

import UIKit

extension UIView {
    func pauseAnimations() {
        let paused_time = self.layer.convertTime(CACurrentMediaTime(), to: nil)
        self.layer.speed = 0.0
        self.layer.timeOffset = paused_time
    }
    
    func resumeAnimations() {
        let paused_time = self.layer.timeOffset
        self.layer.speed = 1.0
        self.layer.timeOffset = 0.0
        self.layer.beginTime = 0.0
        let time_since_pause = self.layer.convertTime(CACurrentMediaTime(), to: nil) - paused_time
        self.layer.beginTime = time_since_pause
    }
}

