//
//  BalanceCell.swift
//  SolidCrypto
//
//  Created by Jamal on 6/9/23.
//

import UIKit

class BalanceCell: UICollectionViewCell {
    
    var balance: Double = 0 {
        didSet {
            valueLabel.text = "\(balance.currenyFormat)"
        }
    }
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        container.layer.cornerRadius = 8
        
        titleLabel.apply(TextStyle(fontStyle: .poppinsSemiBold, size: 17), color: .darkGray)
        valueLabel.apply(TextStyle(fontStyle: .poppinsSemiBold, size: 17), color: .darkGray)
        self.clipsToBounds = false
        container.boxShadow(x: 0, y: 5, radius: 15, color: UIColor(hexString: "#444444"), opacity: 0.1)
    }

}
