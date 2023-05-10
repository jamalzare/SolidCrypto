//
//  TextField.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import Foundation
import UIKit

protocol TextFieldDelegate: AnyObject {
    func didChangeText()
}

protocol HasValidationText: TextField {
    var validationMessage: String { get }
    func validate() -> Bool
}

class TextField: UITextField {
    
    weak var txtDelegate: TextFieldDelegate?
    var validtaionLabelLeading: CGFloat {
        return 16
    }
    
    let contentView = UIView()
    private let placeholderLabel = UILabel()
    private let lineView = UIView()
    private var validationLabel: UILabel?
    private var placeholderTopConstraint: NSLayoutConstraint!
   
    var textPadding: UIEdgeInsets {
        return UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 12)
    }
    
    var preText: String? {
        didSet {
            sendActions(for: .editingDidBegin)
            text = preText
            sendActions(for: .editingDidEnd)
            sendActions(for: .editingChanged)
        }
    }

    override var text: String? {
        didSet {
        }
    }
    
    override var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
            attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.clear])
        }
    }
    
    var isValidText: Bool {
        return true
    }
    
    private var hasValidation: Bool {
        return self is HasValidationText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
        
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    func setup() {
        spellCheckingType = .no
        autocorrectionType = .no
        applyConstraints()
        addTargets()
        applyStyles()
        delegate = self
    }
    
    func applyConstraints() {

        contentView.isUserInteractionEnabled = false
        addSubview(contentView)
        contentView.align(top: 0, height: 54, leadingAndTrailing: 0)
        
        contentView.addSubviews(views: placeholderLabel, lineView)
        
        placeholderLabel.align(leading: 16, trailing: 12)
        placeholderTopConstraint = placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        placeholderTopConstraint.isActive = true
        
        lineView.align(top: 53, height: 1, leadingAndTrailing: 0)
        
        if hasValidation {
            validationLabel = UILabel()
            addSubview(validationLabel!)
            validationLabel?.align(leading: validtaionLabelLeading, trailing: 16)
            validationLabel?.align(toView: contentView, topToBottom: 2)
        }
    }
    
    func addTargets() {
        addTarget(self, action: #selector(didBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(didEnd), for: .editingDidEnd)
    }
    
    func applyStyles() {
        borderStyle = .none
        backgroundColor = .clear
        
        contentView.backgroundColor = .whiteBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        placeholderLabel.apply(TextStyle(fontStyle: .poppinsRegular, size: 14), color: .grayText)
        apply(TextStyle(fontStyle: .poppinsRegular, size: 14), color: .appBlackText)
        tintColor = .appBlackText
        validationLabel?.apply(TextStyle(fontStyle: .poppinsMedium, size: 12), color: .appRed)
        lineView.backgroundColor = .lightGrayBorder
    }
    
    func resetTextField() {
        placeholderTopConstraint.constant = 16
        placeholderLabel.apply(TextStyle(fontStyle: .poppinsRegular, size: 14), color: .grayText)
        validationLabel?.text = ""
        lineView.backgroundColor = .lightGrayBorder
        lineView.heightConstraint?.constant = 1
        animate()
    }
    
    func enable() {
        isEnabled = true
        contentView.backgroundColor = .whiteBackground
        placeholderLabel.textColor = .grayText
        textColor = .appBlackText
    }
    
    func disable() {
        isEnabled = false
        contentView.backgroundColor = UIColor.disableColor
        placeholderLabel.textColor = .lightGrayText
        textColor = .lightGrayText
    }
    
    func disable(text: String) {
        isEnabled = false
        preText = text
        contentView.backgroundColor = UIColor.disableColor
        placeholderLabel.textColor = .lightGrayText
        textColor = .lightGrayText
    }
    
    func disableWithOpacity(text: String) {
        isEnabled = false
        preText = text
//        contentView.backgroundColor = UIColor.disableColor
        placeholderLabel.textColor = placeholderLabel.textColor.withAlphaComponent(0.4)
        textColor = textColor?.withAlphaComponent(0.4)
    }
    
    func clear() {
        text = ""
        sendActions(for: .editingDidEnd)
    }

    func checkValidation() {
        if let validation = self as? HasValidationText {
            lineView.backgroundColor = isValidText ? .theme: .appRed
            validationLabel?.text = isValidText ? "": validation.validationMessage
        }
    }
    
}

extension TextField: UITextFieldDelegate {
    
    @objc func didBegin() {
        if let text = text, text.count == 0 {
            placeholderLabel.apply(TextStyle(fontStyle: .poppinsRegular, size: 11), color: .appTextColor)
            lineView.backgroundColor = .theme
            lineView.heightConstraint?.constant = 2
            placeholderTopConstraint.constant = 8
            animate()
        }
    }
    
    @objc func didEnd() {
        text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if let text = text, text.count > 0  {
            checkValidation()
            
        } else {
            resetTextField()
        }
    }
    
    func animate() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.layoutIfNeeded()
        }
    }
}

extension TextField {
    
    var pureTextCount: Int {
        var text = self.text ?? ""
        text = text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return text.components(separatedBy: .whitespaces).joined().count
    }
    
}
