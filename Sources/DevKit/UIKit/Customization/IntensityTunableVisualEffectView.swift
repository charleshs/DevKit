import UIKit

/// Reference: https://gist.github.com/darrarski/29a2a4515508e385c90b3ffe6f975df7
open class IntensityTunableVisualEffectView: UIVisualEffectView {

    /// Creates visual effect view with given effect and its intensity
    /// - Parameters:
    ///   - effect: The visual effect for the view, e.g. UIBlurEffect(style: .dark).
    ///   - intensity: A custom intensity from 0.0 (no effect) to 1.0 (full effect) using linear scale.
    public init(effect: UIVisualEffect, intensity: CGFloat) {
        theEffect = effect
        customIntensity = intensity
        super.init(effect: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        return nil
    }

    deinit {
        animator?.stopAnimation(true)
    }

    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        effect = nil
        animator?.stopAnimation(true)
        animator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [unowned self] in
            self.effect = theEffect
        }
        animator?.fractionComplete = customIntensity
    }

    private let theEffect: UIVisualEffect
    private let customIntensity: CGFloat
    private var animator: UIViewPropertyAnimator?
}
