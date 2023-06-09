//
//  DashboardViewController.swift
//  SolidCrypto
//
//  Created by Jamal on 6/9/23.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController {
    
    var balance: Double = 0
    
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var dashboardButton: Button!
    @IBOutlet weak var trade1Button: Button!
    @IBOutlet weak var trade2Button: Button!
    @IBOutlet weak var trade3Button: Button!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var progres1View = CirlceView()
    var progres2View = CirlceView()
    var progres3View = CirlceView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .lightGrayBorder
        navigationController?.view.backgroundColor = .lightGrayBorder
        setNavigationBar()
        setup()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timerLoop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        change(tab: 0)
        setColors()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: BalanceCell.self)
        collectionView.register(cellType: InvestmentCell.self)
        collectionView.backgroundColor = .clear
        collectionView.contentInset.top = 10
        
        buttonsView.layer.cornerRadius = 14
        dashboardButton.unSelectedStyle = false
        trade1Button.unSelectedStyle = true
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
            dashboardButton.unSelectedStyle = false
            trade1Button.unSelectedStyle = true
            trade2Button.unSelectedStyle = true
            trade3Button.unSelectedStyle = true
        }
        if tab == 1 {
            trade1Button.unSelectedStyle = false
            trade2Button.unSelectedStyle = true
            trade3Button.unSelectedStyle = true
            dashboardButton.unSelectedStyle = true
        }
        
        if tab == 2 {
            trade2Button.unSelectedStyle = false
            trade1Button.unSelectedStyle = true
            trade3Button.unSelectedStyle = true
            dashboardButton.unSelectedStyle = true
        }
        
        if tab == 3 {
            trade3Button.unSelectedStyle = false
            trade1Button.unSelectedStyle = true
            trade2Button.unSelectedStyle = true
            dashboardButton.unSelectedStyle = true
        }
    }
    
    func setColors() {
        progres1View.state = tradesStates[0]
        progres2View.state = tradesStates[1]
        progres3View.state = tradesStates[2]
    }
    
}


extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        let count = allInvestments.compactMap({_ in }).count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell: BalanceCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.balance = balance
            return cell
        }
        
        let cell: InvestmentCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.investment = allInvestments[indexPath.item]
        return cell
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width-32, height: indexPath.section == 0 ? 70: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}


//MARK: Loops
extension DashboardViewController {
  
    
    func timerLoop() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.getBalance()
        }
    }
    
    func loadTrade1() {
        
        guard let id = bigMe?.tradeSlotId  else {
            loadTrade2()
            return
        }
        
        APIService.getInvestmentStatus(investmentId: id) { [weak self] model, error in
            
            if let model = model {
                tradesStates[0] = model.tradeState
                allInvestments[0] = model
            }
            else if let _ = error {
                self?.collectionView.reloadData()
            }
            self?.loadTrade2()
        }
    }
    
    func loadTrade2() {
        
        guard let id = bigMe?.tradeSlot2Id  else {
            loadTrade3()
            return
        }
        
        APIService.getInvestmentStatus(investmentId: id) { [weak self] model, error in
            
            if let model = model {
                tradesStates[1] = model.tradeState
                allInvestments[1] = model
            }
            else if let _ = error {
            }
            
            self?.loadTrade3()
        }
    }
    
    func loadTrade3() {
        
        guard let id = bigMe?.tradeSlot3Id  else {
            collectionView.reloadData()
            return
        }
        
        APIService.getInvestmentStatus(investmentId: id) { [weak self] model, error in
            Loading.shared.hide()
            
            if let model = model {
                tradesStates[2] = model.tradeState
                allInvestments[2] = model
            }
            else if let _ = error {
            }
            self?.timerLoop()
            self?.collectionView.reloadData()
        }
    }
    
    
    func getBalance() {
        
        APIService.getBalance() { [weak self] model, error in
            
            if let model = model {
                self?.balance = model
            }
            
            else if let _ = error {
            }
            self?.loadTrade1()
        }
    }
    
}
