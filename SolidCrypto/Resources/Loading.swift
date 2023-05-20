//
//  Loading.swift
//  SolidCrypto
//
//  Created by Jamal on 5/20/23.
//

import Foundation
import UIKit

class Loading {
    
    public static let shared = Loading()
    
    private let containerView = UIView()
    private let animationView = UIImageView()
    private let label = UILabel()
    
    var title: String = "" {
        didSet {
            label.text = title
        }
    }
    
    var message: String = "" {
        didSet {
            label.text = title + "\n\(message)"
        }
    }
    
    func show(presented: Bool = false, title: String, presentingView: UIView? = nil) {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
        
        animationView.image = Images.loadingSpinner
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = .appTextColor.withAlphaComponent(0.9)
        
        animationView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        animationView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        animationView.backgroundColor = .clear
        
        self.title = title
        label.text = title
        
        label.textAlignment = .center
        label.numberOfLines = 0
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 80, height: 182)
        label.apply(TextStyle(fontStyle: .poppinsRegular, size: 14), color: .loadingLabelColor)
        containerView.addSubview(label)
        containerView.addSubview(animationView)
        animationView.center = CGPoint(x: containerView.bounds.width / 2,
                                       y: containerView.bounds.height / 2)
        label.center = CGPoint(x: animationView.center.x, y: animationView.center.y + 54)
        if let presentingView = presentingView {
            presentingView.addSubview(containerView)
        } else
        if presented {
            window.addSubview(containerView)
            
        } else if let vc = getCurrentController(window: window) {
            vc.view.addSubview(containerView)
        } else {
            window.rootViewController?.view.addSubview(containerView)
        }
        
        animationView.rotate()

    }
    
    func hide() {
        animationView.removeFromSuperview()
        containerView.removeFromSuperview()
    }
    
    private func getCurrentController(window: UIWindow) -> UIViewController? {
        if let nav = window.rootViewController as? UINavigationController,
           let vc = nav.visibleViewController {
            
            if let tabbar = vc as? UITabBarController,
               let selected = tabbar.selectedViewController as? UINavigationController,
                let current = selected.visibleViewController {
                return current
            }
            
            return vc
        }
        
        return nil
    }
}

