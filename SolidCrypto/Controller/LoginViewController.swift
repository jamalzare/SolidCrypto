//
//  LoginViewController.swift
//  SolidCrypto
//
//  Created by Jamal on 5/20/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var loginButton: Button!
    @IBOutlet weak var testButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backButtonTitle = ""
        view.backgroundColor = .lightGrayBorder
        navigationController?.view.backgroundColor = .lightGrayBorder
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setup() {
        title = "Welcome"
        setNavigationBar()
        loginButton.unSelectedStyle = false
        usernameTextField.placeholder = "User Name"
        passwordTextField.placeholder = "Password"
        usernameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        loginButton.isEnabled = false
    }
    
    func login(user: String, password: String) {
        Loading.shared.show(title: "Loging...")
        
        APIService.login(username: user, password: password) { [weak self] model, error in
            Loading.shared.hide()
            
            if let model = model {
                print(model)
                self?.goToNextScene()
            }
            else if let error = error {
                self?.presentAlert(title: "Error", message: "your username and passowrd is wrong\(error.message)")
            }
            
        }
    }
    
    func goToNextScene() {
        let vc: TradesViewController = UIStoryboard(storyboard: .main).instantiateViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapLoginButton(sender: AnyObject) {
//        login(user: usernameTextField.text ?? "",
//              password: passwordTextField.text ?? "")
        goToNextScene()
    }
    
    @IBAction func didTapTestButton(sender: AnyObject) {
//        login(user: "user", password: "password")
        goToNextScene()
    }
    
    @objc func editingChanged() {
        let username = usernameTextField.pureTextCount > 0
        let password = passwordTextField.pureTextCount > 0
        loginButton.isEnabled = username && password
    }
}

extension LoginViewController {
    

}


