//
//  DashboardViewController.swift
//  Honeywell LAANC
//
//  Created by Prateek Shah on 11/15/18.
//  Copyright © 2018 jrdesign. All rights reserved.
//


import UIKit

class SecretsLoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var codeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.delegate = self
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    // MARK: - Important part for AuthNavigation
    
    let authNavigator = SecretsViewController.authNavigator

    @IBAction func loginPressed(_ sender: Any) {
        authNavigator.finishLogin(success: true)
    }
}
