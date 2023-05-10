//
//  TradeCell.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import UIKit
import Charts

protocol TradeCellDelegate: AnyObject {
    func didTapStartButton()
    func didTapClearButton()
}

class TradeCell: UICollectionViewCell {

    @IBOutlet weak var coinsList: KDropDownList!
    @IBOutlet weak var amountTextFiled: TextField!
    @IBOutlet weak var tradeList: KDropDownList!
    @IBOutlet weak var startTrade: UIButton!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var descripitonLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    
    weak var delegate: TradeCellDelegate?
    
    override func awakeFromNib() {
        setup()
        
    }
    
    func setup() {
        
        coinsList.title = "Choose Coin"
        coinsList.delegate = self
        coinsList.reload()
        
        amountTextFiled.placeholder = "Choose Amount"
        amountTextFiled.keyboardType = .numberPad
        
        tradeList.title = "Choose Trade"
        tradeList.delegate = self
        tradeList.reload()
        
        lineChartView.backgroundColor = .white
        lineChartView.rightAxis.enabled = false
        lineChartView.layer.cornerRadius = 8
        setData()
    }

    @IBAction func didTapStartButton() {
        delegate?.didTapStartButton()
    }
    
    @IBAction func didTapClearButton() {
        delegate?.didTapClearButton()
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
        lineChartView.xAxis.valueFormatter = ChartIndexAxisValueFormatter()
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.leftAxis.valueFormatter = ChartLeftIndexAxisValueFormatter()
    }
}

extension TradeCell: KDropDownListDelegate {
    func superViewForDropDown(in dropDownList: KDropDownList) -> UIView? {
        return nil
    }
    
    func numberOfItems(in dropDownList: KDropDownList) -> Int {
        if dropDownList == coinsList {
            return MockData().coinsList.count
        }
        return MockData().Trades.count
    }
    
    func KDropDownList(_ dropDownList: KDropDownList, titleFor index: Int) -> String {
        if dropDownList == coinsList {
            return MockData().coinsList[index].name
        }
        
        return MockData().Trades[index].name
    }
    
    func KDropDownList(_ dropDownList: KDropDownList, didSelect index: Int) {
            
    }
    
    func willOpen(_ dropDownList: KDropDownList) {
        
    }
    
    func willDismiss(_ dropDownList: KDropDownList) {
        
    }
    
    func didDismiss(_ dropDownList: KDropDownList) {
        
    }
    
    func KDropDownList(_ dropDownList: KDropDownList, shouldSelect index: Int) -> Bool {
        return false
    }
    
    
}
