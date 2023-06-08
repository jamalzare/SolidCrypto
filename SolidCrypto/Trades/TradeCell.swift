//
//  TradeCell.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import UIKit
import Charts

protocol TradeCellDelegate: AnyObject {
    func didTapStartButton(slot: String, coinCode: String, amount: Int, tradeId: Int)
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
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var winLimitLabel: UILabel!
    @IBOutlet weak var possibleEarningLabel: UILabel!
    @IBOutlet weak var loseLimitLabel: UILabel!
    @IBOutlet weak var possibleLoseLabel: UILabel!
    @IBOutlet weak var entryTimeLabel: UILabel!
    @IBOutlet weak var investmentTimeLabel: UILabel!
    @IBOutlet weak var investmentStatusLabel: UILabel!
    @IBOutlet var labesl: [UILabel]!
    
    @IBOutlet weak var progressContainer: UIView!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressWidth: NSLayoutConstraint!
    @IBOutlet weak var progressLabel: UILabel!
    
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
                calculatePossibles()
            }
        }
    }
    
    var selectedTrade: Trade?
    
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
                entryValueLabel.text = "\(investment.entryVal)"
                winLimitLabel.text = "\(investment.winLimit)"
                currentValueLabel.text = "\(investment.currentProgressValue)"
                loseLimitLabel.text = "\(investment.loseLimit)"
                
                calculatePossibles()
                
                entryTimeLabel.text = "\(investment.displayDate)"
                investmentTimeLabel.text = "\(investment.duration)"
                investmentStatusLabel.text = "\(investment.tradeState.rawValue)"
                investmentStatusLabel.textColor = investment.tradeStateColor
                startTradeButton.isHidden = true
                progressContainer.isHidden = false
            } else {
                entryValueLabel.text = "0"
                currentValueLabel.text = "0"
                winLimitLabel.text = "0"
                possibleEarningLabel.text = "0"
                loseLimitLabel.text = "0"
                possibleLoseLabel.text = "0"
                entryTimeLabel.text = ""
                investmentTimeLabel.text = ""
                investmentStatusLabel.text = ""
                investmentStatusLabel.textColor = .appBlackText
                startTradeButton.isHidden = false
                progressContainer.isHidden = true
            }
        }
    }
    
    func calculatePossibles() {
        guard let investment = investment,
              let index = tradeList.selectedIndex,
              let trade = trades?[index]
              
        else { return }
        let amount = Double(investment.amount)
        
        if let win = trade.win {
            let earning = amount * win/100
            possibleEarningLabel.text = earning.currenyFormat
        }
        
        if let lose = trade.lose {
            let lose = amount * lose/100
            possibleLoseLabel.text = lose.currenyFormat
        }
        
        var progress: Double = 0.5
        let current = investment.currentVal
        let entry = investment.entryVal
        startTradeButton.isHidden = true
        
//        guard let win = trade.win, let lose = trade.lose else { return }
        
        if current == entry {
            progress = 0.5
            
        } else if current > entry {
            
            progress = 0.5 + ((current - entry) / (investment.winLimit - entry) * 0.5)
            progressView.backgroundColor = .theme
            
        } else if current < entry {
            progress =  ((entry - current) / (entry - investment.loseLimit) * 0.5)
            progressView.backgroundColor = .appRed
        }
        
        progressLabel.text = String(format: "%.2f", investment.currentProgressValue)
        progressWidth.constant = progressContainer.frame.width * progress
        UIView.animate(withDuration: 0.5) {
            self.progressContainer.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    func setup() {
        
        coinsList.title = "Choose Coin"
        coinsList.delegate = self
        
        amountTextFiled.placeholder = "Choose Amount"
        amountTextFiled.keyboardType = .numberPad
        
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
        
        investmentStatusLabel.apply(TextStyle(fontStyle: .poppinsSemiBold, size: 11), color: .appBlackText)
        
        progressLabel.apply(TextStyle(fontStyle: .poppinsSemiBold, size: 14), color: .darkGray)
        
        startTradeButton.isEnabled = true
        clearButton.isEnabled = false
        amountTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        amountTextFiled.delegate = self
        self.investment = nil
        
        progressContainer.layer.cornerRadius = 8
        progressContainer.clipsToBounds = true
        progressContainer.isHidden = true
    }
    
    @IBAction func didTapStartButton() {
        guard let coinIndex = coinsList.selectedIndex,
              let coin = coins?[coinIndex],
              let amount = Int(amountTextFiled.text ?? ""),
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
        
        let difrence = (maximum - minimum) * 0.1
        
        lineChartView.leftAxis.axisMaximum = maximum + difrence
        lineChartView.leftAxis.axisMinimum = minimum - difrence
        
    }
    
    @objc func didTap() {
        endEditing(true)
    }
    
    @objc func editingChanged() {
        //        if let amountString = amountTextFiled.text?.currencyInputFormatting() {
        //            amountTextFiled.text = amountString
        //        }
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
            let isSelecteTrade = trades?[index].tradeId == selected
            if isSelecteTrade {
                selectedTrade = trades?[index]
            }
            return isSelecteTrade
        }
        return false
    }
    
}

extension TradeCell: UITextFieldDelegate {
    
}


extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
    
    func currencyToDouble() -> Decimal? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 3
        
        if let number = formatter.number(from: self) {
            let amount = number.decimalValue
            return amount
        }
        
        return nil
    }
}

extension Double {
    
    var currenyFormat: String {
        
        if self == 0 {
            return "0,00"
        }
        
        let str = String(format: "%.2f", self).currencyInputFormatting()
        
        if self < 0 {
            return "-\(str)"
        }
        return str
    }
}

extension Date
{
    func relativeDateAsString() -> String
    {
        let dcf: DateComponentsFormatter = DateComponentsFormatter()
        dcf.includesApproximationPhrase = false
        dcf.includesTimeRemainingPhrase = false
        dcf.allowsFractionalUnits = false
        dcf.maximumUnitCount = 2
        dcf.unitsStyle = .full
        dcf.allowedUnits = [.second, .minute, .hour, .day, .month, .year]
        return dcf.string(from: self, to: Date()) ?? ""
    }
}

