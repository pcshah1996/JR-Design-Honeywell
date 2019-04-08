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

    
    
    var droneArray: NSArray = []
    var currentSelection: Int = -1
    
    

    @IBOutlet weak var coordinatesTableView: UITableView!
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
    

    
    @IBAction func addCoordinates(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "showMapView", sender: self)
        
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
