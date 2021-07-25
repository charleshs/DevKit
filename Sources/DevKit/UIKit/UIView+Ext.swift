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

    public func clearSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
}
