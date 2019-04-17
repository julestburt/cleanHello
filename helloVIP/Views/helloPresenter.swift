//  Copyright © 2019 Jules Burt. All rights reserved.

import Foundation

//----------------------------------------------------------
// MARK: Presenter
//----------------------------------------------------------

protocol presenterInterface {
    func show(_ fromInteractor:String)
}

class Presenter: presenterInterface {
    var view:viewInterface? = nil
    func show(_ fromInteractor: String) {
        view?.display(fromInteractor)
    }
}
