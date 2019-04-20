//
//  AddDroneViewController.swift
//  Honeywell LAANC
//
//  Created by Colby Tobin on 1/27/19.
//  Copyright © 2019 jrdesign. All rights reserved.
//

import UIKit

class AddDroneViewController: UIViewController {
    @IBOutlet weak var makeTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var serialNoTextField: UITextField!
    @IBOutlet weak var registrationIDTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addDrone(_ sender: Any) {
        
        let make = makeTextField.text
        let model = modelTextField.text
        let serialNo = serialNoTextField.text
        let registrationID = registrationIDTextField.text
        let weight = weightTextField.text
        let name = nameTextField.text
        
        if name == "" || make == "" || model == "" || serialNo == "" || registrationID == "" || weight == "" {
            //Alert that need to fill in all info
            
            let alert = UIAlertController(title: "Error", message: "You must enter data on all fields.", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        let droneArray = (UserDefaults.standard.value(forKey: "drones") as? [[String:String]]) ?? []

        let newDrone: [String: String] = ["name": name!, "make_model": make! + " / " + model!, "serialNo": serialNo!, "registrationID": registrationID!, "weight": weight!, "make": make!, "model": model!]
        print(droneArray)
        var newDroneArray: [[String: String]] = []
        for drone in droneArray {
            newDroneArray.append(drone)
        }
        newDroneArray.append(newDrone)
        print("Added")
        UserDefaults.standard.setValue(newDroneArray, forKey: "drones")
        
        //Alert that it succeeded
        
        let alert = UIAlertController(title: "Success", message: "Your drone was saved!", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
        makeTextField.text = ""
        modelTextField.text = ""
        serialNoTextField.text = ""
        registrationIDTextField.text = ""
        weightTextField.text = ""
        nameTextField.text = ""
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
