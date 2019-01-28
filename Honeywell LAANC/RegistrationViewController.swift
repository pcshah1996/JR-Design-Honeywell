//
//  RegistrationViewController.swift
//  Honeywell LAANC
//
//  Created by Prateek Shah on 1/27/19.
//  Copyright © 2019 jrdesign. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedRegisterButton() {
        // Perform form validation and hit Honeywell backend here
        
        // create the alert
        let alert = UIAlertController(title: "Status", message: "Registration Complete, please sign in", preferredStyle: UIAlertController.Style.alert)
        
        
        // add an action (button)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            UIAlertAction in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "LandingView") as! LandingViewController
            self.present(newViewController, animated: true, completion: nil)
            })
        
        alert.addAction(okAction)
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    
        

        
        //let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "LandingView") as! LandingViewController
        
        //self.navigationController!.pushViewController(secondViewController, animated: true)
    }
}
