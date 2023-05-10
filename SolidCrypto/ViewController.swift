//
//  ViewController.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    
}


class TradesViewController: UIViewController {
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var trade1Button: Button!
    @IBOutlet weak var trade2Button: Button!
    @IBOutlet weak var trade3Button: Button!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pageCell: PageCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .gray
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .lightGrayBorder
        navigationController?.view.backgroundColor = .lightGrayBorder
        setNavigationBar()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setup() {
        title = "Total Account"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: PageCell.self)
        collectionView.backgroundColor = .clear
        buttonsView.layer.cornerRadius = 14
        trade1Button.unSelectedStyle = false
        trade2Button.unSelectedStyle = true
        trade3Button.unSelectedStyle = true
        //        collectionView.contentInset.top = 16
        //        collectionView.contentInset.bottom = 16
    }
    
    @IBAction func didTapButtons(sender: AnyObject) {
        
        guard let tag = (sender as? UIView)?.tag else { return }
        let index = IndexPath(item: 0, section: tag)
        
        if tag == 0 {
            trade1Button.unSelectedStyle = false
            trade2Button.unSelectedStyle = true
            trade3Button.unSelectedStyle = true
        }
        
        if tag == 1 {
            trade2Button.unSelectedStyle = false
            trade1Button.unSelectedStyle = true
            trade3Button.unSelectedStyle = true
        }
        
        if tag == 2 {
            trade3Button.unSelectedStyle = false
            trade1Button.unSelectedStyle = true
            trade2Button.unSelectedStyle = true
        }
        print(index)
//        collectionView.layer.borderWidth = 2
//        collectionView.layer.borderColor = UIColor.red.cgColor
        pageCell?.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
}


extension TradesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //        if indexPath.section == 0 {
        let cell: PageCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
//        cell.layer.borderWidth = 1
        cell.frame = CGRect(origin: CGPoint(x: cell.frame.minX, y: 0), size: cell.frame.size)
        self.pageCell = cell
        return cell
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = collectionView.bounds.height
        if height < 630 {
            height = 630
        }
        return CGSize(width: collectionView.bounds.width, height: height)
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

extension TradesViewController: TradeCellDelegate {
    
    func didTapStartButton() {
        
    }
    
    func didTapClearButton() {
        
    }
    
}


