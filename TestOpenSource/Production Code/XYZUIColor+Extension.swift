import Foundation
import UIKit

public struct HSLA {
    var hue: CGFloat
    var saturation: CGFloat
    var lightness: CGFloat
    var alpha: CGFloat
}

public extension UIColor {
    
    /// Pass in a string containing a hex value
    public convenience init?(withHex hex: String) {
        
        var hexString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        var hasAlpha = false
        
        if (hexString.hasPrefix("#")) {
            hexString = String(hexString.characters.dropFirst())
        }
        
        guard hexString.characters.count == 6 || hexString.characters.count == 8 else {
            return nil
        }
        
        let scanner = Scanner(string: hexString)
        
        if hexString.characters.count == 8 {
            hasAlpha = true
        }
        
        var color:UInt32 = 0
        
        guard scanner.scanHexInt32(&color) else {
            return nil
        }
        
        if hasAlpha {
            self.init(withRGBA: color)
        } else {
            self.init(withRGB: color)
        }
    }
    
    /// Pass in an RGB Integer
    public convenience init(withRGB color: UInt32) {
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    /// Pass in an RGBA Integer
    public convenience init(withRGBA color: UInt32) {
        let mask: UInt32 = 0x000000FF
        let r = UInt32(color >> 24) & mask
        let g = UInt32(color >> 16) & mask
        let b = UInt32(color >> 8) & mask
        let a = UInt32(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        let alpha = CGFloat(a) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// Pass in an HSLA value
    public convenience init(withHSLA incomingHSLA: HSLA) {
        var hsla = incomingHSLA
        
        hsla.lightness *= 2
        hsla.saturation *= (hsla.lightness <= 1) ? hsla.lightness : 2 - hsla.lightness
        let brightness = (hsla.lightness + hsla.saturation) / 2
        let saturation = (2 * hsla.saturation) / (hsla.lightness + hsla.saturation)
        
        self.init(hue: hsla.hue, saturation: saturation, brightness: brightness, alpha: hsla.alpha)
    }
    
    /// Pass in values between 0 and 255.0 for rgb and values between 0 and 1.0 for alpha
    public convenience init(floatRed: CGFloat, floatGreen: CGFloat, floatBlue: CGFloat, floatAlpha: CGFloat) {
        let r = floatRed / 255.0
        let g = floatGreen / 255.0
        let b = floatBlue / 255.0
        self.init(red: r, green: g, blue: b, alpha: floatAlpha)
    }

    public var isWhite: Bool {
        return self == UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) || self == UIColor(white: 1.0, alpha: 1.0)
    }

    func toHSLA() -> HSLA {

        var hue: CGFloat = 0
        var hsb_saturation: CGFloat = 0
        var hsb_brightness: CGFloat = 0
        var alpha: CGFloat = 0
        getHue(&hue, saturation: &hsb_saturation, brightness: &hsb_brightness, alpha: &alpha)

        var hsl_lightness = (2 - hsb_saturation) * hsb_brightness
        var hsl_saturation = hsb_saturation * hsb_brightness
        hsl_saturation /= (hsl_lightness <= 1) ? (hsl_lightness) : 2 - (hsl_lightness)
        hsl_lightness /= 2

        return HSLA(hue: hue, saturation: hsl_saturation, lightness: hsl_lightness, alpha: alpha)
    }

    func relativeGradientColor() -> UIColor {
        var hsla = toHSLA()

        let distanceToMove: CGFloat = 0.2
        let mid: CGFloat = 0.5
        hsla.lightness += hsla.lightness < mid ? distanceToMove : -distanceToMove

        return UIColor(withHSLA: hsla)
    }
}
