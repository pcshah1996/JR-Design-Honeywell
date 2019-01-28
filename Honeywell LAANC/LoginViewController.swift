//
//  DashboardViewController.swift
//  Honeywell LAANC
//
//  Created by Prateek Shah on 11/15/18.
//  Copyright © 2018 jrdesign. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    // MARK: - Important part for AuthNavigation
    
    let authNavigator = MainViewController.authNavigator
    
    @IBAction func pressedLoginButton(_ sender: Any) {
        // Hit honeywell backend
        authNavigator.finishLogin(success: true)
    }
    
}
