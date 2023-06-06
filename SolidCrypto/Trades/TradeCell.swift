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
    @IBOutlet weak var descripitonLabel: UILabel!
    @IBOutlet weak var clearButton: Button!
    
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
        startTradeButton.isEnabled = true
        clearButton.isEnabled = false
        amountTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
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
        
        print(entryValue, winLimit, loseLimit)
        
        let entryLimitLine = ChartLimitLine(limit: entryValue, label: "")
        entryLimitLine.lineColor = .lightGray
        lineChartView.leftAxis.addLimitLine(entryLimitLine)
        
        let winLimitLine = ChartLimitLine(limit: winLimit, label: "")
        winLimitLine.lineColor = .theme
        lineChartView.leftAxis.addLimitLine(winLimitLine)
        
        let loseLimitLine = ChartLimitLine(limit: loseLimit, label: "")
        loseLimitLine.lineColor = .appRed
        lineChartView.leftAxis.addLimitLine(loseLimitLine)
        
        
        let max = numbers.max() ?? winLimit
        let min = numbers.min() ?? loseLimit
        lineChartView.leftAxis.axisMaximum = winLimit > max ? winLimit: max
        lineChartView.leftAxis.axisMinimum = loseLimit < min ? loseLimit: min
      
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
