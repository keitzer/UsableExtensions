import Foundation
import UIKit

public protocol XYZMappable {
    init?(mapper: XYZMapper)
}

public enum XYZMapperError: Error {
    case stringCoerceError(String)
    case intCoerceError(String)
    case uIntCoerceError(String)
    case int32CoerceError(String)
    case int64CoerceError(String)
    case doubleCoerceError(String)
    case floatCoerceError(String)
    case boolCoerceError(String)
    case dataCoerceError(String)
    case dateCoerceError(String)
    case dictionaryCoerceError(String)
    case arrayCoerceError(String)
    case colorCoerceError(String)
    case nsErrorCoerceError(String)
    case typeCoerceError(String)
}

public extension Dictionary {
    /// Returns an XYZMapper with the current dictionary data
    public var mapper: XYZMapper {
        return XYZMapper(data: self)
    }
}

/// The purpose of XYZMapper is the coerce an object to another type
open class XYZMapper {
    open var value: Any?
    fileprivate var valueObject: AnyObject? {
        return value as AnyObject
    }

    fileprivate var valueDict: [AnyHashable:Any]? {
        return value as? [AnyHashable:Any]
    }

    public init(data: Any?) {
        self.value = data
    }

    // MARK: - Subscripts

    open subscript(key: String) -> XYZMapper {
        if value is Array<AnyObject> {
            return XYZMapper(data: nil)
        }
        return XYZMapper(data: valueDict?[key] ?? nil)
    }

    open subscript(key: Int) -> XYZMapper {
        return XYZMapper(data: valueDict?[key])
    }

    open subscript(key: Double) -> XYZMapper {
        return XYZMapper(data: valueDict?[key])
    }
}

// MARK: - Optional Typed Values
extension XYZMapper {

    /// Attempts to coerce value to String
    public var string: String? {
        if let v = value as? Data { return String(data: v, encoding: String.Encoding.utf8) }
        if let v = value { return "\(v)" }
        return value as? String
    }

    /// Attempts to coerce value to Int
    public var int: Int?  {
        if let v = value as? NSNumber, v >  Int.max { return nil }
        if let v = value as? NSNumber, v <= Int.max { return v.intValue }
        if let v = value as? String {
            if let integer = Int(v) { return integer }
            if let integer = Double(v) { return Int(integer) }
            if let integer = Float(v) { return Int(integer) }
        }
        return value as? Int
    }

    /// Attempts to coerce value to UInt
    public var uInt: UInt? {
        if let v = value as? NSNumber, v >  UInt.max || v <  0 { return nil }
        if let v = value as? NSNumber, v <= UInt.max && v >= 0 { return v.uintValue }
        if let v = value as? String { return UInt(v) }
        return value as? UInt
    }

    /// Attempts to coerce value to Int32
    public var int32: Int32? {
        if let v = value as? NSNumber, v >  Int32.max { return nil }
        if let v = value as? NSNumber, v <= Int32.max { return v.int32Value }
        if let v = value as? String { return Int32(v) }
        return value as? Int32
    }

    /// Attempts to coerce value to Int64
    public var int64: Int64? {
        if let v = value as? NSNumber, v >  Int64.max { return nil }
        if let v = value as? NSNumber, v <= Int64.max { return v.int64Value }
        if let v = value as? String { return Int64(v) }
        return value as? Int64
    }

    /// Attempts to coerce value to Double
    public var double: Double? {
        if let v = value as? String { return Double(v) }
        if let v = value as? Int { return Double(v) }
        return value as? Double
    }

    /// Attempts to coerce value to Float
    public var float: Float? {
        if let v = value as? String { return Float(v) }
        if let v = value as? Double { return Float(v) }
        if let v = value as? Int { return Float(v) }
        return value as? Float
    }

    /// Attempts to coerce value to Bool
    public var bool: Bool? {
        if let v = value as? String { return v.isTruthy }
        if let v = value as? Int { return v.isTruthy }
        return value as? Bool
    }

    /// Attempts to coerce value to Data
    public var data: Data? {
        if let v = value as? String { return v.data(using: String.Encoding.utf8) }
        return value as? Data
    }

    /// Attempts to coerce value to NSDate
    public var date: Date? {
        if let v = value as? String {
            if let date = getDate(from: v, withStyle: .full) { return date }
            if let date = getDate(from: v, withStyle: .long) { return date }
            if let date = getDate(from: v, withStyle: .short) { return date }
            if let date = getDate(from: v, withStyle: .medium) { return date }
            if let date = getDate(from: v, withStyle: .none) { return date }

            if let date = v.toDate(withFormat: DateFormat.short) { return date }
            if let date = v.toDate(withFormat: DateFormat.medium) { return date }
            if let date = v.toDate(withFormat: DateFormat.iso8601) { return date }
            if let date = v.toDate(withFormat: DateFormat.timeStampWithZone) { return date }
        }
        return value as? Date
    }

    /// Attempts to coerce value to NSDate given the specified format (Default = DateFormat.short)
    public func date(withFormat format: String = DateFormat.short) -> Date? {
        return dateString(withFormat: format)?.toDate(withFormat: format)
    }

    /// Attempts to coerce value to NSDate in the form of a String given the specified format (Default = DateFormat.short)
    public func dateString(withFormat format: String = DateFormat.short) -> String? {

        if let dateUsingProvidedFormat = (value as? Date)?.toString(withFormat: format) ?? (value as? String)?.toDate(withFormat: format)?.toString(withFormat: format) {
            return dateUsingProvidedFormat
        }

        if let date = self.date {
            return date.toString(withFormat: format)
        }

        return nil
    }

