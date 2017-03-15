import Quick
import Nimble
@testable import TestOpenSource

class NSNumberExtensionTests: QuickSpec {

    override func spec() {

        let subject = NSNumber(value: 3)

        let equalNSNumber  = NSNumber(value: 3)
        let equalUInt      = UInt(3)
        let equalUInt32    = UInt32(3)
        let equalUInt64    = UInt64(3)
        let equalInt       = Int(3)
        let equalInt32     = Int32(3)
        let equalInt64     = Int64(3)

        let lesserNSNumber = NSNumber(value: 1)
        let lesserUInt     = UInt(1)
        let lesserUInt32   = UInt32(1)
        let lesserUInt64   = UInt64(1)
        let lesserInt      = Int(1)
        let lesserInt32    = Int32(1)
        let lesserInt64    = Int64(1)

        let higherNSNumber = NSNumber(value: 5)
        let higherUInt     = UInt(5)
        let higherUInt32   = UInt32(5)
        let higherUInt64   = UInt64(5)
        let higherInt      = Int(5)
        let higherInt32    = Int32(5)
        let higherInt64    = Int64(5)

        let long_1         = NSDecimalNumber(value: Int32.max).adding(NSDecimalNumber(decimal: Decimal(3)))
        let long_2         = NSDecimalNumber(value: Int64.max).adding(NSDecimalNumber(decimal: Decimal(3)))

        describe("==") {
            it("works for a variety of types") {
                expect(subject == equalNSNumber).to(beTrue())
                expect(subject == equalUInt).to(beTrue())
                expect(subject == equalUInt32).to(beTrue())
                expect(subject == equalUInt64).to(beTrue())
                expect(subject == equalInt).to(beTrue())
                expect(subject == equalInt32).to(beTrue())
                expect(subject == equalInt64).to(beTrue())

                expect(subject == lesserNSNumber).to(beFalse())
                expect(subject == lesserUInt).to(beFalse())
                expect(subject == lesserUInt32).to(beFalse())
                expect(subject == lesserUInt64).to(beFalse())
                expect(subject == lesserInt).to(beFalse())
                expect(subject == lesserInt32).to(beFalse())
                expect(subject == lesserInt64).to(beFalse())

                expect(subject == higherNSNumber).to(beFalse())
                expect(subject == higherUInt).to(beFalse())
                expect(subject == higherUInt32).to(beFalse())
                expect(subject == higherUInt64).to(beFalse())
                expect(subject == higherInt).to(beFalse())
                expect(subject == higherInt32).to(beFalse())
                expect(subject == higherInt64).to(beFalse())

                expect(subject == long_1).to(beFalse())
                expect(subject == long_2).to(beFalse())
            }
        }

        describe("<") {
            it("works for a variety of types") {
                expect(subject < equalNSNumber).to(beFalse())
                expect(subject < equalUInt).to(beFalse())
                expect(subject < equalUInt32).to(beFalse())
                expect(subject < equalUInt64).to(beFalse())
                expect(subject < equalInt).to(beFalse())
                expect(subject < equalInt32).to(beFalse())
                expect(subject < equalInt64).to(beFalse())

                expect(subject < lesserNSNumber).to(beFalse())
                expect(subject < lesserUInt).to(beFalse())
                expect(subject < lesserUInt32).to(beFalse())
                expect(subject < lesserUInt64).to(beFalse())
                expect(subject < lesserInt).to(beFalse())
                expect(subject < lesserInt32).to(beFalse())
                expect(subject < lesserInt64).to(beFalse())

                expect(subject < higherNSNumber).to(beTrue())
                expect(subject < higherUInt).to(beTrue())
                expect(subject < higherUInt32).to(beTrue())
                expect(subject < higherUInt64).to(beTrue())
                expect(subject < higherInt).to(beTrue())
                expect(subject < higherInt32).to(beTrue())
                expect(subject < higherInt64).to(beTrue())

                expect(subject < long_1).to(beTrue())
                expect(subject < long_2).to(beTrue())
            }
        }

        describe(">") {
            it("works for a variety of types") {
                expect(subject > equalNSNumber).to(beFalse())
                expect(subject > equalUInt).to(beFalse())
                expect(subject > equalUInt32).to(beFalse())
                expect(subject > equalUInt64).to(beFalse())
                expect(subject > equalInt).to(beFalse())
                expect(subject > equalInt32).to(beFalse())
                expect(subject > equalInt64).to(beFalse())

                expect(subject > lesserNSNumber).to(beTrue())
                expect(subject > lesserUInt).to(beTrue())
                expect(subject > lesserUInt32).to(beTrue())
                expect(subject > lesserUInt64).to(beTrue())
                expect(subject > lesserInt).to(beTrue())
                expect(subject > lesserInt32).to(beTrue())
                expect(subject > lesserInt64).to(beTrue())

                expect(subject > higherNSNumber).to(beFalse())
                expect(subject > higherUInt).to(beFalse())
                expect(subject > higherUInt32).to(beFalse())
                expect(subject > higherUInt64).to(beFalse())
                expect(subject > higherInt).to(beFalse())
                expect(subject > higherInt32).to(beFalse())
                expect(subject > higherInt64).to(beFalse())

                expect(subject > long_1).to(beFalse())
                expect(subject > long_2).to(beFalse())
            }
        }

        describe(">=") {
            it("works for a variety of types") {
                expect(subject >= equalNSNumber).to(beTrue())
                expect(subject >= equalUInt).to(beTrue())
                expect(subject >= equalUInt32).to(beTrue())
                expect(subject >= equalUInt64).to(beTrue())
                expect(subject >= equalInt).to(beTrue())
                expect(subject >= equalInt32).to(beTrue())
                expect(subject >= equalInt64).to(beTrue())

                expect(subject >= lesserNSNumber).to(beTrue())
                expect(subject >= lesserUInt).to(beTrue())
                expect(subject >= lesserUInt32).to(beTrue())
                expect(subject >= lesserUInt64).to(beTrue())
                expect(subject >= lesserInt).to(beTrue())
                expect(subject >= lesserInt32).to(beTrue())
                expect(subject >= lesserInt64).to(beTrue())

                expect(subject >= higherNSNumber).to(beFalse())
                expect(subject >= higherUInt).to(beFalse())
                expect(subject >= higherUInt32).to(beFalse())
                expect(subject >= higherUInt64).to(beFalse())
                expect(subject >= higherInt).to(beFalse())
                expect(subject >= higherInt32).to(beFalse())
                expect(subject >= higherInt64).to(beFalse())

                expect(subject >= long_1).to(beFalse())
                expect(subject >= long_2).to(beFalse())
            }
        }

        describe("<=") {
            it("works for a variety of types") {
                expect(subject <= equalNSNumber).to(beTrue())
                expect(subject <= equalUInt).to(beTrue())
                expect(subject <= equalUInt32).to(beTrue())
                expect(subject <= equalUInt64).to(beTrue())
                expect(subject <= equalInt).to(beTrue())
                expect(subject <= equalInt32).to(beTrue())
                expect(subject <= equalInt64).to(beTrue())

                expect(subject <= lesserNSNumber).to(beFalse())
                expect(subject <= lesserUInt).to(beFalse())
                expect(subject <= lesserUInt32).to(beFalse())
                expect(subject <= lesserUInt64).to(beFalse())
                expect(subject <= lesserInt).to(beFalse())
                expect(subject <= lesserInt32).to(beFalse())
                expect(subject <= lesserInt64).to(beFalse())

                expect(subject <= higherNSNumber).to(beTrue())
                expect(subject <= higherUInt).to(beTrue())
                expect(subject <= higherUInt32).to(beTrue())
                expect(subject <= higherUInt64).to(beTrue())
                expect(subject <= higherInt).to(beTrue())
                expect(subject <= higherInt32).to(beTrue())
                expect(subject <= higherInt64).to(beTrue())

                expect(subject <= long_1).to(beTrue())
                expect(subject <= long_2).to(beTrue())
            }
        }

    }
}


