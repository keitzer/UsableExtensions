import Quick
import Nimble
@testable import TestOpenSource

class UIColorExtensionTests: QuickSpec {
    override func spec() {
        describe("ui color extensions") {
            describe("whiteness") {
                it("is white when rgba is white") {
                    expect(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).isWhite).to(beTrue())
                }

                it("is not white when rgba is not white") {
                    expect(UIColor(red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0).isWhite).to(beFalse())
                }

                it("is white when whiteness is white") {
                    expect(UIColor(white: 1.0, alpha: 1.0).isWhite).to(beTrue())
                }

                it("is not white when whiteness is not white") {
                    expect(UIColor(white: 0.9, alpha: 1.0).isWhite).to(beFalse())
                }
            }
            
            describe("float init") {
                it("Should Get A Green Color When Passing In The Appropriate Values") {
                    let green = UIColor(floatRed: 0, floatGreen: 255, floatBlue: 0, floatAlpha: 1.0)

                    expect(green).to(equal(UIColor.green))
                }
            }
            
            describe("with hex") {
                it("Should Get A Black Color When Passing In Black Hex String") {
                    let color = UIColor(withHex: "#000000")
                    
                    expect(color).to(equal(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)))
                }
                
                it("Should Get A DarkGray Color When Passing In DarkGray Hex String") {
                    let color = UIColor(withHex: "#555555")
                    
                    expect(color).to(equal(UIColor(red: 1.0/3, green: 1.0/3, blue: 1.0/3, alpha: 1.0)))
                }
                
                it("Should Get A LightGray Color When Passing In LightGray Hex String") {
                    let color = UIColor(withHex: "#aaaaaa")
                    
                    expect(color).to(equal(UIColor(red: 2.0/3, green: 2.0/3, blue: 2.0/3, alpha: 1.0)))
                }
                
                it("Should Get A White Color When Passing In White Hex String") {
                    let color = UIColor(withHex: "#ffffff")
                    
                    expect(color).to(equal(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                }
                
                it("Should Get A Gray Color When Passing In Gray Hex String") {
                    let color = UIColor(withHex: "#808080")
                    
                    expect(color).to(equal(UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)))
                }
                
                it("Should Get A Green Color When Passing In Green Hex String") {
                    let color = UIColor(withHex: "#00ff00")
                    
                    expect(color).to(equal(UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)))
                }
                
                it("Should Get A Blue Color When Passing In Blue Hex String") {
                    let color = UIColor(withHex: "#0000ff")
                    
                    expect(color).to(equal(UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)))
                }
                
                it("Should Get A Cyan Color When Passing In Cyan Hex String") {
                    let color = UIColor(withHex: "#00ffff")
                    
                    expect(color).to(equal(UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                }
                
                it("Should Get A Yellow Color When Passing In Yellow Hex String") {
                    let color = UIColor(withHex: "#ffff00")
                    
                    expect(color).to(equal(UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)))
                }
                
                it("Should Get A Magenta Color When Passing In Magenta Hex String") {
                    let color = UIColor(withHex: "#ff00ff")
                    
                    expect(color).to(equal(UIColor.magenta))
                }
                
                it("Should Get A nOrange Color When Passing In Orange Hex String") {
                    let color = UIColor(withHex: "#ff8000")
                    
                    expect(color).to(equal(UIColor(red: 1.0, green: 128.0/255.0, blue: 0.0, alpha: 1.0)))
                }
                
                it("Should Get A Purple Color When Passing In Purple Hex String") {
                    let color = UIColor(withHex: "#800080")
                    
                    expect(color).to(equal(UIColor(red: 128.0/255.0, green: 0.0, blue: 128.0/255.0, alpha: 1.0)))
                }
                
                it("Should Get A Brown Color When Passing In Brown Hex String") {
                    let color = UIColor(withHex: "#996633")
                    
                    expect(color).to(equal(UIColor.brown))
                }
                
                it("Should Get A Clear Color When Passing In Clear Hex String") {
                    let color = UIColor(withHex: "#00000000")
                    
                    expect(color).to(equal(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)))
                }
                
