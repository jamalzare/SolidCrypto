//
//  TextStyle.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import Foundation
import UIKit

struct TextStyle {
    let fontStyle: FontStyle
    let size: CGFloat
    var font: UIFont {
        return fontStyle.asUIFont(size: size)
    }
}

enum FontStyle: String {
    ///weight 100
    case interThin = "Inter-Thin"
    ///weight 200
    case interExtraLight = "Inter-ExtraLight"
    ///weight 300
    case interLight = "Inter-Light"
    ///weight 400
    case interRegular = "Inter-Regular"
    ///weight 500
    case interMedium = "Inter-Medium"
    ///weight 600
    case interSemiBold = "Inter-SemiBold"
    ///weight 700
    case interBold = "Inter-Bold"
    ///weight 800
    case interExtraBold = "Inter-ExtraBold"
    ///weight 900
    case interBlack = "Inter-Black"
    
    ///weight 100
    case poppinsThin = "Poppins-Thin"
    ///weight 200
    case poppinsExtraLight = "Poppins-ExtraLight"
    //weight 300
    case poppinsLight = "Poppins-Light"
    ///weight 400
    case poppinsRegular = "Poppins-Regular"
    ///weight 500
    case poppinsMedium = "Poppins-Medium"
    ///weight 600
    case poppinsSemiBold = "Poppins-SemiBold"
    ///weight 700
    case poppinsBold = "Poppins-Bold"
    ///weight 800
    case poppinsExtraBold = "Poppins-ExtraBold"
    ///weight 900
    case poppinsBlack = "Poppins-Black"
    
    case poppinsItalic = "Poppins-Italic"
    
    case ocrAExtended = "OcrAExtended"

    func asUIFont(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}

extension UITextField {
    func apply(_ textStyle: TextStyle, color: UIColor) {
        self.font = textStyle.fontStyle.asUIFont(size: textStyle.size)
        self.textColor = color
    }
}

extension UITextView {
    func apply(_ textStyle: TextStyle, color: UIColor) {
        self.font = textStyle.fontStyle.asUIFont(size: textStyle.size)
        self.textColor = color
    }
}

extension UILabel {
    func apply(_ textStyle: TextStyle, color: UIColor) {
        self.font = textStyle.fontStyle.asUIFont(size: textStyle.size)
        self.textColor = color
    }

    func apply(_ fontStyle: FontStyle, size: CGFloat, color: UIColor) {
        self.font = fontStyle.asUIFont(size: size)
        self.textColor = color
    }

    func underline(_ textStyle: TextStyle, color: UIColor, underlineText: String) {
        guard let text = text else { return }
        let underlineAttriString = NSMutableAttributedString(string: text, attributes: [
            NSAttributedString.Key.font: textStyle.fontStyle.asUIFont(size: textStyle.size),
            NSAttributedString.Key.foregroundColor: color
        ])
        let termsRange = (text as NSString).range(of: underlineText)
        underlineAttriString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: termsRange)
        attributedText = underlineAttriString
    }
     func boldText(regularText: String,_ regularstyle: TextStyle,boldiText: String,_ boldStyle: TextStyle, color: UIColor) {
          let text = regularText
          let boldAttrs = [NSAttributedString.Key.font : boldStyle.fontStyle.asUIFont(size: boldStyle.size),
                       NSAttributedString.Key.foregroundColor: color]
         let regAttrs = [ NSAttributedString.Key.font: regularstyle.fontStyle.asUIFont(size: regularstyle.size),
                          NSAttributedString.Key.foregroundColor: color]
         
          let regularString = NSMutableAttributedString(string: text,attributes:regAttrs)
          let boldiString = NSMutableAttributedString(string: boldiText, attributes:boldAttrs)
          //regularString.append(boldiString)
         
         let range = (text as NSString).range(of: boldiText)
         regularString.addAttributes(boldAttrs, range: range)
          attributedText = regularString
      }
    
    ///Find the index of character (in the attributedText) at point
    func indexOfAttributedTextCharacterAtPoint(point: CGPoint) -> Int {
        assert(self.attributedText != nil, "This method is developed for attributed string")
        let textStorage = NSTextStorage(attributedString: self.attributedText!)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: self.frame.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode
        layoutManager.addTextContainer(textContainer)

        let index = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return index
    }
}

extension UIButton {
    func apply(_ textStyle: TextStyle, color: UIColor, for: UIControl.State = .normal) {
        self.titleLabel?.font = textStyle.fontStyle.asUIFont(size: textStyle.size)
//        self.setTitleColor(color, for: .normal)
        
        let states: [UIControl.State] = [.normal, .highlighted, .selected, [.highlighted, .selected]]
        for state in states {
            self.setTitleColor(color, for: state)
        }
    }
}
