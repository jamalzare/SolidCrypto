//
//  LoginViewController.swift
//  SolidCrypto
//
//  Created by Jamal on 5/20/23.
//

import Foundation
import UIKit

var bigMe: Me?

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var signupButton: Button!
    @IBOutlet weak var loginButton: Button!
    @IBOutlet weak var testButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .lightGrayBorder
        navigationController?.view.backgroundColor = .lightGrayBorder
        setup()
        
        if let token = UserDefaults.standard.string(forKey: "token"), token.count > 1 {
            getMeData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Welcome"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.title = "Welcome"
        title = "Welcome"
        
    }
    
    private func setup() {
        title = "Welcome"
        setNavigationBar()
        loginButton.unSelectedStyle = false
        signupButton.unSelectedStyle = false
        usernameTextField.placeholder = "Email"
        usernameTextField.keyboardType = .emailAddress
        passwordTextField.placeholder = "Password"
        usernameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        loginButton.isEnabled = false
        signupButton.isEnabled = false
        
#if !DEBUG
        signupButton.isHidden = true
        testButton.isHidden = true
#endif
    }
    
    func clearTextFields() {
        usernameTextField.preText = ""
        passwordTextField.preText = ""
    }
    
    func signup(user: String, password: String) {
        Loading.shared.show(title: "Loading...")
        
        APIService.signup(username: user, password: password) { [weak self] model, error in
            Loading.shared.hide()
            
            if let model = model {
                UserDefaults.standard.setValue(model.token, forKey: "token")
                self?.goToNextScene()
            }
            else if let error = error {
                self?.presentAlert(title: "Error", message: "Something went wrong: \(error.message)")
            }
            
        }
    }
    
    func login(user: String, password: String) {
        Loading.shared.show(title: "Loading...")
        
        UserDefaults.standard.setValue("", forKey: "token")
        
        APIService.login(username: user, password: password) { [weak self] model, error in
            Loading.shared.hide()
            
            if let model = model {
                UserDefaults.standard.setValue(model.token, forKey: "token")
                self?.getMeData()
            }
            else if let error = error {
                
                self?.presentAlert(title: "Error", message: "your username and passowrd is wrong: \(error.message)")
            }
            
        }
    }
    
    func getMeData() {
        tradesStates = [.free, .free, .free]
        Loading.shared.show(title: "Loading...")
        
        APIService.me() { [weak self] model, error in
//            Loading.shared.hide()
            
            if let model = model {
                bigMe = model
                print(model)
                self?.loadTrade1()
            }
            
            else if let error = error {
                self?.presentAlert(title: "Error", message: "your username and passowrd is wrong: \(error.message)")
            }
            
        }
    }
    
    func loadTrade1() {
        
        guard let id = bigMe?.tradeSlotId  else {
            loadTrade2()
            return
        }
        
//        Loading.shared.show(title: "Loading...")
        
        APIService.getInvestmentStatus(investmentId: id) { [weak self] model, error in
//            Loading.shared.hide()
            
            if let model = model {
                tradesStates[0] = model.tradeState
            }
            else if let _ = error {
            }
            self?.loadTrade2()
        }
    }
    
    func loadTrade2() {
        
        guard let id = bigMe?.tradeSlot2Id  else {
            loadTrade3()
            return
        }
        
//        Loading.shared.show(title: "Loading...")
        
        APIService.getInvestmentStatus(investmentId: id) { [weak self] model, error in
//            Loading.shared.hide()
            
            if let model = model {
                tradesStates[1] = model.tradeState
            }
            else if let _ = error {
            }
            
            self?.loadTrade3()
        }
    }
    
    func loadTrade3() {
        
        guard let id = bigMe?.tradeSlot3Id  else {
            Loading.shared.hide()
            goToNextScene()
            return
        }
        
        APIService.getInvestmentStatus(investmentId: id) { [weak self] model, error in
            Loading.shared.hide()
            
            if let model = model {
                tradesStates[2] = model.tradeState
            }
            else if let _ = error {
            }
            self?.goToNextScene()
        }
    }
    
    func goToNextScene() {
        let vc: UITabBarController = UIStoryboard(storyboard: .main).instantiateViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapSignButton(sender: AnyObject) {
        signup(user: usernameTextField.text ?? "",
               password: passwordTextField.text ?? "")
        view.endEditing(true)
    }
    
    @IBAction func didTapLoginButton(sender: AnyObject) {
        
        login(user: usernameTextField.text ?? "",
              password: passwordTextField.text ?? "")
        view.endEditing(true)
    }
    
    
    @IBAction func didTapTestButton(sender: AnyObject) {
        //        login(user: "jamal.zare@solidict.com", password: "j1234")
                login(user: "new5@test.com", password: "t1234")
//        login(user: "tester@test.com", password: "t1234")
        
        view.endEditing(true)
    }
    
    @objc func editingChanged() {
        let username = usernameTextField.pureTextCount > 0
        let password = passwordTextField.pureTextCount > 0
        loginButton.isEnabled = username && password
        signupButton.isEnabled = loginButton.isEnabled
    }
}

extension LoginViewController {
    
    
}


