import UIKit

extension UIImage {
    public func getPixelColor(at position: CGPoint) -> UIColor? {
        guard let imageData = pngData(),
              let normalizedImage = UIImage(data: imageData),
              let pixelData = normalizedImage.cgImage?.dataProvider?.data else {
            return nil
        }

        func scale(_ int: UInt8) -> CGFloat { CGFloat(int) / 255 }

        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = (Int(size.width) * Int(position.y) + Int(position.x)) * 4

        let r, g, b, a: UInt8
        (r, g, b, a) = (data[pixelInfo], data[pixelInfo + 1], data[pixelInfo + 2], data[pixelInfo + 3])

        return UIColor(red: scale(r), green: scale(g), blue: scale(b), alpha: scale(a))
    }
}
