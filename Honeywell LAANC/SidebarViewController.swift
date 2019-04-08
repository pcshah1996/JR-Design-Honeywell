//
//  SidebarViewController.swift
//  Honeywell LAANC
//
//  Created by Shaun Sharma on 4/7/19.
//  Copyright © 2019 jrdesign. All rights reserved.
//

import Foundation

import UIKit

class SidebarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let defaults:UserDefaults = UserDefaults.standard
    
    
    var droneArray: NSArray = []
    var currentSelection: Int = -1
    
    

    @IBOutlet weak var longText1: UITextField!
    @IBOutlet weak var latText1: UITextField!
    @IBOutlet weak var longText2: UITextField!
    @IBOutlet weak var latText2: UITextField!
    @IBOutlet weak var longText3: UITextField!
    @IBOutlet weak var latText3: UITextField!
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var coordinatesTableView: UITableView!
    @IBAction func addCoordinates(_ sender: Any) {
        let longVal1 = Double(longText1.text!)
        let longVal2 = Double(longText2.text!)
        let longVal3 = Double(longText3.text!)
        let latVal1 = Double(latText1.text!)
        let latVal2 = Double(latText2.text!)
        let latVal3 = Double(latText3.text!)
        let heightVal = Double(heightText.text!)
        defaults.set(longVal1, forKey: "longVal1")  //Integer
        defaults.set(longVal2, forKey: "longVal2")  //Integer
        defaults.set(longVal3, forKey: "longVal3")  //Integer
        defaults.set(latVal1, forKey: "latVal1")  //Integer
        defaults.set(latVal2, forKey: "latVal2")  //Integer
        defaults.set(latVal3, forKey: "latVal3")  //Integer
        defaults.set(heightVal, forKey: "heightVal")  //Integer
        self.performSegue(withIdentifier: "showMap", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //droneArray = (UserDefaults.standard.value(forKey: "drones") as? NSArray) ?? []
        print(droneArray)
        
        coordinatesTableView.dataSource = self
        coordinatesTableView.allowsMultipleSelection = false
        coordinatesTableView.delegate = self
        /*DispatchQueue.main.async {
            self.coordinatesTableView.reloadData()
            let indexPath = IndexPath(row: 0, section: 0)
            if let cell = self.coordinatesTableView.cellForRow(at: indexPath) {
                self.currentSelection = indexPath.row
                cell.accessoryType = .checkmark
            }
            self.coordinatesTableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        }*/
        // Do any additional setup after loading the view.
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            currentSelection = indexPath.row
            cell.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coordinatesTableView.dequeueReusableCell(withIdentifier: "CELL1")
    
        
        // we know that cell is not empty now so we use ! to force unwrapping but you could also define cell as
        // let cell = (tableView.dequeue... as? UITableViewCell) ?? UITableViewCell(style: ...)
        
        return cell!
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
