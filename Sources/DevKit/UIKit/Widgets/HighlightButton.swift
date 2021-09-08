import UIKit

open class HighlightButton: UIButton {
    open override var isHighlighted: Bool { didSet {
        isHighlighted ? becomeHighlighted() : resignHighlighted()
    }}

    open var highlightedColor: UIColor?

    open var normalColor: UIColor?

    public private(set) lazy var animator = UIViewPropertyAnimator()

    public convenience init(highlightedColor: UIColor?, normalColor: UIColor?) {
        self.init(frame: .zero)

        self.highlightedColor = highlightedColor
        self.normalColor = normalColor
    }

    open func becomeHighlighted() {
        animator.stopAnimation(true)
        animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeIn, animations: {
            self.backgroundColor = self.highlightedColor
        })
        animator.startAnimation()
    }

    open func resignHighlighted() {
        animator = UIViewPropertyAnimator(duration: 0.4, curve: .easeOut, animations: {
            self.backgroundColor = self.normalColor
        })
        animator.startAnimation()
    }
}
