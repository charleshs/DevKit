import UIKit

extension UIColor {
    private struct RGBA {
        let r, g, b, a: UInt64

        var uiColor: UIColor {
            return UIColor(red: float(r) , green: float(g), blue: float(b), alpha: float(a))
        }

        private func float(_ val: UInt64) -> CGFloat { CGFloat(val) / 255 }
    }

    public static func hex(_ hex: String) -> UIColor {
        let set = CharacterSet.alphanumerics.inverted.union(.whitespacesAndNewlines)
        let hex = hex.trimmingCharacters(in: set)

        var i: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&i)

        let max: UInt64 = 255
        switch hex.count {
        case 3:
            // RGB, e.g. FC0 == FFCC00
            return RGBA(r: (i >> 8) * 17, g: (i >> 4 & 0xF) * 17, b: (i & 0xF) * 17, a: max).uiColor
        case 4:
            // RGBA, e.g. FC0A == FFCC00AA
            return RGBA(r: (i >> 12) * 17, g: (i >> 8 & 0xF) * 17, b: (i >> 4 & 0xF) * 17, a: i & 0xF * 17).uiColor
        case 6:
            // RRGGBB
            return RGBA(r: i >> 16, g: i >> 8 & 0xFF, b: i & 0xFF, a: max).uiColor
        case 8:
            // RRGGBBAA
            return RGBA(r: i >> 24, g: i >> 16 & 0xFF, b: i >> 8 & 0xFF, a: i & 0xFF).uiColor
        default:
            if !isTesting {
                assertionFailure("Invalid hex code is used. Fallback as color black.")
            }
            return RGBA(r: 0, g: 0, b: 0, a: max).uiColor
        }
    }

    public static func uint8(r: UInt8, g: UInt8, b: UInt8, a: UInt8) -> UIColor {
        return RGBA(r: UInt64(r), g: UInt64(g), b: UInt64(b), a: UInt64(a)).uiColor
    }
}

extension UIColor {
    public func toHexString(system: HexCodeSystem = .sixDigit) -> String {
        var r = CGFloat.zero
        var g = CGFloat.zero
        var b = CGFloat.zero
        var a = CGFloat.zero
        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgba = Int(r.rounded() * 255) << 24
                 | Int(g.rounded() * 255) << 16
                 | Int(b.rounded() * 255) << 8
                 | Int(a.rounded() * 255)

        switch system {
        case .sixDigit:
            let rgb = rgba >> 8
            return String(format: "#%06x", rgb)
        case .eightDigit:
            return String(format: "#%08x", rgba)
        }
    }

    public enum HexCodeSystem {
        case sixDigit
        case eightDigit
    }
}

extension UIColor {
    public func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return toImage(width: size.width, height: size.height)
    }

    public func toImage(width: CGFloat = 1, height: CGFloat = 1) -> UIImage {
        let size = CGSize(width: width, height: height)
        return UIGraphicsImageRenderer(size: size).image { ctx in
            setFill()
            ctx.fill(CGRect(origin: .zero, size: size))
        }
    }
}
