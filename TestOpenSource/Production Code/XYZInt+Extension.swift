import Foundation

extension Int {
    public var isTruthy: Bool {
        return self > 0
    }

    public func toDecimal() -> String {
        return toDecimalOptionally() ?? "0"
    }

    public func toDecimalOptionally() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: NSNumber(value: self))
    }
}
