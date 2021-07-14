import Foundation

var isTesting: Bool {
    return CommandLine.arguments.contains("-dev-unit-testing")
}
