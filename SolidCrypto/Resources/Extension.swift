//
//  Extension.swift
//  SolidCrypto
//
//  Created by Jamal on 5/10/23.
//

import Foundation
import UIKit
import Charts

extension UIView {
    
    func addSubviews(views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func align(toView: UIView? = nil,
               top: CGFloat? = nil,
               leading: CGFloat? = nil,
               greaterThanOrEqualLeading: CGFloat? = nil,
               lessThanOrEqualLeading: CGFloat? = nil,
               trailing: CGFloat? = nil,
               greaterThanOrEqualTraling: CGFloat? = nil,
               lessThanOrEqualTraling: CGFloat? = nil,
               bottom: CGFloat? = nil,
               width: CGFloat? = nil,
               height: CGFloat? = nil,
               widthAndHeight: CGFloat? = nil,
               centerX: CGFloat? = nil,
               centerY: CGFloat? = nil,
               equalWidthRatio: CGFloat? = nil,
               equalHeightRatio: CGFloat? = nil,
               all: CGFloat? = nil,
               topAndBottom: CGFloat? = nil,
               leadingAndTrailing: CGFloat? = nil,
               topToBottom: CGFloat? = nil,
               leadingToTrailing: CGFloat? = nil,
               trailingToLeading: CGFloat? = nil,
               bottomToTop: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var view = toView
        if toView == nil {
            view = self.superview
        }
        
        guard let view = view else { return }
        
        if let top = top {
            topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        }
        
        if let greaterThanOrEqualLeading = greaterThanOrEqualLeading {
            leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: greaterThanOrEqualLeading).isActive = true
        }
        
        if let lessThanOrEqualLeading = lessThanOrEqualLeading {
            leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: lessThanOrEqualLeading).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -trailing).isActive = true
        }
        
        if let greaterThanOrEqualTraling = greaterThanOrEqualTraling {
            trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: greaterThanOrEqualTraling).isActive = true
        }
        
        if let lessThanOrEqualTraling = lessThanOrEqualTraling {
            trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: lessThanOrEqualTraling).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottom).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let widthAndHeight = widthAndHeight {
            widthAnchor.constraint(equalToConstant: widthAndHeight).isActive = true
            heightAnchor.constraint(equalToConstant: widthAndHeight).isActive = true
        }
        
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: centerX).isActive = true
        }
        
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerY).isActive = true
        }
        
        if let equalWidthRatio = equalWidthRatio {
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: equalWidthRatio).isActive = true
        }
        
        if let equalHeightRatio = equalHeightRatio {
            heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: equalHeightRatio).isActive = true
        }
        
        if let all = all {
            align(toView: view, top: all, leading: all, trailing: all, bottom: all)
        }
        
        if let topAndBottom = topAndBottom {
            align(toView: view, top: topAndBottom, bottom: topAndBottom)
        }
        
        if let leadingAndTrailing = leadingAndTrailing {
            align(toView: view, leading: leadingAndTrailing, trailing: leadingAndTrailing)
        }
        
        if let topToBottom = topToBottom {
            topAnchor.constraint(equalTo: view.bottomAnchor, constant: topToBottom).isActive = true
        }
        
        if let leadingToTrailing = leadingToTrailing {
            leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: leadingToTrailing).isActive = true
        }
        
        if let trailingToLeading = trailingToLeading {
            trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: trailingToLeading).isActive = true
        }
        
        if let bottomToTop = bottomToTop {
            bottomAnchor.constraint(equalTo: view.topAnchor, constant: bottomToTop).isActive = true
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /**
     box-shadow: x y blur-radius color+opacity;
     Swift:
     view.layer.shadowColor = color
     view.layer.shadowOpacity = opacity
     view.layer.cornerRadius = 13
     view.layer.shadowOffset = CGSize(width: x, height: y);
     view.layer.shadowRadius = r
     
     **/
    func boxShadow(x: CGFloat, y: CGFloat, radius: CGFloat, color: UIColor, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = radius
    }
    
    func rotate(duration: CFTimeInterval = 1){
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func stopRotate() {
        self.layer.removeAllAnimations()
    }
    
    func setWhiteCardStyle() {
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.appLightGray.cgColor
        backgroundColor = .white.withAlphaComponent(0.9)
    }
}


extension UIView {
    
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var widthConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    //    var topConstraint: NSLayoutConstraint? {
    //        get {
    //            return constraints.first(where: {
    //                $0.firstAttribute == .top && $0.relation == .equal
    //            })
    //        }
    //        set { setNeedsLayout() }
    //    }
    //
    var topConstraint: NSLayoutConstraint? {
        return self.constraints.filter( { ($0.firstItem as? UIView == self && $0.firstAttribute == .top) || ($0.secondItem as? UIView == self && $0.secondAttribute == .top) }).first
    }
    
}

extension UIView {
    
    func animate(duration: CGFloat = 0.2) {
        UIView.animate(withDuration: duration) {
            self.layoutIfNeeded()
        }
    }
}

extension UIImageView {
    func createImageWith(name: String,
                         fontSize: CGFloat = 13,
                         backgroundColor: UIColor = .white,
                         textColor: UIColor = .darkBlueText,
                         borderColor: UIColor = .theme) {
        
        if let sub = self.viewWithTag(111) {
            sub.removeFromSuperview()
        }
        
        var nameComponents = name.uppercased().components(separatedBy: CharacterSet.letters.inverted)
        nameComponents.removeAll(where: {$0.isEmpty})
        
        
        let firstInitial = nameComponents.first?.first
        let lastInitial  = nameComponents.count > 1 ? nameComponents.last?.first : nil
        let str = (firstInitial != nil ? "\(firstInitial!)" : "") + (lastInitial != nil ? "\(lastInitial!)" : "")
        
        
        let btn = UIButton(frame: self.bounds)
        btn.tag = 111
        btn.setTitle(str, for: .normal)
        btn.backgroundColor = backgroundColor
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(textColor, for: .normal)
        btn.apply(TextStyle(fontStyle: .poppinsBold, size: fontSize), color: .darkBlueText, for: .normal)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.minimumScaleFactor = 0.5
        btn.layer.borderColor = borderColor.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = frame.width/2
        btn.center = self.center
        
        self.image = nil
        
        UIGraphicsBeginImageContextWithOptions(btn.bounds.size, btn.isOpaque, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        btn.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = result
    }
}

extension UIDevice {
    
    static var isIphoneSE: Bool {
        return screenType == .iPhones_5_5s_5c_SE
    }
    
    static var notchHeight: CGFloat {
        return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    }
    
    static var hasNotch: Bool {
        return notchHeight > 0
    }
    
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR = "iPhone XR"
        case iPhone_XSMax = "iPhone XS Max"
        case unknown
    }
    
    static var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhones_4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax
        default:
            return .unknown
        }
    }
    
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension UIViewController {
    func setNavigationBar() {
        
        if let bar = self.navigationController?.navigationBar {
            UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
            
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height + 2
            
            let statusbarView = UIView(frame: CGRect(
                x: 0,
                y: 0 - statusBarHeight,
                width: UIScreen.main.bounds.size.width,
                height: statusBarHeight))
            
            statusbarView.backgroundColor = UIColor.white
            bar.addSubview(statusbarView)
            
            bar.backgroundColor = .white
            bar.isTranslucent = false
            
            bar.titleTextAttributes = [.foregroundColor: UIColor.appTextColor,
                                       .font: TextStyle(fontStyle: .poppinsMedium, size: 21).font]
            bar.boxShadow(x: 0, y: 5, radius: 15, color: UIColor(hexString: "#444444"), opacity: 0.1)
            bar.layer.cornerRadius = 16
            bar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            bar.setBackgroundImage(UIImage(), for: .default)
            bar.backIndicatorImage = Images.arrowBack
            bar.backIndicatorTransitionMaskImage = Images.arrowBack
            bar.tintColor = .appTextColor
            bar.backItem?.title = ""
            
            navigationItem.backButtonTitle = ""
            navigationItem.backBarButtonItem?.tintColor = .yellow
        }
        
    }
    
    func presentAlert(title: String, message: String, compeletion: @escaping()-> Void = {}) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: {_ in
            compeletion()
        }))
        
        present(alert, animated: true, completion: nil)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

