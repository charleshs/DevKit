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

    @available(iOS 11.0, tvOS 11.0, *)
    public func addArrangedSubview(_ subview: UIView, spacingPrev: CGFloat? = nil, spacingNext: CGFloat? = nil) {
        if let previousView = arrangedSubviews.last, let spacingPrev = spacingPrev {
            setCustomSpacing(spacingPrev, after: previousView)
        }
        addArrangedSubview(subview)
        spacingNext.map { spacing in
            setCustomSpacing(spacing, after: subview)
        }
    }

    @available(iOS 11.0, tvOS 11.0, *)
    public func insertArrangedSubview(_ subview: UIView, at index: Int, spacingPrev: CGFloat? = nil, spacingNext: CGFloat? = nil) {
        insertArrangedSubview(subview, at: index)
        if index > 0, let spacingPrev = spacingPrev {
            setCustomSpacing(spacingPrev, after: arrangedSubviews[index - 1])
        }
        spacingNext.map { spacing in
            setCustomSpacing(spacing, after: subview)
        }
    }

    @available(iOS 11.0, tvOS 11.0, *)
    public func insertArrangedSubview(_ subview: UIView, before existingView: UIView, spacingPrev: CGFloat?, spacingNext: CGFloat?) {
        guard let index = getInsertionPosition(insertingView: subview, exisitingView: existingView) else { return }

        insertArrangedSubview(subview, at: index)
        spacingNext.map { spacing in
            setCustomSpacing(spacing, after: subview)
        }
        if index > 0, let spacingPrev = spacingPrev {
            setCustomSpacing(spacingPrev, after: arrangedSubviews[index - 1])
        }
    }

    @available(iOS 11.0, tvOS 11.0, *)
    public func insertArrangedSubview(_ subview: UIView, after existingView: UIView, spacingPrev: CGFloat?, spacingNext: CGFloat?) {
        guard let index = getInsertionPosition(insertingView: subview, exisitingView: existingView) else { return }

        insertArrangedSubview(subview, at: index.advanced(by: 1))
        spacingPrev.map { spacing in
            setCustomSpacing(spacing, after: existingView)
        }
        spacingNext.map { spacing in
            setCustomSpacing(spacing, after: subview)
        }
    }

    @available(iOS 11.0, tvOS 11.0, *)
    public func replaceArrangedSubview(_ oldView: UIView, with newView: UIView) {
        guard let indexToInsert = arrangedSubviews.firstIndex(of: oldView) else { return }

        let spacingNext = customSpacing(after: oldView)
        removeArrangedSubview(oldView)
        insertArrangedSubview(newView, at: indexToInsert)
        setCustomSpacing(spacingNext, after: newView)
    }

    private func getInsertionPosition(insertingView: UIView, exisitingView: UIView) -> Int? {
        guard checkIfInsertable(insertingView: insertingView, existingView: exisitingView) else { return nil }

        removeArrangedSubview(insertingView)
        return arrangedSubviews.firstIndex(of: exisitingView)!
    }

    private func checkIfInsertable(insertingView: UIView, existingView: UIView) -> Bool {
        return insertingView !== existingView && arrangedSubviewsSet.contains(existingView)
    }

    private var arrangedSubviewsSet: Set<UIView> {
        return Set(arrangedSubviews)
    }
}
