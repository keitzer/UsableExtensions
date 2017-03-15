import UIKit

public protocol XYZErrorDisplayer {
    func displayError(_ title: String, message: String)
}

public extension XYZErrorDisplayer where Self: UIViewController {
    public func displayError(_ title: String, message: String) {
        XYZAlertDisplayer(viewController: self).displayStandardAlert(withTitle: title, andMessage: message)
    }
}

public protocol XYZAlertDisplayerFactoryContainer {
    var alertDisplayerFactory: XYZAlertDisplayer.XYZAlertDisplayerFactory { get set }
}


/// The purpose of this class is to provide a generic way to display UIAlertControllers in a testable way.
open class XYZAlertDisplayer {

    /// Typealias that represents a Displayer factory
    public typealias XYZAlertDisplayerFactory = (UIViewController) -> XYZAlertDisplayer

    /// Typealias that represents the components of a UIAlertAction
    public typealias XYZAlertAction = (title: String, style: UIAlertActionStyle, completion: ((UIAlertAction) -> Void)?)

    // MARK: - Type  methods

    /// Class factory method to create an alert displayer, useful for making classes testable
    open class func makeAlertDisplayer(parentViewController: UIViewController) -> XYZAlertDisplayer {
        return XYZAlertDisplayer(viewController: parentViewController)
    }

    // MARK: - Instance variables
    
    /// View Controller used to present the UIAlertController, can be set after init()
    open weak var viewController: UIViewController?

    // MARK: - Instance initialization

    public init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }

    // MARK: - Standard OK Alert

    /// Displays a UIAlertController with a single 'OK' action and the provided Title and Message
    open func displayStandardAlert(withTitle title: String?, andMessage message: String?, alertAction: ((UIAlertAction) -> Void)? = nil, presentCompletion: (() -> Void)? = nil) {
        self.displayStandardAlert(onViewController: viewController, withTitle: title, andMessage: message, alertAction: alertAction, presentCompletion: presentCompletion)
    }

    /// Displays a UIAlertController with a single 'OK' action and the provided Title and Message on the specified UIViewController
    open func displayStandardAlert(onViewController controller: UIViewController?, withTitle title: String?, andMessage message: String?, alertAction: ((UIAlertAction) -> Void)? = nil, presentCompletion: (() -> Void)? = nil) {
        let action: XYZAlertAction = ("OK", .cancel, alertAction)
        self.presentAlert(controller, title: title, message: message, actions: [action], presentCompletion: presentCompletion)
    }

    // MARK: - Generic Alert

    /// Displays a UIAlertController with specified actions and the provided Title and Message on the default UIViewController
    open func displayAlert(withTitle title: String?, andMessage message: String?, alertActions: XYZAlertAction..., presentCompletion: (() -> Void)? = nil) {
        presentAlert(viewController, title: title, message: message, actions: alertActions, presentCompletion: presentCompletion)
    }

    /// Displays a UIAlertController with specified actions and the provided Title and Message on the specified UIViewController
    open func displayAlert(onViewController controller: UIViewController?, withTitle title: String?, andMessage message: String?, alertActions: XYZAlertAction..., presentCompletion: (() -> Void)? = nil) {
        presentAlert(controller, title: title, message: message, actions: alertActions, presentCompletion: presentCompletion)
    }

    /// Displays a UIAlertController with specified action list and the provided Title and Message on the default UIViewController
    open func displayAlert(withTitle title: String?, andMessage message: String?, alertActionList: [XYZAlertAction], presentCompletion: (() -> Void)? = nil) {
        presentAlert(viewController, title: title, message: message, actions: alertActionList, presentCompletion: presentCompletion)
    }

    /// Displays a UIAlertController with specified action list and the provided Title and Message on the specified UIViewController
    open func displayAlert(onViewController controller: UIViewController?, withTitle title: String?, andMessage message: String?, alertActionList: [XYZAlertAction], presentCompletion: (() -> Void)? = nil) {
        presentAlert(controller, title: title, message: message, actions: alertActionList, presentCompletion: presentCompletion)
    }

    /// Displays a UIAlertController with specified UIAlertAction list and the provided Title and Message
    open func displayAlert(withTitle title: String?, andMessage message: String?, uiAlertActions: [UIAlertAction], presentCompletion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        uiAlertActions.forEach {
            alert.addAction($0)
        }

        getView(viewController)?.present(alert, animated: UIView.areAnimationsEnabled, completion: presentCompletion)
    }

    // MARK: - Alert Private Helper

    /// Private Helper: Used to handle the actual display and setup of the UIAlertController and Actions
    fileprivate func presentAlert(_ controller: UIViewController?, title: String?, message: String?, actions: [XYZAlertAction], presentCompletion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        actions.forEach {
            let action = UIAlertAction(title: $0.title, style: $0.style, handler: $0.completion)
            alert.addAction(action)
        }

        getView(controller)?.present(alert, animated: UIView.areAnimationsEnabled, completion: presentCompletion)
    }

    func getView(_ viewController: UIViewController?) -> UIViewController?  {
        if let presenting = viewController?.presentedViewController {
            return getView(presenting)
        }
        return viewController
    }

    // MARK: - Action Sheet Display

    /// Displays a UIAlertController action sheet with specified actions and the provided Message on the default UIViewController
    open func displayActionSheet(withTitle title: String?, andMessage message: String?, sheetActions: XYZAlertAction..., presentCompletion: (() -> Void)? = nil) {
        presentActionSheet(viewController, title: title, message: message, actions: sheetActions, presentCompletion: presentCompletion)
    }

    /// Displays a UIAlertController action sheet with specified actions and the provided Message on the specified UIViewController
    open func displayActionSheet(onViewController controller: UIViewController?, withTitle title: String?, andMessage message: String?, sheetActions: XYZAlertAction..., presentCompletion: (() -> Void)? = nil) {
        presentActionSheet(controller, title: title, message: message, actions: sheetActions, presentCompletion: presentCompletion)
    }

    /// Displays a UIAlertController action sheet with specified action list and the provided Message on the default UIViewController
    open func displayActionSheet(withTitle title: String?, andMessage message: String?, sheetActionList: [XYZAlertAction], presentCompletion: (() -> Void)? = nil) {
        presentActionSheet(viewController, title: title, message: message, actions: sheetActionList, presentCompletion: presentCompletion)
    }

    /// Displays a UIAlertController action sheet with specified action list and the provided Message on the specified UIViewController
    open func displayActionSheet(onViewController controller: UIViewController?, withTitle title: String?, andMessage message: String?, sheetActionList: [XYZAlertAction], presentCompletion: (() -> Void)? = nil) {
        presentActionSheet(controller, title: title, message: message, actions: sheetActionList, presentCompletion: presentCompletion)
    }

    // MARK: - Action Sheet Private Helper

    fileprivate func presentActionSheet(_ controller: UIViewController?, title: String?, message: String?, actions: [XYZAlertAction], presentCompletion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        actions.forEach {
            let action = UIAlertAction(title: $0.title, style: $0.style, handler: $0.completion)
            alert.addAction(action)
        }

        controller?.present(alert, animated: UIView.areAnimationsEnabled, completion: presentCompletion)
    }
}
