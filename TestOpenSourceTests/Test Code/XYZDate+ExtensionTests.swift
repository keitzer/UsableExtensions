import Nimble
import Quick
@testable import TestOpenSource

class XYZDateExtensionTests: QuickSpec {
    override func spec() {
        describe("Date") {

            describe("greeting") {
                it("should return morning for time of day 11:59 am") {
                    let t1200a = Date(timeIntervalSince1970: 18000)
                    let t1159a = Date(timeIntervalSince1970: 61150)

                    let result1 = t1200a.greeting
                    let result2 = t1159a.greeting

                    expect(result1).to(equal("morning"))
                    expect(result2).to(equal("morning"))
                }

                it("should return afternoon for time of day 4:59 pm") {
                    let t1200p = Date(timeIntervalSince1970: 61200)
                    let t459p = Date(timeIntervalSince1970: 79150)

                    let result1 = t1200p.greeting
                    let result2 = t459p.greeting

                    expect(result1).to(equal("afternoon"))
                    expect(result2).to(equal("afternoon"))
                }

                it("should return evening for time of day 11:59 pm") {
                    let t500p = Date(timeIntervalSince1970: 79200)
                    let t1159p = Date(timeIntervalSince1970: 17950)

                    let result1 = t500p.greeting
                    let result2 = t1159p.greeting
                    
                    expect(result1).to(equal("evening"))
                    expect(result2).to(equal("evening"))
                }
            }
            
            describe("add days") {
                
                it("should return tomorrow's date given day count of 1") {
                    let date = Date(timeIntervalSince1970: 18000)
                    
                    let testDate1 = date.toString(withFormat: DateFormat.short)
                    
                    expect(testDate1).to(equal("01/01/1970"))
                    
                    let result = date.add(days: 1).toString(withFormat: DateFormat.short)
                    
                    expect(result).to(equal("01/02/1970"))
                }
                
                it("should return 02/16/1970 given day count of 46") {
                    let date = Date(timeIntervalSince1970: 18000)
                    
                    let testDate1 = date.toString(withFormat: DateFormat.short)
                    
                    expect(testDate1).to(equal("01/01/1970"))
                    
                    let result = date.add(days: 46).toString(withFormat: DateFormat.short)
                    
                    expect(result).to(equal("02/16/1970"))
                }
            }
            
            describe("add hours") {
                it("should return 2 AM given hour count of 2") {
                    let date = Date(timeIntervalSince1970: 18000)
                    
                    let testDate1 = date.toString(withFormat: DateFormat.timeStampWithZone)
                    
                    expect(testDate1).to(equal("1970-01-01T00:00:00.000-05:00"))
                    
                    let testDate2 = date.add(hours: 2).toString(withFormat: DateFormat.timeStampWithZone)
                    
                    expect(testDate2).to(equal("1970-01-01T02:00:00.000-05:00"))
                }
            }

            describe("format to string") {
                it("should return 01/01/1970") {
                    let date = Date(timeIntervalSince1970: 18000)

                    let result = date.toString(withFormat: DateFormat.short)

                    expect(result).to(equal("01/01/1970"))
                }

                it("should return a date plus a few hours") {
                    let date = Date(timeIntervalSince1970: 18000)

                    var result = date.add(hours: 5).toString(withFormat: DateFormat.timeStampWithZone)

                    let formattedDate = date.toString(withFormat: DateFormat.timeStampWithZone)
                    expect(formattedDate).to(equal("1970-01-01T00:00:00.000-05:00"))
                    expect(result).to(equal("1970-01-01T05:00:00.000-05:00"))

                    result = date.add(hours: -3).toString(withFormat: DateFormat.timeStampWithZone)

                    expect(result).to(equal("1969-12-31T21:00:00.000-05:00"))
                }
            }

            describe("number of days until date") {
                var cal: NSCalendar!
                beforeEach {
                    cal = NSCalendar.current as NSCalendar!
                }

                it("returns -1 for yesterday") {
                    let now = Date()
                    let yesterday = cal.date(byAdding: .day, value: -1, to: now, options: [])

                    expect(now.numberOfDays(untilDate: yesterday!)).to(equal(-1))
                }

                it("returns 0 for same time") {
                    let now = Date()

                    expect(now.numberOfDays(untilDate: now)).to(equal(0))
                }

                it("returns 1 for tomorrow") {
                    let now = Date()
                    let tomorrow = cal.date(byAdding: .day, value: 1, to: now, options: [])

                    expect(now.numberOfDays(untilDate: tomorrow!)).to(equal(1))
                }

                it("returns 1 for difference of only a few hours (eg: when crossing midnight)") {
                    let now = Date()
                    var comps = cal.components([.hour, .minute], from: now)
                    comps.hour = 22
                    comps.minute = 0
                    let late = cal.date(from: comps)
                    let tomorrow = cal.date(byAdding: .hour, value: 5, to: late!, options: [])

                    expect(late?.numberOfDays(untilDate: tomorrow!)).to(equal(1))
                }

                it("returns 7 for 1 week from now") {
                    let now = Date()
                    let tomorrow = cal.date(byAdding: .day, value: 7, to: now, options: [])

                    expect(now.numberOfDays(untilDate: tomorrow!)).to(equal(7))
                }
            }
        }
    }
}
