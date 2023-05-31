//
//  KDropDownList.swift
//  PayCore
//
//  Created by Jamal on 2/13/23.
//

import Foundation
import UIKit

//class Test2ViewController: UIViewController, KDropDownListDelegate {
//    func willDismiss(_ dropDownList: KDropDownList) {
//        
//    }
//    
//    var texts = [
//        "yes",
//        "true",
//        "Happy",
//        "fantastic",
//        "cool"
//    ]
//    
//    func superViewForDropDown(in dropDownList: KDropDownList) -> UIView? {
//        nil
//    }
//    
//    func numberOfItems(in dropDownList: KDropDownList) -> Int {
//        return texts.count
//    }
//    
//    func KDropDownList(_ dropDownList: KDropDownList, titleFor index: Int) -> String {
//        return texts[index]
//    }
//    
//    func KDropDownList(_ dropDownList: KDropDownList, didSelect index: Int) {
//        print(texts[index])
//    }
//    
//    func willOpen(_ dropDownList: KDropDownList) {
//        print("opening")
//    }
//    
//    func didDismiss(_ dropDownList: KDropDownList) {
//        print("will dismiss")
//    }
//    
//    func KDropDownList(_ dropDownList: KDropDownList, shouldSelect index: Int) -> Bool {
//        return false
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        setGradientBackground()
//        let drop = KDropDownList(frame: .zero)
//        view.addSubview(drop)
//        drop.align(top: 110, height: 56, leadingAndTrailing: 16)
//        drop.delegate = self
//        
//        drop.title = "My drop Down"
//    }
//}

protocol KDropDownListDelegate: AnyObject {
    func superViewForDropDown(in dropDownList: KDropDownList) -> UIView?
    func numberOfItems(in dropDownList: KDropDownList) -> Int
    func KDropDownList(_ dropDownList : KDropDownList, titleFor index: Int) -> String
    func KDropDownList(_ dropDownList: KDropDownList, didSelect index: Int)
    func willOpen(_ dropDownList: KDropDownList)
    func willDismiss(_ dropDownList: KDropDownList)
    func didDismiss(_ dropDownList: KDropDownList)
    func KDropDownList(_ dropDownList: KDropDownList, shouldSelect index: Int) -> Bool
}

class KDropDownList: UIView {
    
    var selectedIndex: Int?
    var isOpen = false
    var maxHeight: CGFloat {
        return itemHeight * 5 + 5
    }
    weak var owner: UIView?
    
    var itemHeight: CGFloat = 53
    var animateDuration: CGFloat = 0.2
    private var hasDropDownAdded = false
    
    private let headView = UIView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let chevronImageView = UIImageView()
    private var titleLabelTop: NSLayoutConstraint?
    private let bottomBorderView = UIView()
    private let dropDownView = UIView()
    private let tv = UITableView()
    
    private var superViewForDropDown: UIView? {
        if let view = delegate?.superViewForDropDown(in: self) {
            return view
        } else {
            return superview
        }
    }
    
    var title: String = "title" {
        didSet {
            titleLabel.text = title
        }
    }
    
    weak var delegate: KDropDownListDelegate? {
        didSet {
            
        }
    }
    
    var hasSelectedItem: Bool {
        return selectedIndex != nil
    }
    
