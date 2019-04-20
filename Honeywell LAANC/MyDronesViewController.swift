//
//  MyDronesViewController.swift
//  Honeywell LAANC
//
//  Created by Colby Tobin on 1/27/19.
//  Copyright © 2019 jrdesign. All rights reserved.
//

import UIKit

class MyDronesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var droneArray: [[String:String]] = []
    
    @IBOutlet weak var droneTableView: UITableView!
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
        
        cell!.detailTextLabel!.text = droneArray[indexPath.row]["make_model"]
        cell!.textLabel!.text = droneArray[indexPath.row]["name"]
        
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        droneArray = (UserDefaults.standard.value(forKey: "drones") as? [[String: String]]) ?? []
        print(droneArray)
        
        droneTableView.dataSource = self
        droneTableView.delegate = self
        DispatchQueue.main.async {
            self.droneTableView.reloadData()
        }        // Do any additional setup after loading the view.
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
