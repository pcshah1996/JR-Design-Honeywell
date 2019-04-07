//
//  ApprovedFlightPlansViewController.swift
//  Honeywell LAANC
//
//  Created by Colby Tobin on 4/6/19.
//  Copyright © 2019 jrdesign. All rights reserved.
//

import UIKit

class ApprovedFlightPlansViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var flights: [SavedFlightObject] = []
    var selectedIndex: Int = -1
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "FlightsCell")
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "FlightsCell")
        }
        
        cell?.textLabel?.text = flights[indexPath.row].flightName
        cell?.detailTextLabel?.text = flights[indexPath.row].startDate.description
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        
        self.performSegue(withIdentifier: "showFlightDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ApprovedFlightPlanViewController {
            if let vc = segue.destination as? ApprovedFlightPlanViewController {
                vc.flightPlan = flights[selectedIndex]
            }
        }
    }
    

    @IBOutlet weak var flightsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let decoded = (UserDefaults.standard.value(forKey: "flights") as? Data)
        
        if let decodedValues = decoded {
            flights = NSKeyedUnarchiver.unarchiveObject(with: decodedValues) as! [SavedFlightObject]
        }
        
        flightsTableView.delegate = self
        flightsTableView.dataSource = self
        
        DispatchQueue.main.async {
            self.flightsTableView.reloadData()
        }

        // Do any additional setup after loading the view.
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