    var scrollIndicatorInsets: UIEdgeInsets? {
        didSet {
            if let insets = scrollIndicatorInsets {
                tv.scrollIndicatorInsets = insets
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reload()
    }
    
    func setup() {
        backgroundColor = .clear
        setHeadView()
        setChevron()
        setTitleLabel()
        setValueLabel()
        setBottomBorder()
        
    }
    
    private func setHeadView() {
        addSubviews(views: headView)
        headView.align(top: 0, leading: 0, trailing: 0, height: 56)
        headView.backgroundColor = .whiteBackground.withAlphaComponent(0.9)
        headView.layer.cornerRadius = 8
        headView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        headView.addGestureRecognizer(tapGesture)
    }
    
    private func setChevron() {
        addSubview(chevronImageView)
        let image = Images.chevronIcon.withRenderingMode(.alwaysTemplate)
        chevronImageView.image = image
        chevronImageView.tintColor = .grayText
        chevronImageView.align(trailing: 16, widthAndHeight: 24, centerY: 0)
        chevronImageView.transform = CGAffineTransform(rotationAngle: 2 * .pi)
    }
    
    private func setTitleLabel() {
        headView.addSubview(titleLabel)
        titleLabel.text = ""
        titleLabel.align(leading: 16)
        titleLabel.align(toView: chevronImageView, lessThanOrEqualTraling: 10)
        titleLabelTop = titleLabel.topAnchor.constraint(equalTo: headView.topAnchor, constant: 16)
        titleLabelTop?.isActive = true
        titleLabel.apply(TextStyle(fontStyle: .poppinsRegular, size: 15), color: .grayText)
    }
    
    private func setValueLabel() {
        headView.addSubview(valueLabel)
        valueLabel.align(top: 25, leading: 16)
        valueLabel.align(toView: chevronImageView, lessThanOrEqualTraling: 10)
        valueLabel.apply(TextStyle(fontStyle: .poppinsRegular, size: 14), color: .appBlackText)
    }
    
    private func setBottomBorder() {
        headView.addSubview(bottomBorderView)
        bottomBorderView.align(bottom: 0, height: 2, leadingAndTrailing: 0)
        bottomBorderView.backgroundColor = .theme
        bottomBorderView.isHidden = true
    }
    
    private func setDropDownView() {
        if hasDropDownAdded { return }
        
        if let view = delegate?.superViewForDropDown(in: self) {
            view.addSubview(dropDownView)
        } else {
            superview?.addSubview(dropDownView)
        }
        dropDownView.clipsToBounds = false
        dropDownView.align(toView: headView, height: 8, leadingAndTrailing: 0, topToBottom: 0)
        hasDropDownAdded = true
        setTableView()
    }
    
    func setDefaultStyles() {
        bottomBorderView.isHidden = true
        titleLabel.textColor = .grayText
        chevronImageView.tintColor = .grayText
    }
    
    func setSelectedStyles() {
        titleLabel.apply(TextStyle(fontStyle: .poppinsRegular, size: 11), color: .appTextColor)
        chevronImageView.tintColor = .appTextColor
        bottomBorderView.isHidden = false
    }
    
    func setOpenedStyles() {
        bottomBorderView.isHidden = false
        titleLabel.textColor = .appTextColor
        chevronImageView.tintColor = .appTextColor
    }
    
    private func didSelect(index: Int) {
        valueLabel.text = delegate?.KDropDownList(self, titleFor: index)
        titleLabelTop?.constant = 8
        setSelectedStyles()
        
        UIView.animate(withDuration: animateDuration) { [weak self] in
            self?.headView.layoutIfNeeded()
        }
        
        delegate?.KDropDownList(self, didSelect: index)
        
    }
    
    @objc func didTap() {
        isOpen ? dismiss(): open()
    }
    
    func open() {
        isOpen = true
        delegate?.willOpen(self)
        setOpenedStyles()
        
        if let count = delegate?.numberOfItems(in: self) {
            var height = CGFloat(count) * itemHeight + 8
            if height > maxHeight  {
                height = maxHeight
            }
            dropDownView.heightConstraint?.constant = height
            
            if tv.numberOfRows(inSection: 0) == 0, count > 0 {
                tv.reloadData()
            }
            
            if count == 0 {
                return
            }
        }
       
        
        UIView.animate(withDuration: animateDuration) { [weak self] in
            guard let self = self else { return }
            self.chevronImageView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
            //            self.superViewForDropDown?.layoutIfNeeded()
            self.superview?.layoutIfNeeded()
        }
    }
    
    
    func dismiss(withDuration: CGFloat? = nil) {
        isOpen = false
        endEditing(true)
        delegate?.willDismiss(self)
        dropDownView.heightConstraint?.constant = 8
        
        if selectedIndex == nil {
            setDefaultStyles()
        }
        
        let duration = withDuration ?? animateDuration
        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let self = self else { return }
            self.chevronImageView.transform = CGAffineTransform(rotationAngle: 2 * .pi)
            self.superViewForDropDown?.layoutIfNeeded()
            //            self.superview?.layoutIfNeeded()
        }, completion: { [weak self] dismissed in
            
            guard let self = self else { return }
            if dismissed {
                self.delegate?.didDismiss(self)
            }
        })
    }
    
