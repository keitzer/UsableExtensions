import Quick
import Nimble
@testable import TestOpenSource

class XYZStringExtensionTests: QuickSpec {
    override func spec() {
        describe("String Extension") {
            describe("is truthy") {
                it("returns the proper truthiness") {
                    expect("TRUE".isTruthy).to(beTrue())
                    expect("true".isTruthy).to(beTrue())
                    expect("TrUe".isTruthy).to(beTrue())
                    expect("T".isTruthy).to(beTrue())
                    expect("1".isTruthy).to(beTrue())
                    expect("84384".isTruthy).to(beTrue())
                    expect("Yes".isTruthy).to(beTrue())
                    expect("Y".isTruthy).to(beTrue())
                    expect("y".isTruthy).to(beTrue())
                    expect("yes".isTruthy).to(beTrue())
                    expect("ON".isTruthy).to(beTrue())
                    expect("on".isTruthy).to(beTrue())
                    
                    expect("FALSE".isTruthy).to(beFalse())
                    expect("false".isTruthy).to(beFalse())
                    expect("FaLsE".isTruthy).to(beFalse())
                    expect("F".isTruthy).to(beFalse())
                    expect("0".isTruthy).to(beFalse())
                    expect("00".isTruthy).to(beFalse())
                    expect("No".isTruthy).to(beFalse())
                    expect("N".isTruthy).to(beFalse())
                    expect("n".isTruthy).to(beFalse())
                    expect("no".isTruthy).to(beFalse())
                    expect("OFF".isTruthy).to(beFalse())
                    expect("off".isTruthy).to(beFalse())
                    expect("U".isTruthy).to(beFalse())
                    
                    expect("truth serum".isTruthy).to(beFalse())
                    expect("Yeti".isTruthy).to(beFalse())
                    expect("Onerous".isTruthy).to(beFalse())
                    expect("-1".isTruthy).to(beFalse())
                }
            }
            
            describe("is blank") {
                it("is true when empty") {
                    expect("".isBlank).to(beTrue())
                }
                
                it("is false when not empty") {
                    expect("x".isBlank).to(beFalse())
                }
                
                it("is true when filled with whitespace") {
                    expect(" \t\n\r".isBlank).to(beTrue())
                }
            }
            
            describe("format currency") {
                it("reads in the value")  {
                    let currency = "0.0"
                    expect(currency.toCurrency()).to(equal("$0.00"))
                }
                
                it("does add comma")  {
                    let currency = "1000.0"
                    expect(currency.toCurrency()).to(equal("$1,000.00"))
                }
                
                it("stops parsing numbers at first non number character")  {
                    let currency = "10E0O.100"
                    expect(currency.toCurrency()).to(equal("$10.00"))
                }
                
                it("stops parsing numbers at first non number character even comma")  {
                    let currency = "1,000.0"
                    expect(currency.toCurrency()).to(equal("$1.00"))
                }
                
                it("does not need decimal")  {
                    let currency = "101"
                    expect(currency.toCurrency()).to(equal("$101.00"))
                }
                
                it("from dollar value stops parsing when first non-number occured")  {
                    let currency = "$101.00"
                    expect(currency.toCurrency()).to(equal("$0.00"))
                }
                
                it("returns zero dollars for blank string")  {
                    let currency = ""
                    expect(currency.toCurrency()).to(equal("$0.00"))
                }
            }
            
            describe("trim") {
                it("trims whitespace properly") {
                    let untrimmed = " \t\n\r Tony is Awesome \r\n\t"
                    let trimmed = untrimmed.trim()
                    expect(trimmed).to(equal("Tony is Awesome"))
                }
            }
            
            describe("to date") {
                it("should convert string to date given a format") {
                    let dateString1 = "6/14/2016"
                    let dateString2 = "20160614"
                    
                    let result1 = dateString1.toDate(withFormat: DateFormat.short)
                    let result2 = dateString2.toDate(withFormat: DateFormat.short)
                    
                    expect(result1).notTo(beNil())
                    expect(result2).to(beNil())
                }
            }
            
            describe("last index") {
                it("should return the last index of a character") {
                    let mainString = "lollerskates"
                    let searchString = "l"
                    
                    let result = mainString.lastIndex(ofCharacter: searchString)
                    
                    expect(result).to(equal(3))
                }
                
                it("should return nil if character not in string") {
                    let mainString = "lollerskates"
                    let searchString = "Q"
                    
                    let result = mainString.lastIndex(ofCharacter: searchString)
                    
                    expect(result).to(beNil())
                }
            }
            
            describe("substring from last index") {
                it("should substring from last index of character properly") {
                    let mainString = "lollerskates"
                    let searchString = "l"
                    
                    let result = mainString.substringFromLastIndex(ofCharacter: searchString)
                    
                    expect(result).to(equal("erskates"))
                }
                
                it("should return blank string if last character searched for") {
                    let mainString = "lollerskatez"
                    let searchString = "z"
                    
                    let result = mainString.substringFromLastIndex(ofCharacter: searchString)
                    
                    expect(result).to(equal(""))
                }
                
                it("should return itself if character not in string") {
                    let mainString = "lollerskates"
                    let searchString = "Q"
                    
                    let result = mainString.substringFromLastIndex(ofCharacter: searchString)
                    
                    expect(result).to(equal(mainString))
                }
                
                it("should return blank string if main string is empty") {
                    let mainString = ""
                    let searchString = "z"
                    
                    let result = mainString.substringFromLastIndex(ofCharacter: searchString)
                    
                    expect(result).to(equal(""))
                }
                
                it("should return main string if search string is blank") {
                    let mainString = "lollerskates"
                    let searchString = ""
                    
                    let result = mainString.substringFromLastIndex(ofCharacter: searchString)
                    
                    expect(result).to(equal(mainString))
                }
            }
            
            describe("substring to last index") {
                it("should substring to last index of character properly") {
                    let mainString = "lollerskates"
                    let searchString = "t"
                    
                    let result = mainString.substringToLastIndex(ofCharacter: searchString)
                    
                    expect("lollerska").to(equal(result))
                }
                
                it("should return blank string if first character searched for") {
                    let mainString = "Qollerskatez"
                    let searchString = "Q"
                    
                    let result = mainString.substringToLastIndex(ofCharacter: searchString)
                    
                    expect(result).to(equal(""))
                }
                
                it("should return itself if character not in string") {
                    let mainString = "lollerskates"
                    let searchString = "Q"
                    
                    let result = mainString.substringToLastIndex(ofCharacter: searchString)
                    
                    expect(result).to(equal(mainString))
                }
                
                it("should return blank string if main string is empty") {
                    let mainString = ""
                    let searchString = "z"
                    
                    let result = mainString.substringToLastIndex(ofCharacter: searchString)
                    
                    expect(result).to(equal(""))
                }
                
                it("should return main string if search string is blank") {
                    let mainString = "lollerskates"
                    let searchString = ""
                    
                    let result = mainString.substringToLastIndex(ofCharacter: searchString)
                    
                    expect(result).to(equal(mainString))
                }
            }
            
            describe("slice") {
                it("should extract string between 2 parameters") {
                    let input = "lollerskates"
                    
                    let result = input.slice(from: "ll", to: "te")
                    
                    expect(result).to(equal("erska"))
                }
            }
        }
    }
}
