import Foundation

public struct DateFormat {
    public static let short = "MM/dd/yyyy"
    public static let medium = "MMM dd, YYYY"
    public static let iso8601 = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    public static let timeStampWithZone = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
}

public extension String {
    public var isTruthy: Bool {
        if ["T", "TRUE", "Y", "YES", "ON"].contains(self.uppercased()) { return true }
        if let val = Int(self)?.isTruthy, val { return true }
        return false
    }
    
    public var isBlank: Bool {
        return self.trim().isEmpty
    }
    
    public func toCurrency() -> String {
        return NSString(string: self).doubleValue.toCurrency()
    }

    public func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    public func toDate(withFormat format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.date(from: self)
    }
    
    public func lastIndex(ofCharacter string: String) -> Int? {
        guard let range: Range<Index> = self.range(of: string, options: .backwards) else { return nil }
        
        return self.characters.distance(from: self.startIndex, to: range.lowerBound)
    }
    
    public func substringFromLastIndex(ofCharacter string: String) -> String {
        guard let index = lastIndex(ofCharacter: string) else { return self }
        
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: index+1))
    }
    
    public func substringToLastIndex(ofCharacter string: String) -> String {
        guard let index = lastIndex(ofCharacter: string) else { return self }
        
        return self.substring(to: self.characters.index(self.startIndex, offsetBy: index))
    }

    public func slice(from start: String, to: String) -> String? {
        return (range(of: start)?.upperBound).flatMap { sInd in
            (range(of: to, range: sInd..<endIndex)?.lowerBound).map { eInd in
                substring(with: sInd..<eInd)
            }
        }
    }
}
