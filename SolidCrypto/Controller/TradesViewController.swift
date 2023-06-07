//
//  ViewController.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import UIKit

var tradesStates: [TradeState] = [.free, .free, .free]

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
    
    override var slotTradeId: Int?  {
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
    
    override var slotTradeId: Int?  {
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
    
    var slotTradeId: Int? {
        return bigMe?.tradeSlotId
    }
    
    var balance: Double = 0.0 {
        didSet {
            tabBarController?.title = "Balance: \(balance.currenyFormat)"
        }
    }
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var trade1Button: Button!
    @IBOutlet weak var trade2Button: Button!
    @IBOutlet weak var trade3Button: Button!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var progres1View = CirlceView()
    var progres2View = CirlceView()
    var progres3View = CirlceView()
    
    var pageCell: PageCell?
    var currentSeconds = 0
    var selectedCoint: String?
    var investment: AddInvestment?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .lightGrayBorder
        navigationController?.view.backgroundColor = .lightGrayBorder
        setNavigationBar()
        setup()
        let balance = bigMe?.balance ?? 0
        self.balance = balance
        tabBarController?.tabBar.isHidden = true
        
        loadSlotTrade()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        change(tab: index)
        setColors()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: PageCell.self)
        collectionView.backgroundColor = .clear
        buttonsView.layer.cornerRadius = 14
        trade1Button.unSelectedStyle = false
        trade2Button.unSelectedStyle = true
        trade3Button.unSelectedStyle = true
        
        view.addSubview(progres1View)
        progres1View.align(toView: trade1Button, leading: 5, widthAndHeight: 10, centerY: 0)
        
        view.addSubview(progres2View)
        progres2View.align(toView: trade2Button, leading: 5, widthAndHeight: 10, centerY: 0)
        
        view.addSubview(progres3View)
        progres3View.align(toView: trade3Button, leading: 5, widthAndHeight: 10, centerY: 0)
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
    
    func setColors() {
        progres1View.state = tradesStates[0]
        progres2View.state = tradesStates[1]
        progres3View.state = tradesStates[2]
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
        return CGSize(width: collectionView.bounds.width, height: 900)
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
    
    func presentAlert(title: String, message: String) {
        presentAlert(title: title, message: message, compeletion: {})
    }
    
    func didTapStartButton(slot: String, coinCode: String, amount: Decimal, tradeId: Int) {
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
    
    func setButtonsActivation() {
        
        if let investment = investment {
            tradesStates[index] = investment.tradeState
            
            pageCell?.tradeCell?.startTradeButton.isEnabled = false
            pageCell?.tradeCell?.clearButton.isEnabled = investment.finished
            
            pageCell?.tradeCell?.coinsList.isUserInteractionEnabled = false
            pageCell?.tradeCell?.amountTextFiled.isUserInteractionEnabled = false
            pageCell?.tradeCell?.tradeList.isUserInteractionEnabled = false
            
        } else {
            pageCell?.tradeCell?.startTradeButton.isEnabled = true
            pageCell?.tradeCell?.clearButton.isEnabled = false
            
            pageCell?.tradeCell?.coinsList.isUserInteractionEnabled = true
            pageCell?.tradeCell?.amountTextFiled.isUserInteractionEnabled = true
            pageCell?.tradeCell?.tradeList.isUserInteractionEnabled = true
            
            tradesStates[index] = .free
        }
        
        setColors()
    }
    
    func loadSlotTrade() {
        
        guard let id = slotTradeId else {
            loadCoins()
            timerLoop()
            return
        }
        
        Loading.shared.show(title: "Loading...")
        
        APIService.getInvestmentStatus(investmentId: id) { [weak self] model, error in
            Loading.shared.hide()
            
            if let model = model {
                self?.investment = model
                self?.pageCell?.tradeCell?.amountTextFiled.preText = "\(model.amount)"
                self?.pageCell?.tradeCell?.investment = model
                self?.loadStatistics()
                self?.loadCoins()
                self?.timerLoop()
                self?.setButtonsActivation()
            }
            else if let _ = error {
                self?.loadCoins()
                self?.timerLoop()
            }
            
        }
    }
    
    func loadCoins() {
        
        Loading.shared.show(title: "Loading...")
        
        APIService.getCoins{ [weak self] model, error in
            Loading.shared.hide()
            
            if let model = model {
                self?.pageCell?.tradeCell?.coins = model
                
                if let investment = self?.investment {
                    self?.pageCell?.tradeCell?.selectedCoin = investment.coinCode
                }
            }
            else if let _ = error {
                self?.presentAlert(title: "Error", message: "Something went wrong!!")
            }
            
        }
    }
    
    func loadTrades(coin: String) {
        
        Loading.shared.show(title: "Loading...")
        
        APIService.getTrades(coinCode: coin){ [weak self] model, error in
            Loading.shared.hide()
            
            if let model = model {
                self?.pageCell?.tradeCell?.trades = model
                
                if let investment = self?.investment {
                    self?.pageCell?.tradeCell?.selectedTradeId = investment.tradeId
                }
            }
            
            else if let _ = error {
                self?.presentAlert(title: "Error", message: "Something went wrong!!")
            }
            
        }
    }
    
    func addInvestment(slot: String, coinCode: String, amount: Decimal, tradeId: Int) {
        
        Loading.shared.show(title: "Loading...")
        
        APIService.addInvestment(slot: self.slot,
                                 coinCode: coinCode,
                                 amount: amount,
                                 tradeId: tradeId) { [weak self] model, error in
            Loading.shared.hide()
            
            if let model = model {
                print(model)
                self?.investment = model
                self?.pageCell?.tradeCell?.investment = model
                self?.setButtonsActivation()
            }
            
            else if let _ = error {
                self?.presentAlert(title: "Error", message: "Something went wrong!!")
            }
            
        }
    }
    
    func deleteInvestment() {
        Loading.shared.show(title: "Loading...")
        
        APIService.deleteInvestments(slot: self.slot) { [weak self] model, error in
            Loading.shared.hide()
            
            if let _ = error {
                self?.presentAlert(title: "Error", message: "Something went wrong!!")
                return
            }
            
            self?.investment = nil
            self?.pageCell?.tradeCell?.investment = nil
            self?.setButtonsActivation()
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
            
            if let model = model {
                let entry = self?.investment?.entryVal
                let win = self?.investment?.winLimit
                let lose = self?.investment?.loseLimit
                self?.pageCell?.tradeCell?.setData(with: model, entryValue: entry, winLimit: win, loseLimit: lose)
            }
            else if let _ = error {
            }
            
        }
    }
    
    func timerLoop() {
        currentSeconds += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.loadStatistics()
            self?.checkInvestStatus()
            self?.getBalance()
        }
    }
    
    func checkInvestStatus() {
        guard let id = self.investment?.investmentId else { return }
//        pageCell?.tradeCell?.descripitonLabel.text = "Checking..."
        
        APIService.getInvestmentStatus(investmentId: id) { [weak self] model, error in
            
            if let model = model {
                self?.investment = model
                self?.pageCell?.tradeCell?.investment = model
                self?.setButtonsActivation()
            }
            else if let _ = error {
            }
            
        }
    }
    
    func getBalance() {
        
        APIService.getBalance() { [weak self] model, error in
            
            self?.timerLoop()
            
            if let model = model {
                self?.balance = model
            }
            
            else if let _ = error {
            }
            
        }
    }
    
}
