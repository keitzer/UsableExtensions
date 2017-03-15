import Foundation

public extension Date {
    public var greeting: String {
        let cal = Calendar.current
        switch cal.component(.hour, from: self) {
        case 0..<12: return "morning"
        case 12..<17: return "afternoon"
        default: return "evening"
        }
    }

    public func add(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }

    public func add(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }

    public func toString(withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    public func numberOfDays(untilDate futureDate: Date) -> Int {
        let calendar = Calendar.current
        let from = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: self)
        let to = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: futureDate)
        
        return calendar.dateComponents([.day], from: from!, to: to!).day!
    }
}
