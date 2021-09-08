import UIKit

open class HighlightButton: UIButton {
    open override var isHighlighted: Bool { didSet {
        isHighlighted ? becomeHighlighted() : resignHighlighted()
    }}

    open var highlightedColor: UIColor?

    open var normalColor: UIColor?

    open var animationDuration: TimeInterval = 0.3

    public private(set) lazy var animator = UIViewPropertyAnimator()

    public convenience init(highlightedColor: UIColor?, normalColor: UIColor?) {
        self.init(frame: .zero)

        self.highlightedColor = highlightedColor
        self.normalColor = normalColor
    }

    open func becomeHighlighted() {
        animator.stopAnimation(true)
        backgroundColor = highlightedColor
    }

    open func resignHighlighted() {
        animator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeOut, animations: {
            self.backgroundColor = self.normalColor
        })
        animator.startAnimation()
    }
}
