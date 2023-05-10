//
//  PageCell.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: TradeCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: TradeCell.self)
        collectionView.backgroundColor = .clear
    }

}

extension PageCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 3
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
    //        if indexPath.section == 0 {
                let cell: TradeCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.delegate = delegate
//                cell.layer.borderWidth = 1
                cell.frame = CGRect(origin: CGPoint(x: cell.frame.minX, y: 0), size: cell.frame.size)
                return cell
    //        }
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            0
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        }
        
    }
