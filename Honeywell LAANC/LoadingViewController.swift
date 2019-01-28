//
//  DashboardViewController.swift
//  Honeywell LAANC
//
//  Created by Prateek Shah on 11/15/18.
//  Copyright © 2018 jrdesign. All rights reserved.
//


import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    let authNavigator = MainViewController.authNavigator
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        progressView.progress = 0.0
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let duration = 2.0
        
        // Setup timer
        let interval:TimeInterval = duration / 100
        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { timer in
            
            // Update progress
            self.progressView.setProgress(self.progressView.progress + 0.01, animated: true)
            
            // Stop animating
            if self.progressView.progress >= 1 {
                timer.invalidate()
                
                self.authNavigator.finishLoading()
            }
        })
        timer.fire()
    }

}
