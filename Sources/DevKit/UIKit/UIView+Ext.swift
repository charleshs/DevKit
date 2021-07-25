import UIKit

extension UIView {
    public var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            guard let viewController = parentResponder as? UIViewController else {
                parentResponder = responder.next
                continue
            }

            return viewController
        }
        return nil
    }

    public func dropShadow(opacity: Float, radius: CGFloat, offset: CGSize, color: UIColor? = nil, path: CGPath? = nil) {
        layer.masksToBounds = false
        layer.setShadow(opacity: opacity, radius: radius, offset: offset, color: color, path: path)
    }
}

extension UIView {
    public func getSubviews<T: UIView>(ofType: T.Type = T.self) -> [T] {
        var matched: [T] = []

        for subview in subviews {
            matched += subview.getSubviews(ofType: T.self)

            if let view = subview as? T {
                matched.append(view)
            }
        }

        return matched
    }

    public func findSubviews(withClassName className: String) -> [UIView] {
        findSubviews { view in
            "\(String(describing: type(of: view)))" == className
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

    public func demolishHierarchy() {
        for subview in subviews {
            subview.demolishHierarchy()
            subview.removeFromSuperview()
        }
    }
}
