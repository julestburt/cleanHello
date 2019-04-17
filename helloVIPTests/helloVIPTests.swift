//  Copyright © 2019 Jules Burt. All rights reserved.

import XCTest
@testable import helloVIP   // This is how our Test App gets access to our real classes...

class helloInteractorTests: XCTestCase {

    let interactor = Interactor()
    let spyPresenter = SpyPresenter()

    func testInteractor() {
        interactor.presenter = spyPresenter
        interactor.buttonPressed("")
        XCTAssert(spyPresenter.didInteractorSendStringOnPress == true, "presenter did not get show Method called by Interactor")
        XCTAssert(spyPresenter.receivedString == "Hello world!", "presenter did not get initial 'hello world' string from Interactor")

        spyPresenter.didInteractorSendStringOnPress = false
        interactor.buttonPressed("Hello world!")
        XCTAssert(spyPresenter.didInteractorSendStringOnPress == true, "presenter did not get show Method called by Interactor")
        XCTAssert(spyPresenter.receivedString == "Goodbye", "presenter did not get alternate 'goodbye' string from Interactor")
    }

    class SpyPresenter:presenterInterface {
        var didInteractorSendStringOnPress = false
        var receivedString:String?
        func show(_ fromInteractor: String) {
            didInteractorSendStringOnPress = true
            receivedString = fromInteractor
        }
    }
}

class helloPresenterTests : XCTestCase {
    let presenter = Presenter()
    let spyView = SpyView()

    func testPresenter() {
        presenter.view = spyView
        presenter.show("Hello world!")
        XCTAssert(spyView.didCallDisplay == true, "presenter did not call view Display method")
        XCTAssert(spyView.receivedString == "Hello world!", "presenter did not send 'hello world' string")
    }

    class SpyView:viewInterface {
        var didCallDisplay = false
        var receivedString:String? = nil

        func display(_ input: String) {
            didCallDisplay = true
            receivedString = input
        }
    }
}


class helloViewTests: XCTestCase {
    var viewController:ViewController! = nil
    let spyInteractor = SpyInteractor()
    let window:UIWindow! = UIWindow()

    func loadView() {
            window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }

    func testViewController() {

        let story = UIStoryboard(name: "Main", bundle: nil)
        viewController = story.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        window.addSubview(viewController.view)
        viewController.interactor = spyInteractor

        viewController.goButtonPressed(UIButton())
        XCTAssert(spyInteractor.didReceiveButtonPress == true, "view did not call 'buttonPressed' method of interactor")
        viewController.display("Hello world!")
        XCTAssert(viewController.label.text == "Hello world!", "view did not update the label text")
    }

    class SpyInteractor:interactorInterface {
        var didReceiveButtonPress = false
        var receivedString:String? = nil
        func buttonPressed(_ existing: String) {
            didReceiveButtonPress = true
            receivedString = existing
        }
    }
}
