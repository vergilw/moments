//
//  UIColor+Extension.swift
//  Moments
//
//  Created by Vergil.Wang on 2019/12/14.
//  Copyright © 2019 ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit

public enum UIColorInputError: Error {
    case missingHashMarkAsPrefix,
    unableToScanHexValue,
    mismatchedHexStringLength,
    unableToOutputHexStringForWideDisplayColor
}

extension UIColor {

    public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue = CGFloat(hex3 & 0x00F) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init(hex4: UInt16) {
        let divisor = CGFloat(15)
        let red = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green = CGFloat((hex4 & 0x0F00) >> 8) / divisor
        let blue = CGFloat((hex4 & 0x00F0) >> 4) / divisor
        let alpha = CGFloat(hex4 & 0x000F) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
        let blue = CGFloat(hex6 & 0x0000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init(hex8: UInt32) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue = CGFloat((hex8 & 0x0000FF00) >> 8) / divisor
        let alpha = CGFloat(hex8 & 0x000000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init(rgba_throws rgba: String) throws {
        guard rgba.hasPrefix("#") else {
            throw UIColorInputError.missingHashMarkAsPrefix
        }
        
        let hexString: String = String(rgba[String.Index(utf16Offset: 1, in: rgba)...])
        var hexValue: UInt64 = 0
        
        guard Scanner(string: hexString).scanHexInt64(&hexValue) else {
            throw UIColorInputError.unableToScanHexValue
        }
        
        switch (hexString.count) {
        case 3:
            self.init(hex3: UInt16(hexValue))
        case 4:
            self.init(hex4: UInt16(hexValue))
        case 6:
            self.init(hex6: UInt32(hexValue))
        case 8:
            self.init(hex8: UInt32(hexValue))
        default:
            throw UIColorInputError.mismatchedHexStringLength
        }
    }
    
    public convenience init(_ rgba: String, defaultColor: UIColor = UIColor.clear) {
        guard let color = try? UIColor(rgba_throws: rgba) else {
            self.init(cgColor: defaultColor.cgColor)
            return
        }
        self.init(cgColor: color.cgColor)
    }
    
    public func hexStringThrows(_ includeAlpha: Bool = true) throws -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        guard r >= 0 && r <= 1 && g >= 0 && g <= 1 && b >= 0 && b <= 1 else {
            throw UIColorInputError.unableToOutputHexStringForWideDisplayColor
        }
        
        if (includeAlpha) {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
    
    public func hexString(_ includeAlpha: Bool = true) -> String {
        guard let hexString = try? hexStringThrows(includeAlpha) else {
            return ""
        }
        return hexString
    }
}

extension String {

    public func argb2rgba() -> String? {
        guard self.hasPrefix("#") else {
            return nil
        }
        
        let hexString: String = String(self[self.index(self.startIndex, offsetBy: 1)...])
        switch hexString.count {
        case 4:
            return "#\(String(hexString[self.index(self.startIndex, offsetBy: 1)...]))\(String(hexString[..<self.index(self.startIndex, offsetBy: 1)]))"
        case 8:
            return "#\(String(hexString[self.index(self.startIndex, offsetBy: 2)...]))\(String(hexString[..<self.index(self.startIndex, offsetBy: 2)]))"
        default:
            return nil
        }
    }
    
}
