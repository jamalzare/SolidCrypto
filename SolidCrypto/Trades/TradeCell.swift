//
//  TradeCell.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import UIKit
import Charts

protocol TradeCellDelegate: AnyObject {
    func didTapStartButton(slot: String, coinCode: String, amount: Double, tradeId: Int)
    func didTapClearButton()
    func didSelect(coin: String)
    func presentAlert(title: String, message: String)
}

class TradeCell: UICollectionViewCell {
    
    @IBOutlet weak var coinsList: KDropDownList!
    @IBOutlet weak var amountTextFiled: TextField!
    @IBOutlet weak var tradeList: KDropDownList!
    @IBOutlet weak var startTradeButton: Button!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var clearButton: Button!
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var entryValueLabel: UILabel!
    @IBOutlet weak var winLimitLabel: UILabel!
    @IBOutlet weak var possibleEarningLabel: UILabel!
    @IBOutlet weak var loseLimitLabel: UILabel!
    @IBOutlet weak var possibleLoseLabel: UILabel!
    @IBOutlet weak var entryTimeLabel: UILabel!
    @IBOutlet weak var investmentTimeLabel: UILabel!
    @IBOutlet weak var investmentStatusLabel: UILabel!
    @IBOutlet var labesl: [UILabel]!
    
    weak var delegate: TradeCellDelegate?
    private var enabledList: KDropDownList?
    
    var selectedCoin: String? {
        didSet {
            if selectedCoin != nil {
                coinsList.setSelectedItem()
            }
        }
    }
    
    var selectedTradeId: Int? {
        didSet {
            if selectedTradeId != nil {
                tradeList.setSelectedItem()
            }
        }
    }
    
    var coins: [String]? {
        didSet {
            coinsList.reload()
        }
    }
    
    var trades: [Trade]? {
        didSet {
            tradeList.reload()
        }
    }
    
