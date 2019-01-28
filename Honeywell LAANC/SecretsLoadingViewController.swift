//
//  DashboardViewController.swift
//  Honeywell LAANC
//
//  Created by Prateek Shah on 11/15/18.
//  Copyright © 2018 jrdesign. All rights reserved.
//


import UIKit

class SecretsLoadingViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let authNavigator = SecretsViewController.authNavigator
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Let activity indicator spin
        activityIndicator.startAnimating()
        
        // Stop after 2 seconds and finish loading
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            self.activityIndicator.stopAnimating()
            self.authNavigator.finishLoading()
        }
    }

}