    fileprivate func getDate(from str: String, withStyle style: DateFormatter.Style) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.date(from: str)
    }

    /// Attempts to coerce value to [AnyHashable: Any]
    public var dictionary: [AnyHashable: Any]? {
        return value as? [AnyHashable: Any]
    }

    /// Attempts to coerce value to [Any]
    public var array: [Any]? {
        return value as? [Any]
    }

    /// Attempts to coerce value to UIColor
    public var color: UIColor? {
        if let v = value as? String { return UIColor(withHex: v) }
        return value as? UIColor
    }

    /// Attempts to coerce value to NSError
    public var error: NSError? {
        return value as? NSError
    }

    /// Attempts to coerce value to specified type
    public func type<T>() -> T? {
        return value as? T
    }
}

// MARK: - Throwable Non-Optional Typed Values
extension XYZMapper {
    /// Attempts to coerce value to String, otherwise throw XYZMapperError.StringCoerceError
    public func mapString() throws -> String {
        if let v = self.string { return v }
        throw XYZMapperError.stringCoerceError("Failed to convert value to type String")
    }

    /// Attempts to coerce value to Int, otherwise throw XYZMapperError.IntCoerceError
    public func mapInt() throws -> Int {
        if let v = self.int { return v }
        throw XYZMapperError.intCoerceError("Failed to convert value to type Int")
    }

    /// Attempts to coerce value to UInt, otherwise throw XYZMapperError.UIntCoerceError
    public func mapUInt() throws -> UInt {
        if let v = self.uInt { return v }
        throw XYZMapperError.uIntCoerceError("Failed to convert value to type UInt")
    }

    /// Attempts to coerce value to Int32, otherwise throw XYZMapperError.Int32CoerceError
    public func mapInt32() throws -> Int32 {
        if let v = self.int32 { return v }
        throw XYZMapperError.int32CoerceError("Failed to convert value to type Int32")
    }

    /// Attempts to coerce value to Int64, otherwise throw XYZMapperError.Int64CoerceError
    public func mapInt64() throws -> Int64 {
        if let v = self.int64 { return v }
        throw XYZMapperError.int64CoerceError("Failed to convert value to type Int64")
    }

    /// Attempts to coerce value to Double, otherwise throw XYZMapperError.DoubleCoerceError
    public func mapDouble() throws -> Double {
        if let v = self.double { return v }
        throw XYZMapperError.doubleCoerceError("Failed to convert value to type Double")
    }

    /// Attempts to coerce value to Float, otherwise throw XYZMapperError.FloatCoerceError
    public func mapFloat() throws -> Float {
        if let v = self.float { return v }
        throw XYZMapperError.floatCoerceError("Failed to convert value to type Float")
    }

    /// Attempts to coerce value to Bool, otherwise throw XYZMapperError.BoolCoerceError
    public func mapBool() throws -> Bool {
        if let v = self.bool { return v }
        throw XYZMapperError.boolCoerceError("Failed to convert value to type Bool")
    }

    /// Attempts to coerce value to Data, otherwise throw XYZMapperError.DataCoerceError
    public func mapData() throws -> Data {
        if let v = self.data { return v }
        throw XYZMapperError.dataCoerceError("Failed to convert value to type Data")
    }

    /// Attempts to coerce value to NSDate, otherwise throw XYZMapperError.DateCoerceError
    public func mapDate() throws -> Date {
        if let v = self.date { return v }
        throw XYZMapperError.dateCoerceError("Failed to convert value to type Date")
    }

    /// Attempts to coerce value to [AnyHashable: Any], otherwise throw XYZMapperError.DictionaryCoerceError
    public func mapDictionary() throws -> [AnyHashable: Any] {
        if let v = self.dictionary { return v }
        throw XYZMapperError.dictionaryCoerceError("Failed to convert value to type Dictionary")
    }

    /// Attempts to coerce value to [Any], otherwise throw XYZMapperError.ArrayCoerceError
    public func mapArray() throws -> [Any] {
        if let v = self.array { return v }
        throw XYZMapperError.arrayCoerceError("Failed to convert value to type Array")
    }

    /// Attempts to coerce value to UIColor, otherwise throw XYZMapperError.ColorCoerceError
    public func mapColor() throws -> UIColor {
        if let v = self.color { return v }
        throw XYZMapperError.colorCoerceError("Failed to convert value to type UIColor")
    }

    /// Attempts to coerce value to NSError, otherwise throw XYZMapperError.NSErrorCoerceError
    public func mapError() throws -> NSError {
        if let v = self.error { return v }
        throw XYZMapperError.nsErrorCoerceError("Failed to convert value to type NSError")
    }

    /// Attempts to coerce value to specified type, otherwise throw XYZMapperError.TypeCoerceError
    public func mapType<T>() throws -> T {
        if let v: T = self.type() { return v }
        throw XYZMapperError.typeCoerceError("Failed to convert value to type \(T.self)")
    }
}

// MARK: - Mappables
extension XYZMapper {
    /// Creates an XYZMapper from the specified data and instantiates the given Mappable Object Type
    public class func map<T: XYZMappable>(withData data: AnyObject?) -> T? {
        return T(mapper: XYZMapper(data: data))
    }

    /// Uses self and instantiates the given Mappable Object Type
    public func map<T: XYZMappable>() -> T? {
        return T(mapper: self)
    }
}
