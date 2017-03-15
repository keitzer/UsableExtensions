import Quick
import Nimble
@testable import TestOpenSource

class XYZDoubleExtensionTests: QuickSpec {
    override func spec() {
        describe("Double") {
            describe("formatToCurrency") {
                it("formats currency as expected")  {
                    let subject = 123.45
                    expect(subject.toCurrency()).to(equal("$123.45"))
                }

                it("rounds to the nearest cent")  {
                    let subject = 123.456
                    expect(subject.toCurrency()).to(equal("$123.46"))
                }

                it("separates with commas")  {
                    let subject = 1234.56
                    expect(subject.toCurrency()).to(equal("$1,234.56"))
                }
            }
        }
    }
}
