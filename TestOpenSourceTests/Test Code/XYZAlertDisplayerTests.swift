import Quick
import Nimble
import UIKit
@testable import TestOpenSource

///// NOTE: REFACTOR


class XYZDisplayErrorTests: QuickSpec {
    override func spec() {

        it("Should Display Alert Controller On View Controller") {
            let subject = MockErrorController()

            subject.displayError("My Title", message: "My Message")

            expect(subject).to(invoke(MockErrorController.InvocationKeys.presentViewController))

            let alert = subject.parameters(for: MockErrorController.InvocationKeys.presentViewController)[0] as? UIAlertController

            expect(alert?.title).to(equal("My Title"))
            expect(alert?.message).to(equal("My Message"))

            let animated = subject.parameters(for: MockErrorController.InvocationKeys.presentViewController)[1] as? Bool
            expect(animated).to(beTrue())
        }
    }

    private class MockErrorController: UIViewController, XYZErrorDisplayer, XYZMockable {
        var mocker = Mocker()
        struct InvocationKeys {
            static let presentViewController = "presentViewController"
        }
        
        public override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
            record(invocation: InvocationKeys.presentViewController, with: viewControllerToPresent, flag)
        }
    }
    
}

class XYZAlertDisplayerTests: QuickSpec {
    class MockViewController: UIViewController, XYZMockable {
        var mocker = Mocker()
        struct InvocationKeys {
            static let presentViewController = "presentViewController"
        }
        override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
            record(invocation: InvocationKeys.presentViewController, with: viewControllerToPresent, flag, completion as Any)
        }
    }

    override func spec() {
        describe("XYZAlertDisplayer") {

            var mockController: MockViewController!
            var subject: XYZAlertDisplayer!

            beforeEach {
                mockController = MockViewController()
                subject = XYZAlertDisplayer(viewController: mockController)
            }

            it("creates a new displayer from the class factory method") {
                let displayer = XYZAlertDisplayer.makeAlertDisplayer(parentViewController: mockController)
                expect(displayer.viewController).to(beIdenticalTo(mockController))
            }

            it("has the view controller") {
                expect(subject.viewController).to(beIdenticalTo(mockController))
            }

            describe("Alert Style") {
                describe("Show OK Alert") {
                    it("should display an alert with a title and message and OK button") {
                        subject.displayStandardAlert(withTitle: "1", andMessage: "2")

                        let alert = mockController.mocker.getParametersFor("presentViewController")?[0] as? UIAlertController

                        expect(alert?.title).to(equal("1"))
                        expect(alert?.message).to(equal("2"))
                        expect(alert?.preferredStyle).to(equal(UIAlertControllerStyle.alert))
                        expect(alert?.actions.count).to(equal(1))
                        expect(alert?.actions.first?.title).to(equal("OK"))
                    }

                    it("should display an alert with a title and message and OK button on the specified ViewController") {
                        let anotherViewController = MockViewController()
                        subject.displayStandardAlert(onViewController: anotherViewController, withTitle: "1", andMessage: "2")

                        let alert = anotherViewController.mocker.getParametersFor("presentViewController")?[0] as? UIAlertController

                        expect(alert?.title).to(equal("1"))
                        expect(alert?.message).to(equal("2"))
                        expect(alert?.actions.count).to(equal(1))
                        expect(alert?.actions.first?.title).to(equal("OK"))
                    }

                    it("uses the presentation completion") {
                        var completed = false
                        subject.displayStandardAlert(withTitle: "1", andMessage: "2", presentCompletion: {
                            completed = true
                        })

                        let completion = mockController.mocker.getParametersFor("presentViewController")?[2] as? (() -> Void)

                        completion?()

                        expect(completed).to(beTrue())
                    }
                }

                describe("Display with Custom Buttons") {
                    it("Accepts a variadic tuple list of buttons") {
                        let actionTuple1: XYZAlertDisplayer.XYZAlertAction = ("Yep1", UIAlertActionStyle.cancel, { _ in })
                        let actionTuple2: XYZAlertDisplayer.XYZAlertAction = ("Yep2", UIAlertActionStyle.default, { _ in })

                        subject.displayAlert(withTitle: "1", andMessage: "2", alertActions: actionTuple1, actionTuple2)

                        let alert = mockController.mocker.getParametersFor("presentViewController")?[0] as? UIAlertController
                        
                        expect(alert?.title).to(equal("1"))
                        expect(alert?.message).to(equal("2"))
                        expect(alert?.actions.count).to(equal(2))
                        expect(alert?.actions.first?.title).to(equal("Yep1"))
                        expect(alert?.actions.last?.title).to(equal("Yep2"))
                    }

                    it("Accepts a variadic tuple list of buttons on the specified ViewController") {
                        let actionTuple1: XYZAlertDisplayer.XYZAlertAction = ("Yep1", UIAlertActionStyle.cancel, { _ in })
                        let actionTuple2: XYZAlertDisplayer.XYZAlertAction = ("Yep2", UIAlertActionStyle.default, { _ in })
                        let anotherViewController = MockViewController()

                        subject.displayAlert(onViewController: anotherViewController, withTitle: "1", andMessage: "2", alertActions: actionTuple1, actionTuple2)

                        let alert = anotherViewController.mocker.getParametersFor("presentViewController")?[0] as? UIAlertController

                        expect(alert?.title).to(equal("1"))
                        expect(alert?.message).to(equal("2"))
                        expect(alert?.actions.count).to(equal(2))
                        expect(alert?.actions.first?.title).to(equal("Yep1"))
                        expect(alert?.actions.last?.title).to(equal("Yep2"))
                    }

                    it("Accepts an array tuple list of buttons") {
                        let actionArray: [XYZAlertDisplayer.XYZAlertAction] = [("Yep1", UIAlertActionStyle.cancel, { _ in }),
                                                                               ("Yep2", UIAlertActionStyle.default, { _ in })]

                        subject.displayAlert(withTitle: "1", andMessage: "2", alertActionList: actionArray)

                        let alert = mockController.mocker.getParametersFor("presentViewController")?[0] as? UIAlertController

                        expect(alert?.title).to(equal("1"))
                        expect(alert?.message).to(equal("2"))
                        expect(alert?.actions.count).to(equal(2))
                        expect(alert?.actions.first?.title).to(equal("Yep1"))
                        expect(alert?.actions.last?.title).to(equal("Yep2"))
                    }

                    it("Accepts an array tuple list of buttons on the specified ViewController") {
                        let actionArray: [XYZAlertDisplayer.XYZAlertAction] = [("Yep1", UIAlertActionStyle.cancel, { _ in }),
                                                                               ("Yep2", UIAlertActionStyle.default, { _ in })]
                        let anotherViewController = MockViewController()

                        subject.displayAlert(onViewController: anotherViewController, withTitle: "1", andMessage: "2", alertActionList: actionArray)

                        let alert = anotherViewController.mocker.getParametersFor("presentViewController")?[0] as? UIAlertController

                        expect(alert?.title).to(equal("1"))
                        expect(alert?.message).to(equal("2"))
                        expect(alert?.actions.count).to(equal(2))
                        expect(alert?.actions.first?.title).to(equal("Yep1"))
                        expect(alert?.actions.last?.title).to(equal("Yep2"))
                    }
                }

                describe("Display with Custom UIAlertActions") {
                    it("accepts an array of UIAlertActions") {
                        let action1 = UIAlertAction(title: "Foo", style: .cancel, handler: { _ in })
                        let action2 = UIAlertAction(title: "Bar", style: .default, handler: { _ in })

                        subject.displayAlert(withTitle: "title", andMessage: "message", uiAlertActions: [action1, action2])

                        let alert = mockController.mocker.getParametersFor("presentViewController")?[0] as? UIAlertController

                        expect(alert?.title).to(equal("title"))
                        expect(alert?.message).to(equal("message"))
                        expect(alert?.actions.count).to(equal(2))
                        expect(alert?.actions.first?.title).to(equal("Foo"))
                        expect(alert?.actions.last?.title).to(equal("Bar"))
                    }
                }
            }

            describe("Action Sheet Style") {
                it("should display an actionSheet with a title and message and OK button") {
                    let action: XYZAlertDisplayer.XYZAlertAction = ("OK", .default, { _ in })

                    subject.displayActionSheet(withTitle: "1", andMessage: "2", sheetActions: action)

                    let alert = mockController.mocker.getParametersFor("presentViewController")?[0] as? UIAlertController

                    expect(alert?.title).to(equal("1"))
                    expect(alert?.message).to(equal("2"))
                    expect(alert?.preferredStyle).to(equal(UIAlertControllerStyle.actionSheet))
                    expect(alert?.actions.count).to(equal(1))
                    expect(alert?.actions.first?.title).to(equal("OK"))
                }

                it("should display an actionSheet with no title or message, and just OK button") {
                    let action: XYZAlertDisplayer.XYZAlertAction = ("OK", .default, { _ in })

                    subject.displayActionSheet(withTitle: nil, andMessage: nil, sheetActions: action)

                    let alert = mockController.mocker.getParametersFor("presentViewController")?[0] as? UIAlertController

                    expect(alert?.title).to(beNil())
                    expect(alert?.message).to(beNil())
                    expect(alert?.preferredStyle).to(equal(UIAlertControllerStyle.actionSheet))
                    expect(alert?.actions.count).to(equal(1))
                    expect(alert?.actions.first?.title).to(equal("OK"))
                }

                it("should display an actionSheet with a title and message and OK button on the specified ViewController") {
                    let anotherViewController = MockViewController()
                    let action: XYZAlertDisplayer.XYZAlertAction = ("OK", .default, { _ in })

                    subject.displayActionSheet(onViewController: anotherViewController, withTitle: "1",  andMessage: "2", sheetActions: action)

                    let alert = anotherViewController.mocker.getParametersFor("presentViewController")?[0] as? UIAlertController

                    expect(alert?.title).to(equal("1"))
                    expect(alert?.message).to(equal("2"))
                    expect(alert?.preferredStyle).to(equal(UIAlertControllerStyle.actionSheet))
                    expect(alert?.actions.count).to(equal(1))
                    expect(alert?.actions.first?.title).to(equal("OK"))
                }

                it("uses the presentation completion") {
                    var completed = false
                    subject.displayActionSheet(withTitle: "1", andMessage: "2", presentCompletion: {
                        completed = true
                    })

                    let completion = mockController.mocker.getParametersFor("presentViewController")?[2] as? (() -> Void)

                    completion?()

                    expect(completed).to(beTrue())
                }

                it("Accepts a variadic tuple list of buttons") {
                    let actionTuple1: XYZAlertDisplayer.XYZAlertAction = ("Yep1", UIAlertActionStyle.cancel, { _ in })
                    let actionTuple2: XYZAlertDisplayer.XYZAlertAction = ("Yep2", UIAlertActionStyle.default, { _ in })

                    subject.displayActionSheet(withTitle: "1", andMessage: "2", sheetActions: actionTuple1, actionTuple2)

                    let alert = mockController.mocker.getParametersFor("presentViewController")?[0] as? UIAlertController

                    expect(alert?.title).to(equal("1"))
                    expect(alert?.message).to(equal("2"))
                    expect(alert?.actions.count).to(equal(2))
                    expect(alert?.actions.first?.title).to(equal("Yep1"))
                    expect(alert?.actions.last?.title).to(equal("Yep2"))
                }

                it("Accepts an array tuple list of buttons") {
                    let actionArray: [XYZAlertDisplayer.XYZAlertAction] = [("Yep1", UIAlertActionStyle.cancel, { _ in }),
                                                                           ("Yep2", UIAlertActionStyle.default, { _ in })]

                    subject.displayActionSheet(withTitle: "1", andMessage: "2", sheetActionList: actionArray)

                    let alert = mockController.mocker.getParametersFor("presentViewController")?[0] as? UIAlertController

                    expect(alert?.title).to(equal("1"))
                    expect(alert?.message).to(equal("2"))
                    expect(alert?.actions.count).to(equal(2))
                    expect(alert?.actions.first?.title).to(equal("Yep1"))
                    expect(alert?.actions.last?.title).to(equal("Yep2"))

                }

                it("Accepts an array tuple list of buttons on the specified ViewController") {
                    let actionArray: [XYZAlertDisplayer.XYZAlertAction] = [("Yep1", UIAlertActionStyle.cancel, { _ in }),
                                                                           ("Yep2", UIAlertActionStyle.default, { _ in })]
                    let anotherViewController = MockViewController()

                    subject.displayActionSheet(onViewController: anotherViewController, withTitle: "1",  andMessage: "2", sheetActionList: actionArray)

                    let alert = anotherViewController.mocker.getParametersFor("presentViewController")?[0] as? UIAlertController

                    expect(alert?.title).to(equal("1"))
                    expect(alert?.message).to(equal("2"))
                    expect(alert?.actions.count).to(equal(2))
                    expect(alert?.actions.first?.title).to(equal("Yep1"))
                    expect(alert?.actions.last?.title).to(equal("Yep2"))
                    
                }
            }
        }
    }
}
