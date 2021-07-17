import UIKit

open class GradientView: UIView {
    public enum Direction {
        case vertical(start: CGFloat, end: CGFloat)
        case horizontal(start: CGFloat, end: CGFloat)
    }

    open override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    public var gradientLayer: CAGradientLayer? {
        return layer as? CAGradientLayer
    }

    open func drawGradient(direction: Direction) {
        switch direction {
        case .vertical(let start, let end):
            setStartPoint(CGPoint(x: 0.5, y: start))
            setEndPoint(CGPoint(x: 0.5, y: end))
        case .horizontal(let start, let end):
            setStartPoint(CGPoint(x: start, y: 0.5))
            setEndPoint(CGPoint(x: end, y: 0.5))
        }
    }

    open func setColors(_ colors: [UIColor]) {
        gradientLayer?.colors = colors.map(\.cgColor)
    }

    open func setStartPoint(_ point: CGPoint) {
        gradientLayer?.startPoint = point
    }

    open func setEndPoint(_ point: CGPoint) {
        gradientLayer?.endPoint = point
    }

    open func setLocations(_ locations: [NSNumber]) {
        gradientLayer?.locations = locations
    }
}