    func reload() {
        setDropDownView()
        tv.reloadData()
    }
    
    func setSelectedItem() {
        guard let delegate = delegate else { return }
        
        let count = delegate.numberOfItems(in: self)
        
        guard count > 0 else { return }
        
        for i in 0...count - 1 {
            if delegate.KDropDownList(self, shouldSelect: i) {
                selectedIndex = i
                didSelect(index: i)
//                delegate.KDropDownList(self, didSelect: i)
                return
            }
        }
    }
    
    func clearSelection() {
        titleLabelTop?.constant = 16
        titleLabel.apply(TextStyle(fontStyle: .poppinsRegular, size: 15), color: .grayText)
        
        selectedIndex = nil
        valueLabel.text = ""
        setDefaultStyles()
        reload()
    }
    
    func disable() {
        isUserInteractionEnabled = false
        
        headView.backgroundColor = UIColor.disableColor
        titleLabel.textColor = .lightGrayText
        valueLabel.textColor = .lightGrayText
        chevronImageView.tintColor = .lightGrayText
        
    }
}


//MARK: DropDown View
extension KDropDownList: UITableViewDelegate, UITableViewDataSource {
    
    private func setTableView() {
        let backView = UIView()
        dropDownView.addSubview(backView)
        
        backView.align(top: 8, leading: 0, trailing: 0, bottom: 0)
        
        backView.addSubview(tv)
        tv.dataSource = self
        tv.delegate = self
        tv.align(all: 0)
        tv.separatorStyle = .none
        tv.register(KDropDownItemCell.self)
        tv.showsVerticalScrollIndicator = false
        tv.layer.cornerRadius = 8
        tv.clipsToBounds = true
        
        backView.backgroundColor = .white.withAlphaComponent(0.9)
        backView.layer.borderColor = UIColor.theme.cgColor
        
        backView.layer.cornerRadius = 8
        backView.layer.borderWidth = 1.5
        backView.clipsToBounds = false
        
        backView.boxShadow(x: 0, y: 0, radius: 2, color: .theme.withAlphaComponent(0.5), opacity: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.numberOfItems(in: self) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: KDropDownItemCell = tableView.dequeueCell(for: indexPath)
        
        if let title = delegate?.KDropDownList(self, titleFor: indexPath.item) {
            cell.title = title
            cell.isSelected = selectedIndex == indexPath.item
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let index = selectedIndex,
           let cell = tableView.cellForRow(at: IndexPath(item: index, section: 0)) as? KDropDownItemCell {
            cell.isSelected = false
        }
        
        selectedIndex = indexPath.item
        
        if let cell = tableView.cellForRow(at: indexPath) as? KDropDownItemCell {
            cell.isSelected = true
        }
        didSelect(index: indexPath.item)
        dismiss()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight
    }
}

class KDropDownItemCell: UITableViewCell {
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    
    override var isSelected: Bool {
        didSet {
            radionButton.isEnabled = isSelected
        }
    }
    
    let label = UILabel()
    let radionButton = RadioButton()
    let seperator = SeperatorView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //        layer.borderWidth = 1
        selectionStyle = .none
        clipsToBounds = true
        addSubviews(views: label, radionButton, seperator)
        
        label.align(leading: 16, trailing: 30, centerY: 0)
        label.apply(TextStyle(fontStyle: .poppinsRegular, size: 13), color: .appTextColor)
        
        radionButton.align(trailing: 16, widthAndHeight: 24, centerY: 0)
        seperator.align(bottom: 0, height: 1, leadingAndTrailing: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


