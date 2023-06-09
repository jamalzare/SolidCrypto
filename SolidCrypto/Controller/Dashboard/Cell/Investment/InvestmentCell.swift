//
//  InvestmentCell.swift
//  SolidCrypto
//
//  Created by Jamal on 6/9/23.
//

import UIKit

class InvestmentCell: UICollectionViewCell {

    var investment: AddInvestment? {
        didSet {
            if let investment = investment {
                nameLabel.text = investment.name
                
                let progress = investment.progress
                if progress > 0.5 {
                    progressView.backgroundColor = .theme
                } else if progress < 0.5  {
                    progressView.backgroundColor = .appRed
                }
                
                currentProgressLabel.text = String(format: "%.2f", investment.currentProgressValue)
                progressWidth.constant = container.frame.width * progress
                UIView.animate(withDuration: 0.5) {
                    self.container.layoutIfNeeded()
                }
                
            }
        }
    }
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressWidth: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currentProgressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        container.layer.cornerRadius = 8
        container.clipsToBounds = true
        
        nameLabel.apply(TextStyle(fontStyle: .poppinsSemiBold, size: 17), color: .darkGray)
        currentProgressLabel.apply(TextStyle(fontStyle: .poppinsSemiBold, size: 17), color: .darkGray)
        progressView.layer.opacity = 0.3
        progressView.backgroundColor = .theme
        
        self.clipsToBounds = false
        container.boxShadow(x: 0, y: 5, radius: 15, color: UIColor(hexString: "#444444"), opacity: 0.2)
    }
}
