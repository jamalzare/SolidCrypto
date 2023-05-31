//
//  TradeCell.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import UIKit
import Charts

protocol TradeCellDelegate: AnyObject {
    func didTapStartButton(coinCode: String, amount: Double, tradeId: Int)
    func didTapClearButton()
    func didSelect(coin: String)
}

class TradeCell: UICollectionViewCell {
    
    @IBOutlet weak var coinsList: KDropDownList!
    @IBOutlet weak var amountTextFiled: TextField!
    @IBOutlet weak var tradeList: KDropDownList!
    @IBOutlet weak var startTradeButton: Button!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var descripitonLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    
    weak var delegate: TradeCellDelegate?
    private var enabledList: KDropDownList?
    
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
        coinsList.reload()
        
        amountTextFiled.placeholder = "Choose Amount"
        amountTextFiled.keyboardType = .decimalPad
        
        tradeList.title = "Choose Trade"
        tradeList.delegate = self
        tradeList.reload()
        
        lineChartView.backgroundColor = .white
        lineChartView.rightAxis.enabled = false
        lineChartView.layer.cornerRadius = 8
//        setData()/
        startTradeButton.isEnabled = false
        //        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        //        addGestureRecognizer(tap)
        amountTextFiled.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @IBAction func didTapStartButton() {
        guard let coinIndex = coinsList.selectedIndex,
              let coin = coins?[coinIndex],
              let amount = Double(amountTextFiled.text ?? "") ,
              let tradeIndex = tradeList.selectedIndex,
              let trade = trades?[tradeIndex].tradeId else {
            return    
        }
        delegate?.didTapStartButton(coinCode: coin, amount: amount, tradeId: trade)
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
    
    func setData(with numbers:[Double]) {
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
//        lineChartView.leftAxis.valueFormatter = ChartLeftIndexAxisValueFormatter()
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
            startTradeButton.isEnabled = true
            return
        }
        startTradeButton.isEnabled = false
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
            //            return MockData().coinsList[index].name
            return coins?[index] ?? ""
        }
        
        return trades?[index].displayName ?? ""
    }
    
    func KDropDownList(_ dropDownList: KDropDownList, didSelect index: Int) {
        if dropDownList == coinsList, let coin = coins?[index] {
            //            loadTrades(coin: coin)
            delegate?.didSelect(coin: coin)
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
        return false
    }
    
}