    var investment: AddInvestment? {
        didSet {
            if let investment = investment {
                entryValueLabel.text = "\(String(format: "%.3f", investment.entryVal))"
                winLimitLabel.text = "\(String(format: "%.3f", investment.winLimit))"
                //            possibleEarningLabel.text = "\(String(format: "%.3f", investment.))"
                loseLimitLabel.text = "\(String(format: "%.3f", investment.loseLimit))"
                //            possibleLoseLabel.text = "\(String(format: "%.3f", investment.))"
                entryTimeLabel.text = "\(investment.displayDate)"
                investmentTimeLabel.text = "\(investment.entryTime)"
                investmentStatusLabel.text = "\(investment.state)"
            } else {
                entryValueLabel.text = "0"
                winLimitLabel.text = "0"
                //            possibleEarningLabel.text = "\(String(format: "%.3f", investment.))"
                loseLimitLabel.text = "0"
                //            possibleLoseLabel.text = "\(String(format: "%.3f", investment.))"
                entryTimeLabel.text = ""
                investmentTimeLabel.text = ""
                investmentStatusLabel.text = "Unknow"
            }
        }
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    func setup() {
        
        coinsList.title = "Choose Coin"
        coinsList.delegate = self
//        coinsList.reload()
        
        amountTextFiled.placeholder = "Choose Amount"
        amountTextFiled.keyboardType = .decimalPad
        
        tradeList.title = "Choose Trade"
        tradeList.delegate = self
        tradeList.reload()
        
        lineChartView.backgroundColor = .white
        lineChartView.rightAxis.enabled = false
        lineChartView.layer.cornerRadius = 8
        infoView.layer.cornerRadius = 8
        
        for label in labesl {
            label.apply(TextStyle(fontStyle: .poppinsMedium, size: 11), color: .appBlackText)
        }
        
        startTradeButton.isEnabled = true
        clearButton.isEnabled = false
        amountTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        self.investment = nil
    }
    
    @IBAction func didTapStartButton() {
        guard let coinIndex = coinsList.selectedIndex,
              let coin = coins?[coinIndex],
              let amount = Double(amountTextFiled.text ?? "") ,
              let tradeIndex = tradeList.selectedIndex,
              let trade = trades?[tradeIndex].tradeId else {
           
            delegate?.presentAlert(title: "Error", message: "Please enter inputs correctly!!")
            return
        }
        endEditing(true)
        delegate?.didTapStartButton(slot: "SLOT_ONE", coinCode: coin, amount: amount, tradeId: trade)
    }
    
    @IBAction func didTapClearButton() {
        coinsList.clearSelection()
        tradeList.clearSelection()
        amountTextFiled.preText = ""
        enabledList?.dismiss()
        delegate?.didTapClearButton()
        endEditing(true)
    }
    
    func setData() {
        let set1 = LineChartDataSet(entries: MockData().yValue, label: "")
        set1.drawCirclesEnabled = false
        set1.mode = .cubicBezier
        set1.lineWidth = 3
        set1.setColor(.systemGreen)
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
        //        lineChartView.xAxis.valueFormatter = ChartIndexAxisValueFormatter()
        lineChartView.xAxis.labelPosition = .bottom
        //        lineChartView.leftAxis.valueFormatter = ChartLeftIndexAxisValueFormatter()
    }
    
    func setData(with numbers:[Double], entryValue: Double? = nil, winLimit: Double? = nil, loseLimit: Double? = nil) {
        var numberData: [ChartDataEntry] = []
        for (index, value) in numbers.enumerated() {
            numberData.append(ChartDataEntry(x: Double(index), y: value))
        }
        
        let set1 = LineChartDataSet(entries: numberData, label: "")
        set1.drawCirclesEnabled = false
        set1.mode = .cubicBezier
        set1.lineWidth = 3
        set1.setColor(.systemGreen)
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
        //        lineChartView.xAxis.valueFormatter = ChartIndexAxisValueFormatter()
        lineChartView.xAxis.labelPosition = .bottom
        
        guard let entryValue = entryValue,
              let winLimit = winLimit,
              let loseLimit = loseLimit else { return }
        
       // print(entryValue, winLimit, loseLimit)
        
        let entryLimitLine = ChartLimitLine(limit: entryValue, label: "")
        entryLimitLine.lineColor = .lightGray
        entryLimitLine.lineDashLengths = [8]
        entryLimitLine.lineWidth = 1
        lineChartView.leftAxis.addLimitLine(entryLimitLine)
        
        let winLimitLine = ChartLimitLine(limit: winLimit, label: "")
        winLimitLine.lineColor = .theme
        winLimitLine.lineWidth = 1
        lineChartView.leftAxis.addLimitLine(winLimitLine)
        
        let loseLimitLine = ChartLimitLine(limit: loseLimit, label: "")
        loseLimitLine.lineColor = .appRed
        loseLimitLine.lineWidth = 1
        lineChartView.leftAxis.addLimitLine(loseLimitLine)
        
        let max = numbers.max() ?? winLimit
        let min = numbers.min() ?? loseLimit
        let maximum = winLimit > max ? winLimit: max
        let minimum = loseLimit < min ? loseLimit: min
        lineChartView.leftAxis.axisMaximum = maximum //+ (maximum * 0.05)
        lineChartView.leftAxis.axisMinimum = minimum // - (minimum * 0.05)
      
    }
    
    @objc func didTap() {
        endEditing(true)
    }
    
    @objc func editingChanged() {
        setButtonActivation()
    }
    
    func setButtonActivation() {
        
        if let _ = coinsList.selectedIndex,
           Double(amountTextFiled.text ?? "") ?? 0 > 0,
           let _ = tradeList.selectedIndex {
//            startTradeButton.isEnabled = true
            return
        }
//        startTradeButton.isEnabled = false
    }
}

extension TradeCell: KDropDownListDelegate {
    func superViewForDropDown(in dropDownList: KDropDownList) -> UIView? {
        return nil
    }
    
    func numberOfItems(in dropDownList: KDropDownList) -> Int {
        if dropDownList == coinsList {
            //            return MockData().coinsList.count
            tradeList.clearSelection()
            setButtonActivation()
            return coins?.count ?? 0
        }
        return trades?.count ?? 0
    }
    
    func KDropDownList(_ dropDownList: KDropDownList, titleFor index: Int) -> String {
        if dropDownList == coinsList {
            return coins?[index] ?? ""
        }
        
        return trades?[index].displayName ?? ""
    }
    
    func KDropDownList(_ dropDownList: KDropDownList, didSelect index: Int) {
        if dropDownList == coinsList, let coin = coins?[index] {
            //            loadTrades(coin: coin)
            delegate?.didSelect(coin: coin)
        }
        
        if dropDownList == tradeList, let _ = trades?[index].tradeId {
            
        }
        
        setButtonActivation()
    }
    
    func willOpen(_ dropDownList: KDropDownList) {
        if enabledList != dropDownList {
            enabledList?.dismiss()
        }
        enabledList = dropDownList
        endEditing(true)
    }
    
    func willDismiss(_ dropDownList: KDropDownList) {
        
    }
    
    func didDismiss(_ dropDownList: KDropDownList) {
        
    }
    
    func KDropDownList(_ dropDownList: KDropDownList, shouldSelect index: Int) -> Bool {
        
        if dropDownList == coinsList, let selected = selectedCoin {
            return coins?[index] == selected
        }
        
        if dropDownList == tradeList, let selected = selectedTradeId {
            return trades?[index].tradeId == selected
        }
        return false
    }
    
}
