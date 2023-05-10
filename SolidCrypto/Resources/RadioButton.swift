//
//  RadioButton.swift
//  PayCore
//
//  Created by Jamal on 8/16/22.
//

import Foundation
import UIKit

class RadioButton: UIView {
    
    let checkView = UIView()
    
    var isEnabled: Bool = false {
        didSet {
            backgroundColor = isEnabled ? UIColor.theme.withAlphaComponent(0.04): .white
            layer.borderColor = isEnabled ? UIColor.theme.withAlphaComponent(0.1).cgColor: UIColor.boxBorder.cgColor
            checkView.isHidden = !isEnabled
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
        widthAnchor.constraint(equalToConstant: 24).isActive = true
        heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        layer.cornerRadius = 12
        layer.borderWidth = 1
        
        addSubview(checkView)
        checkView.align(widthAndHeight: 16, centerX: 0, centerY: 0)
        checkView.layer.cornerRadius = 8
        checkView.backgroundColor = .theme
        checkView.isHidden = true
        
        isEnabled = false
    }
}

class SeperatorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = .grayText.withAlphaComponent(0.2)
        layer.cornerRadius = 0.5
    }
  
    
}
