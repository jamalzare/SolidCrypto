//
//  CheckBox.swift
//  PayCore
//
//  Created by Jamal on 9/22/22.
//

import Foundation
import UIKit

class CheckBox: RadioButton {
    
    override func setup() {
        super.setup()
        layer.cornerRadius = 4
        checkView.layer.cornerRadius = 3
    }
}
