//
//  CirlceView.swift
//  SolidCrypto
//
//  Created by Jamal on 6/6/23.
//

import Foundation
import UIKit

class CirlceView: UIView {
    
    var state: TradeState = .free {
        didSet {
            switch state {
            case .ongoing:
                backgroundColor = .white
                break
                
            case .succeded:
                backgroundColor = .theme
                break
                
            case .failed:
                backgroundColor = .appPink
                break
                
            case .free:
                backgroundColor = .clear
                break
            }
            
            if state == .free {
                layer.borderWidth = 0
            } else {
                layer.borderWidth = 1
            }
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
        layer.cornerRadius = frame.width/2
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width/2
    }
}
