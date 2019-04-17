//  Copyright © 2019 Jules Burt. All rights reserved.

import UIKit

//----------------------------------------------------------
// MARK: View Logic
//----------------------------------------------------------
protocol viewInterface {
    func display(_ input:String)
}

extension ViewController {
    func display(_ input: String) {
        label.text = input
    }

    @IBAction func goButtonPressed(_ sender: Any) {
        interactor?.buttonPressed(label.text!)
    }
}

//----------------------------------------------------------
// MARK: View Controller
//----------------------------------------------------------

class ViewController: UIViewController, viewInterface {
    @IBOutlet weak var label: UILabel!

    var interactor:interactorInterface? = nil
    override func viewDidLoad() {
        let viewController = self
        let interactor = Interactor()
        let presenter = Presenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.view = viewController
    }

}

// What we replaced with three classes!
/*
class helloView: UIViewController {
    @IBOutlet weak var label: UILabel!

    @IBAction func goButtonPressed(_ sender: Any) {
        label.text = label.text == "Hello world!" ? "Goodbye" : "Hello world!"
    }
}
*/
