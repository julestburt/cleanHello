//  Copyright © 2019 Jules Burt. All rights reserved.

import Foundation

//----------------------------------------------------------
// MARK: Interactor
//----------------------------------------------------------

protocol interactorInterface {
    func buttonPressed(_ existing:String)
}

class Interactor: interactorInterface {
    var presenter:presenterInterface? = nil

    func buttonPressed(_ existing: String) {
        let returnString = existing == "Hello world!" ? "Goodbye" : "Hello world!"
        presenter?.show(returnString)
    }
}


