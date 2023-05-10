//
//  Button.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import Foundation
import UIKit

class Button: UIButton {
    
    var isLightStyle = false
    
    override var isEnabled: Bool {
        didSet {
            apply(TextStyle(fontStyle: .poppinsMedium, size: 14), color: isEnabled ? .white: .grayText)
            backgroundColor = isEnabled ? .theme: .appLightGray
        }
    }
    
    var unSelectedStyle = false {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let color: UIColor = isEnabled ? .theme: .appLightGray
        backgroundColor = color
//        apply(TextStyle(fontStyle: .poppinsMedium, size: 14), color: .white)
        if isLightStyle  {
            backgroundColor = .clear
        }
        
        if unSelectedStyle
        {
            backgroundColor = .white
            apply(TextStyle(fontStyle: .poppinsMedium, size: 14), color: .appTextColor)
        } else {
            apply(TextStyle(fontStyle: .poppinsMedium, size: 14), color: .white)
        }
    }
    
    var cornerRadius: CGFloat = 14 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 14
        backgroundColor = .appLightGray
        isEnabled = true
    }
    
    func setLightStyle() {
        layer.borderWidth = 2
        layer.cornerRadius = 14
        backgroundColor = .clear
        layer.borderColor =  UIColor.theme.cgColor
        apply(TextStyle(fontStyle: .poppinsMedium, size: 14), color: .appTextColor)
        isLightStyle = true
    }
}


class LightButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        layer.borderWidth = 2
        layer.cornerRadius = 14
        backgroundColor = .clear
        layer.borderColor =  UIColor.theme.cgColor
        apply(TextStyle(fontStyle: .poppinsMedium, size: 14), color: .appTextColor)
    }
}
