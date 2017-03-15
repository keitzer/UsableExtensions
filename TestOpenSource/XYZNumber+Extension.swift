import Foundation


// MARK: - ==

 func ==<T: NSNumber>(left: T, right: T) -> Bool {
    var thing = left.decimalValue
    var thing2 = right.decimalValue
    return NSDecimalCompare(&thing, &thing2) == .orderedSame
}

 func ==(left: NSNumber, right: UInt)   -> Bool { return left == (right as NSNumber) }
 func ==(left: NSNumber, right: Int)    -> Bool { return left == (right as NSNumber) }
 func ==(left: NSNumber, right: UInt32) -> Bool { return left == (NSNumber(value: right as UInt32)) }
 func ==(left: NSNumber, right: UInt64) -> Bool { return left == (NSNumber(value: right as UInt64)) }
 func ==(left: NSNumber, right: Int32)  -> Bool { return left == (NSNumber(value: right as Int32)) }
 func ==(left: NSNumber, right: Int64)  -> Bool { return left == (NSNumber(value: right as Int64)) }


// MARK: - <

 func <<T: NSNumber>(left: T, right: T) -> Bool {
    var thing = left.decimalValue
    var thing2 = right.decimalValue
    return NSDecimalCompare(&thing, &thing2) == .orderedAscending
}

 func <(left: NSNumber, right: UInt)   -> Bool { return left < (right as NSNumber) }
 func <(left: NSNumber, right: Int)    -> Bool { return left < (right as NSNumber) }
 func <(left: NSNumber, right: UInt32) -> Bool { return left < (NSNumber(value: right as UInt32)) }
 func <(left: NSNumber, right: UInt64) -> Bool { return left < (NSNumber(value: right as UInt64)) }
 func <(left: NSNumber, right: Int32)  -> Bool { return left < (NSNumber(value: right as Int32)) }
 func <(left: NSNumber, right: Int64)  -> Bool { return left < (NSNumber(value: right as Int64)) }


// MARK: - >

 func ><T: NSNumber>(left: T, right: T) -> Bool {
    var thing = left.decimalValue
    var thing2 = right.decimalValue
    return NSDecimalCompare(&thing, &thing2) == .orderedDescending
}

 func >(left: NSNumber, right: UInt)   -> Bool { return left > (right as NSNumber) }
 func >(left: NSNumber, right: Int)    -> Bool { return left > (right as NSNumber) }
 func >(left: NSNumber, right: UInt32) -> Bool { return left > (NSNumber(value: right as UInt32)) }
 func >(left: NSNumber, right: UInt64) -> Bool { return left > (NSNumber(value: right as UInt64)) }
 func >(left: NSNumber, right: Int32)  -> Bool { return left > (NSNumber(value: right as Int32)) }
 func >(left: NSNumber, right: Int64)  -> Bool { return left > (NSNumber(value: right as Int64)) }


// MARK: - <=

 func <=<T: NSNumber>(left: T, right: T) -> Bool {
    var thing = left.decimalValue
    var thing2 = right.decimalValue
    return NSDecimalCompare(&thing, &thing2) != .orderedDescending
}

 func <=(left: NSNumber, right: UInt)   -> Bool { return left <= (right as NSNumber) }
 func <=(left: NSNumber, right: Int)    -> Bool { return left <= (right as NSNumber) }
 func <=(left: NSNumber, right: UInt32) -> Bool { return left <= (NSNumber(value: right as UInt32)) }
 func <=(left: NSNumber, right: UInt64) -> Bool { return left <= (NSNumber(value: right as UInt64)) }
 func <=(left: NSNumber, right: Int32)  -> Bool { return left <= (NSNumber(value: right as Int32)) }
 func <=(left: NSNumber, right: Int64)  -> Bool { return left <= (NSNumber(value: right as Int64)) }


// MARK: - >=

 func >=<T: NSNumber>(left: T, right: T) -> Bool {
    var thing = left.decimalValue
    var thing2 = right.decimalValue
    return NSDecimalCompare(&thing, &thing2) != .orderedAscending
}

 func >=(left: NSNumber, right: UInt)   -> Bool { return left >= (right as NSNumber) }
 func >=(left: NSNumber, right: Int)    -> Bool { return left >= (right as NSNumber) }
 func >=(left: NSNumber, right: UInt32) -> Bool { return left >= (NSNumber(value: right as UInt32)) }
 func >=(left: NSNumber, right: UInt64) -> Bool { return left >= (NSNumber(value: right as UInt64)) }
 func >=(left: NSNumber, right: Int32)  -> Bool { return left >= (NSNumber(value: right as Int32)) }
 func >=(left: NSNumber, right: Int64)  -> Bool { return left >= (NSNumber(value: right as Int64)) }