                it("Should Get A TransparentBrown Color When Passing In Transparent Brown Hex String") {
                    let color = UIColor(withHex: "#99663333")
                    
                    expect(color).to(equal(UIColor(red: 0.6, green: 0.4, blue: 0.2, alpha: 0.2)))
                }
                
                it("Should Get A Red Color When Passing In FullRed Hex String") {
                    let color = UIColor(withHex: "#ff0000")
                    
                    expect(color).to(equal(UIColor.red))
                }
                
                it("Should Get Nil When Passing In ABad Hex String") {
                    let garbage = UIColor(withHex: "qwfpgj13")
                    
                    expect(garbage).to(beNil())
                }
                
                it("Should Get Nil When Passing In A Hex String That Is Three Digits") {
                    let small = UIColor(withHex: "#123")
                    
                    expect(small).to(beNil())
                }
                
                it("Should Get Nil When Passing In A Hex String That Is Too Small") {
                    let small = UIColor(withHex: "#123f5")
                    
                    expect(small).to(beNil())
                }
                
                it("Should Get Nil When Passing In A Hex String That Is Seven Digits") {
                    let seven = UIColor(withHex: "#123f567")
                    
                    expect(seven).to(beNil())
                }
                
                it("Should Get Nil When Passing In A Hex String That Is Too Large") {
                    let big = UIColor(withHex: "#123f56789")
                    
                    expect(big).to(beNil())
                }
            }

            describe("getHSLA") {
                it("should return an HSLA struct when given a color") {
                    let hsla = UIColor.orange.toHSLA()

                    let hueInt = ceil(hsla.hue * 360)
                    expect(hueInt).to(equal(30))
                    expect(hsla.saturation).to(equal(1))
                    expect(hsla.lightness).to(equal(0.5))
                    expect(hsla.alpha).to(equal(1))
                }

                it("should return a color") {
                    let hsla = HSLA(hue: 0, saturation: 1, lightness: 0.5, alpha: 1)

                    let newColor = UIColor(withHSLA: hsla)
                    var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
                    newColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

                    let redInt = round(red * 255)
                    let greenInt = round(green * 255)
                    let blueInt = round(blue * 255)
                    expect(redInt).to(equal(255))
                    expect(greenInt).to(equal(0))
                    expect(blueInt).to(equal(0))
                    expect(alpha).to(equal(1))
                }
            }

            describe("color gradient") {
                describe("with a light color") {
                    it("returns a darker color") {
                        let color = UIColor(withHex: "#99ffc2")
                        let newColor = color?.relativeGradientColor()

                        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
                        newColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

                        let redInt = round(red * 255)
                        let greenInt = round(green * 255)
                        let blueInt = round(blue * 255)
                        expect(redInt).to(equal(51))
                        expect(greenInt).to(equal(255))
                        expect(blueInt).to(equal(133))
                    }
                }

                describe("with a dark color") {
                    it("returns a lighter color") {
                        let color = UIColor(withHex: "#006629")
                        let newColor = color?.relativeGradientColor()

                        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
                        newColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

                        let redInt = round(red * 255)
                        let greenInt = round(green * 255)
                        let blueInt = round(blue * 255)
                        expect(redInt).to(equal(0))
                        expect(greenInt).to(equal(204))
                        expect(blueInt).to(equal(82))
                    }
                }

                describe("with a color at 50% brightness") {
                    it("returns a darker color") {
                        let color = UIColor(withHex: "#e21d1d")
                        let newColor = color?.relativeGradientColor()

                        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
                        newColor?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

                        let redInt = ceil(red * 255)
                        let greenInt = ceil(green * 255)
                        let blueInt = ceil(blue * 255)
                        expect(redInt).to(equal(136))
                        expect(greenInt).to(equal(18))
                        expect(blueInt).to(equal(18))
                    }
                }
            }
        }
    }
}
