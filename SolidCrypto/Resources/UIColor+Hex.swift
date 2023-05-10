//
//  UIColor+Hex.swift
//  PayCore
//
//  Created by Fikri Can Cankurtaran on 21.07.2022.
//

import Foundation
import UIKit.UIColor

extension UIColor {
    ///#05D989
    static let theme = UIColor(named: "theme") ?? .green
    
    ///#E4E9F2
    static let appLightGray = UIColor(named: "appLightGray") ?? lightGray
    
    //#4A4A4A
    static let lightDarkText = UIColor(named: "lightDarkText") ?? lightGray
    
    ///#2E3A59
    static let appTextColor = UIColor(named: "textColor") ?? black
    
    ///#192038
    static let appBlackText = UIColor(named: "appBlackText") ?? .black

    ///#8F9BB3
    static let grayText = UIColor(named: "grayText") ?? lightGray
    
    ///#EDF1F7
    static let lightGrayBorder = UIColor(named: "lightGrayBorder") ?? lightGray
    
    ///#FC5976
    static let appRed = UIColor(named: "appRed") ?? red
    
    ///#587A9D 50%
    static let boxBorder = UIColor(named: "boxBorder") ?? gray
    
    ///#4F80FB 15%
    static let boxBlue = UIColor(named: "boxBlue") ?? blue
    
    ///#4F80FB
    static let blueText = UIColor(named: "blueText") ?? blue
    
    ///#222B45
    static let darkBlueText = UIColor(named: "darkBlueText") ?? blue
    
    ///#DEAB02
    static let appYellow = UIColor(named: "appYellow") ?? .yellow
    
    ///#FDD448
    static let appSecondYellow = UIColor(named: "appSecondYellow") ?? .yellow
    
    ///#F7F9FC
    static let whiteBackground = UIColor(named: "whiteBackground") ?? white
    
    ///#101426
    static let darkGrayText = UIColor(named: "darkGrayText") ?? gray
    
    ///#048B57
    static let appGreen = UIColor(named: "appGreen") ?? .green
    
    ///#ABDBCB
    static let greenCardBackground = UIColor(named: "greenCardBackground") ?? .green
    
    ///#101426
    static let darkText = UIColor(named: "darkText") ?? .green
    
    static let color = UIColor(named: "Color") ?? .gray
    
    ///#4F80FB
    static let appBlue = UIColor(named: "appBlue") ?? .green
    
    ///#151A30
    static let blackText = UIColor(named: "blackText") ?? .black
    
    ///#5F3EC8
    static let appPurple = UIColor(named: "appPurple") ?? .purple
    
    ///#5961F9
    static let secondPurple = UIColor(named: "secondPurple") ?? .purple
    
    ///#C5CEE0
    static let lightGrayText = UIColor(named: "lightGrayText") ?? gray
    
    ///#FC7192
    static let appPink = UIColor(named: "appPink") ?? gray
    
    ///#40FFB4
    static let loadingLabelColor = UIColor(hexString: "#40FFB4")
    
    ///#434E6A
    static let blackText2 = UIColor(hexString: "#434E6A")
    
    ///#DADFE3
    static let pattenBlue = UIColor(named: "pattenBlue") ?? white
    
    ///#DFE3E9
    static let disableColor = UIColor(named: "disableColor") ?? white
    
    ///#ADB3BC
    static let grayCount = UIColor(named: "grayCount") ?? white
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

    var hexString: String {
        if let components = self.cgColor.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            return  String(format: "#%02x%02x%02x", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
        }
        return "#ffffff"
    }
}
