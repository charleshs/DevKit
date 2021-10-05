import UIKit

extension UIImage {
    public func getPixelColor(at position: CGPoint) -> UIColor? {
        guard position.x < size.width,
              position.y < size.height,
              let imageData = pngData(),
              let normalizedImage = UIImage(data: imageData),
              let pixelData = normalizedImage.cgImage?.dataProvider?.data
        else { return nil }

        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = (Int(size.width) * Int(position.y) + Int(position.x)) * 4

        let r, g, b, a: UInt8
        (r, g, b, a) = (data[pixelInfo], data[pixelInfo + 1], data[pixelInfo + 2], data[pixelInfo + 3])

        return UIColor(red: float(r), green: float(g), blue: float(b), alpha: float(a))
    }

    private func float(_ val: UInt8) -> CGFloat {
        CGFloat(val) / 255
    }
}
