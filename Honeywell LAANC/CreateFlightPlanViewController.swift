//
//  CreateFlightPlanViewController.swift
//  Honeywell LAANC
//
//  Created by Colby Tobin on 4/2/19.
//  Copyright © 2019 jrdesign. All rights reserved.
//

import UIKit

class CreateFlightPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var droneArray: NSArray = []
    var currentSelection: Int = -1
    @IBOutlet weak var flightName: UITextField!
    @IBOutlet weak var dronesTableView: UITableView!
    @IBOutlet weak var flightStart: UIDatePicker!
    @IBOutlet weak var flightEnd: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        droneArray = (UserDefaults.standard.value(forKey: "drones") as? NSArray) ?? []
        print(droneArray)
        
        dronesTableView.dataSource = self
        dronesTableView.allowsMultipleSelection = false
        dronesTableView.delegate = self
        DispatchQueue.main.async {
            self.dronesTableView.reloadData()
            let indexPath = IndexPath(row: 0, section: 0)
            if let cell = self.dronesTableView.cellForRow(at: indexPath) {
                self.currentSelection = indexPath.row
                cell.accessoryType = .checkmark
            }
            self.dronesTableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            currentSelection = indexPath.row
        cell.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return droneArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "CELL")
        }
        
        // we know that cell is not empty now so we use ! to force unwrapping but you could also define cell as
        // let cell = (tableView.dequeue... as? UITableViewCell) ?? UITableViewCell(style: ...)
        
        cell!.detailTextLabel!.text = (droneArray.object(at: indexPath.row) as! NSDictionary)["make_model"] as? String
        cell!.textLabel!.text = ((droneArray.object(at: indexPath.row) as! NSDictionary)["name"] as? String) ?? "No Name"
        
        return cell!
    }
    
    @IBAction func nextPartOfFlightPlan(_ sender: Any) {
        
//        let flight = flightName.text
//        let startFlight = flightStart.date
//        let endFlight = flightEnd.date
//        let selectedDrone = droneArray[currentSelection]
        
        self.performSegue(withIdentifier: "showMapView", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CoreMapViewController {
            if let vc = segue.destination as? CoreMapViewController {
                vc.startDate = flightStart.date
                vc.endDate = flightEnd.date
                vc.drone = droneArray[currentSelection] as! [String:String]
                vc.flightName = flightName.text!
            }
        }
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
