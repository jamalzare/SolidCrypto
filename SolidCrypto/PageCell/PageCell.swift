//
//  PageCell.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import UIKit

protocol PageCellDelegate: AnyObject {
    func didChange(tab: Int)
}

class PageCell: UICollectionViewCell {
    
    var tradeCell: TradeCell?
    
    var coins: [String]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var trades: [Trade]? {
        didSet {
            tradeCell?.trades = trades
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: TradeCellDelegate?
    weak var pageCellDelegate: PageCellDelegate?
    private var tab = 0
    
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
        cell.coins = coins
        //                cell.layer.borderWidth = 1
        cell.frame = CGRect(origin: CGPoint(x: cell.frame.minX, y: 0), size: cell.frame.size)
        self.tradeCell = cell
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(collectionView.contentOffset.x / collectionView.frame.size.width)
        if tab == index {
            return
        }
        tab = index
        print(tab)
        pageCellDelegate?.didChange(tab: tab)
        
    }
    
}
