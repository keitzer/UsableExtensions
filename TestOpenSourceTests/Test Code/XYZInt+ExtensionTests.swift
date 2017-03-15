import Quick
import Nimble
@testable import TestOpenSource

class XYZIntExtensionTests: QuickSpec {

    override func spec() {
        describe("Int") {
            describe("isTruthy") {
                it("returns true when > 0") {
                    expect(1.isTruthy).to(beTrue())
                    expect(1000.isTruthy).to(beTrue())
                }
                
                it("returns false when <= 0") {
                    expect(0.isTruthy).to(beFalse())
                    expect((-1).isTruthy).to(beFalse())
                }
            }
            
            describe("toDecimal") {
                it("adds commas to number string") {
                    expect(1000.toDecimal()).to(equal("1,000"))
                    expect(1234567890.toDecimal()).to(equal("1,234,567,890"))
                }
            }
        }
    }
}

