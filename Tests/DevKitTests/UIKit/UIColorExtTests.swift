import DevKit
import XCTest

final class UIColorExtTests: XCTestCase {
    func testHexToColor() {
        let red = UIColor.hex("F00\n")
        let green = UIColor.hex("#00FF00 ")
        let blue = UIColor.hex("*& 0000FFFF#")
        let yellow = UIColor.hex("\n FF0F ")
        XCTAssertEqual(red, .red)
        XCTAssertEqual(green, .green)
        XCTAssertEqual(blue, .blue)
        XCTAssertEqual(yellow, .yellow)
    }

    func testHexToColorFallback() {
        let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        XCTAssertEqual(UIColor.hex("FF000"), black)
    }

    func testUInt8ToColor() {
        let yellow = UIColor.uint8(r: .max, g: .max, b: .zero, a: .max)
        XCTAssertEqual(yellow, .yellow)
    }

    func testColorToHexString() {
        XCTAssertEqual(UIColor.red.toHexString(system: .sixDigit).uppercased(), "#FF0000")
        XCTAssertEqual(UIColor.green.toHexString(system: .eightDigit).uppercased(), "#00FF00FF")
    }

    @available(iOS 10.0, *)
    func testToImage() {
        let image = UIColor.red.toImage(size: CGSize(width: 20, height: 10))
        let imageColor = image.getPixelColor(at: CGPoint(x: 10, y: 5))
        XCTAssertEqual(image.size.width, 20)
        XCTAssertEqual(image.size.height, 10)
        XCTAssertEqual(imageColor, .red)
    }
}
