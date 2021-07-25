import UIKit

extension UIStackView {
    public convenience init(
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat,
        distribution: UIStackView.Distribution,
        alignment: UIStackView.Alignment
    ) {
        self.init()
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
    }

    public func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach(addArrangedSubview)
    }

    public func clearArrangedSubviews() {
        arrangedSubviews.forEach(removeArrangedSubview)
    }
}
