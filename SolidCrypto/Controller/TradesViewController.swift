//
//  ViewController.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import UIKit

class ViewController: UIViewController {}

class Trade1ViewController: TradesViewController {
    override var index: Int {
        return 0
    }
}
class Trade2ViewController: TradesViewController {
    override var index: Int {
        return 1
    }
    
    override var slot: String {
        return "SLOT_TWO"
    }
    
    override var investmentId: Int?  {
        if let id = investment?.investmentId {
            return id
        }
        return bigMe?.tradeSlot2Id
    }
}
class Trade3ViewController: TradesViewController {
    override var index: Int {
        return 2
    }
    
    override var slot: String {
        return "SLOT_THREE"
    }
    
    override var investmentId: Int?  {
        if let id = investment?.investmentId {
            return id
        }
        return bigMe?.tradeSlot3Id
    }
}

class TradesViewController: UIViewController {
    
    var index: Int {
        return 0
    }
    
    var slot: String {
        return "SLOT_ONE"
    }
    
    var investmentId: Int? {
        if let id = investment?.investmentId {
            return id
        }
        return bigMe?.tradeSlotId
    }
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var trade1Button: Button!
    @IBOutlet weak var trade2Button: Button!
    @IBOutlet weak var trade3Button: Button!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pageCell: PageCell?
    var currentSeconds = 0
    var selectedCoint: String?
    var investment: AddInvestment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .gray
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .lightGrayBorder
        navigationController?.view.backgroundColor = .lightGrayBorder
        setNavigationBar()
        setup()
        loadCoins()
        checkInvestStatus(showShowDiagram: true)
        let balance = bigMe?.balance ?? 0
        tabBarController?.title = "Balance: \(balance)"
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        loop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        change(tab: index)
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
        tabBarController?.selectedIndex = tag
        
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
        
        let cell: PageCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        
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
    
    func didTapStartButton(slot: String, coinCode: String, amount: Double, tradeId: Int) {
        addInvestment(slot: slot, coinCode: coinCode, amount: amount, tradeId: tradeId)
    }
    
    
    func didSelect(coin: String) {
        selectedCoint = coin
        loadTrades(coin: coin)
        loadStatistics()
    }
    
    
    func didChange(tab: Int) {
        change(tab: tab)
        view.endEditing(true)
    }
    
    func didTapClearButton() {
        deleteInvestment()
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
    
    func addInvestment(slot: String,coinCode: String, amount: Double, tradeId: Int) {
        
        Loading.shared.show(title: "Loging...")
        
        APIService.addInvestment(slot: self.slot,
                                 coinCode: coinCode,
                                 amount: amount,
                                 tradeId: tradeId) { [weak self] model, error in
            Loading.shared.hide()
            
            if let model = model {
                print(model)
                self?.investment = model
                self?.pageCell?.tradeCell?.descripitonLabel.text = model.description
                self?.updateInvestment()
                
            }
            else if let _ = error {
                self?.presentAlert(title: "Error", message: "Something went wrong!!")
            }
            
        }
    }
}

//MARK: Loops
extension TradesViewController {
    
    func loadStatistics() {
        var coin = investment?.coinCode
        if let selected = selectedCoint {
            coin = selected
        }
        guard let find = coin else { return }
        
        APIService.getStatistics(coin: find){ [weak self] model, error in
            
            self?.updateCoinDiagram()
            
            if let model = model {
                self?.pageCell?.tradeCell?.setData(with: model)
            }
            else if let _ = error {
            }
            
        }
    }
    
    func updateCoinDiagram() {
        currentSeconds += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.loadStatistics()
        }
    }
    
    func deleteInvestment() {
        Loading.shared.show(title: "Loging...")
        
        APIService.deleteInvestments(slot: self.slot) { [weak self] model, error in
            Loading.shared.hide()
            
            if let _ = error {
                self?.presentAlert(title: "Error", message: "Something went wrong!!")
                return
            }
            
            self?.investment = nil
            self?.pageCell?.tradeCell?.descripitonLabel.text = "your investment has been deleted."
        }
    }
    
    func checkInvestStatus(showShowDiagram: Bool = false) {
        guard let id = self.investmentId else { return }
        pageCell?.tradeCell?.descripitonLabel.text = "Checking..."
        
        APIService.getInvestmentStatus(investmentId: id) { [weak self] model, error in
            
            self?.updateInvestment()
            if let model = model {
                self?.investment = model
                self?.pageCell?.tradeCell?.descripitonLabel.text = model.description
                if showShowDiagram {
                    self?.loadStatistics()
                }
            }
            else if let _ = error {
            }
            
        }
    }
    
    func updateInvestment() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let _ = self?.investment else { return }
            self?.checkInvestStatus()
        }
    }
}
