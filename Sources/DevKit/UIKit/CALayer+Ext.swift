import UIKit

extension CALayer {
    public func setShadow(opacity: Float, radius: CGFloat, offset: CGSize, color: UIColor? = nil, path: CGPath? = nil) {
        shadowOpacity = opacity
        shadowRadius = radius
        shadowOffset = offset
        shadowColor = color?.cgColor
        shadowPath = path
    }
}
