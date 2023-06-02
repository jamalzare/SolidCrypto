//
//  ViewController.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import UIKit

class ViewController: UIViewController {}

class TradesViewController: UIViewController {
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var trade1Button: Button!
    @IBOutlet weak var trade2Button: Button!
    @IBOutlet weak var trade3Button: Button!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pageCell: PageCell?
    
    var currentSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .gray
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .lightGrayBorder
        navigationController?.view.backgroundColor = .lightGrayBorder
        setNavigationBar()
        setup()
        loadCoins()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        loop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
    }
    
    @IBAction func didTapButtons(sender: AnyObject) {
        
        guard let tag = (sender as? UIView)?.tag else { return }
        let index = IndexPath(item: tag, section: 0)
        
      change(tab: tag)
        print(index)
//        collectionView.layer.borderWidth = 2
//        collectionView.layer.borderColor = UIColor.red.cgColor
        pageCell?.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    func change(tab: Int) {
        if tab == 0 {
            trade1Button.unSelectedStyle = false
            trade2Button.unSelectedStyle = true
            trade3Button.unSelectedStyle = true
        }
        
        if tab == 1 {
            trade2Button.unSelectedStyle = false
            trade1Button.unSelectedStyle = true
            trade3Button.unSelectedStyle = true
        }
        
        if tab == 2 {
            trade3Button.unSelectedStyle = false
            trade1Button.unSelectedStyle = true
            trade2Button.unSelectedStyle = true
        }
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
        
        cell.pageCellDelegate = self
        cell.frame = CGRect(origin: CGPoint(x: cell.frame.minX, y: 0), size: cell.frame.size)
        self.pageCell = cell
        return cell
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = collectionView.bounds.height
        if height < 650 {
            height = 650
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

extension TradesViewController: TradeCellDelegate, PageCellDelegate {
   
    func didTapStartButton(coinCode: String, amount: Double, tradeId: Int) {
        addInvestment(coinCode: coinCode, amount: amount, tradeId: tradeId)
    }
    
    
    func didSelect(coin: String) {
        loadTrades(coin: coin)
        loadStatistics(coin: coin)
    }
    
    
    func didChange(tab: Int) {
        change(tab: tab)
        view.endEditing(true)
    }
    
    func didTapClearButton() {
        loadStatistics(coin: "BNBUSDT")
    }
    
}

//MARK: APIS
extension TradesViewController {
    
    func loadCoins() {
        
        Loading.shared.show(title: "Loging...")
        
        APIService.getCoins{ [weak self] model, error in
            Loading.shared.hide()
            
            if let model = model {
                self?.pageCell?.coins = model
                self?.collectionView.reloadData()
                
            }
            else if let _ = error {
                self?.presentAlert(title: "Error", message: "Something went wrong!!")
            }
            
        }
    }
    
    func loadStatistics(coin: String) {
        
//        Loading.shared.show(title: "Loging...")
        
        APIService.getStatistics(coin: coin){ [weak self] model, error in
//            Loading.shared.hide()
            
            self?.updateCoinDiagram()
            
            if let model = model {
                
//                self?.collectionView.reloadData()
                self?.pageCell?.currentCell?.setData(with: model)
                
            }
            else if let _ = error {
//                self?.presentAlert(title: "Error", message: "Something went wrong!!")
            }
            
        }
    }
    
    func loadTrades(coin: String) {
        
        Loading.shared.show(title: "Loging...")
        
        APIService.getTrades(coinCode: coin){ [weak self] model, error in
            Loading.shared.hide()
            
            if let model = model {
                self?.pageCell?.trades = model
                self?.collectionView.reloadData()
//                self?.loadStatistics(coin: coin)
                
            }
            else if let _ = error {
                self?.presentAlert(title: "Error", message: "Something went wrong!!")
            }
            
        }
    }
    
    func addInvestment(coinCode: String, amount: Double, tradeId: Int) {
        
        Loading.shared.show(title: "Loging...")
        
        APIService.addInvestment(coinCode: coinCode, amount: amount, tradeId: tradeId) { [weak self] model, error in
            Loading.shared.hide()
            
            if let model = model {
//                self?.pageCell?.
                print(model)
//                self?.collectionView.reloadData()
                self?.pageCell?.currentCell?.descripitonLabel.text = model.description
                
            }
            else if let _ = error {
                self?.presentAlert(title: "Error", message: "Something went wrong!!")
            }
            
        }
    }
}

//MARK: Loops
extension TradesViewController {
    
    func updateCoinDiagram() {
        currentSeconds += 1
        let times = "\(currentSeconds)"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.title = "Total Account timer:\(times)"
            print("contune")
//            guard let coin = self?.pageCell?.currentCell?.selectedCoin else { return }
            let coin = self?.pageCell?.currentCell?.selectedCoin ?? ""
            self?.loadStatistics(coin: coin)
        }
    }
}