enum Storyboard: String {
    case splash
    case main
    
    var filename: String {
        return rawValue.capitalizingFirstLetter()
    }
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }

extension UIStoryboard {
    
    // MARK: - Convenience Initializers
    
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - Class Functions
    
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - View Controller Instantiation from Generics
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}

extension UICollectionViewCell {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UICollectionView {
    public final func register<T: UICollectionViewCell>(cellType: T.Type)
    where T: UICollectionViewCell {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    public final func registerSupplementaryView<T: UICollectionViewCell>(cellType: T.Type)
    where T: UICollectionViewCell {
        register(cellType.nib,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: cellType.reuseIdentifier)
    }
    
    public final func registerSupplementaryViewHeader<T: UICollectionReusableView>(
        cellType: T.Type) where T: UICollectionViewCell {
            register(cellType.nib,
                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                     withReuseIdentifier: cellType.reuseIdentifier)
        }
    
    public final func registerSupplementaryViewFooter<T: UICollectionReusableView>(
        cellType: T.Type) where T: UICollectionViewCell {
            register(cellType.nib,
                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                     withReuseIdentifier: cellType.reuseIdentifier)
        }
    
    public final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath,
                                                                   cellType: T.Type = T.self) -> T
    where T: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
    
    public final func dequeueReusableSupplementaryView<T: UICollectionViewCell>(
        for indexPath: IndexPath, kind: String, cellType: T.Type = T.self) -> T
    where T: UICollectionViewCell {
        guard let cell = dequeueReusableSupplementaryView(
            ofKind: kind, withReuseIdentifier: cellType.reuseIdentifier,
            for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
    
    //    public final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
    //        for indexPath: IndexPath, kind: String, cellType: T.Type = T.self) -> T
    //    where T: UICollectionViewCell {
    //        guard let cell = dequeueReusableSupplementaryView(
    //                ofKind: kind, withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
    //            fatalError(
    //                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
    //                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
    //                    + "and that you registered the cell beforehand"
    //            )
    //        }
    //        return cell
    //    }
}

extension UITableViewCell{
    
    static var identifier: String{
        return NSStringFromClass(self)
    }
    
    static var nib: UINib{
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
}

extension UITableView {
    func register<T: UITableViewCell>(_ cell: T.Type) {
        self.register(cell.self, forCellReuseIdentifier: cell.identifier)
    }
    
    //    public final func register<T: UITableViewCell>(cellType: T.Type)
    //        where T: UITableViewCell {
    //        register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    //    }
    
    //    public final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
    //        where T: UITableViewCell {
    //        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
    //            fatalError(
    //                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
    //                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
    //                    + "and that you registered the cell beforehand"
    //            )
    //        }
    //        return cell
    //    }
    
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T  {
        
        //register(T.self)
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("failed to dequeue \(T.self)")
        }
        return cell
    }
    
    //    final func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type)
    //    where T: UITableViewCell {
    //        self.register(headerFooterViewType.nib, forHeaderFooterViewReuseIdentifier:
    //                      headerFooterViewType.reuseIdentifier)
    //    }
    
    //    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T?
    //        where T: UITableViewCell {
    //          guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T? else {
    //            fatalError(
    //              "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) "
    //                + "matching type \(viewType.self). "
    //                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
    //                + "and that you registered the header/footer beforehand"
    //            )
    //          }
    //          return view
    //      }
}


class ChartIndexAxisValueFormatter: IndexAxisValueFormatter {
    
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if value  < 10 {
            return "Feb"
        }
        if value < 20 {
            return "MAR"
        }
        if value < 30 {
            return "JUL"
        }
        else {
            return "Dec"
        }
    }
}

class ChartLeftIndexAxisValueFormatter: IndexAxisValueFormatter {
    
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if value  < 10 {
            return "$ 1,200"
        }
        if value < 20 {
            return "$ 1,400"
        }
        if value < 30 {
            return "$ 1,600"
        }
        else {
            return "$ 1,800"
        }
    }
}

class MockData {
    let yValue: [ChartDataEntry] = [
        ChartDataEntry(x: 0, y: 0),
        ChartDataEntry(x: 1, y: 5),
        ChartDataEntry(x: 2, y: 7),
        ChartDataEntry(x: 3, y: 5),
        ChartDataEntry(x: 4, y: 10),
        ChartDataEntry(x: 5, y: 6),
        ChartDataEntry(x: 6, y: 9),
        ChartDataEntry(x: 7, y: 7),
        ChartDataEntry(x: 8, y: 15),
        ChartDataEntry(x: 9, y: 14),
        ChartDataEntry(x: 10, y: 12),
        ChartDataEntry(x: 11, y: 15),
        ChartDataEntry(x: 14, y: 19),
        ChartDataEntry(x: 15, y: 24),
        ChartDataEntry(x: 16, y: 22),
        ChartDataEntry(x: 17, y: 20),
        ChartDataEntry(x: 18, y: 27),
        ChartDataEntry(x: 19, y: 22),
        ChartDataEntry(x: 21, y: 30),
        ChartDataEntry(x: 22, y: 28),
        ChartDataEntry(x: 23, y: 27),
        ChartDataEntry(x: 24, y: 31),
        ChartDataEntry(x: 25, y: 33),
        ChartDataEntry(x: 26, y: 27),
        ChartDataEntry(x: 27, y: 27),
        ChartDataEntry(x: 28, y: 32),
    ]
    
    var coinsList  = [
        Coin(id: "1", name: "Bitcoin"),
        Coin(id: "2", name: "USDT"),
        Coin(id: "3", name: "Ethereum"),
        Coin(id: "4", name: "Shiba"),
        Coin(id: "5", name: "Bnb"),
        Coin(id: "6", name: "USD Coin"),
    ]
    
    var Trades  = [
        Coin(id: "1", name: "Trade 1"),
        Coin(id: "2", name: "Trade 2"),
        Coin(id: "3", name: "Trade 3"),
    ]
}
