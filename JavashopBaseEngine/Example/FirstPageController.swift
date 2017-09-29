
import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Kingfisher
import SwiftyBeaver

class FirstPageController:BaseViewController{
    private let firstPageView = FirstPage()
    private let vm = FirstPageViewModel()
    
    override func prepare() {
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.white
        bindView(firstPageView)
    }
    
    override func bindVVM() {
        vm.attachView(view: firstPageView)
        vm.bindData()
        vm.bindEvent()
    }
}
