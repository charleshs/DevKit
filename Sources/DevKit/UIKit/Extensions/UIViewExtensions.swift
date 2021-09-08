import UIKit

// MARK: - Search
extension UIView {
    public var parentViewController: UIViewController? {
        return responder(ofType: UIViewController.self)
    }

    public func responder<T>(ofType: T.Type = T.self) -> T? {
        weak var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            guard let responderFound = responder as? T else {
                parentResponder = responder.next
                continue
            }
            return responderFound
        }
        return nil
    }

    public func findSubviews<T: UIView>(ofType: T.Type = T.self) -> [T] {
        var matched: [T] = []

        for subview in subviews {
            matched += subview.findSubviews(ofType: T.self)

            if let view = subview as? T {
                matched.append(view)
            }
        }

        return matched
    }

    public func findSubviews(withClassName className: String) -> [UIView] {
        findSubviews { view in
            "\(type(of: view))" == className
        }
    }

    public func findSubviews(where predicate: (UIView) -> Bool) -> [UIView] {
        var matched: [UIView] = []

        for subview in subviews {
            matched += subview.findSubviews(where: predicate)

            if predicate(subview) {
                matched.append(subview)
            }
        }

        return matched
    }

    /**
     Attempt to find the view in a current view hierarchy that is currently the first responder.
     */
    public func findSubviewBeingFirstResponder() -> UIView? {
        if subviews.count == 0 {
            return nil
        }

        for subview in subviews {
            if subview.isFirstResponder {
                return subview
            }
            return subview.findSubviewBeingFirstResponder()
        }

        return nil
    }
}

extension UIView {
    public func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }

    public func demolishHierarchy() {
        for subview in subviews {
            subview.demolishHierarchy()
            subview.removeFromSuperview()
        }
    }

    @objc public func clone() -> Self {
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! Self
    }
}
