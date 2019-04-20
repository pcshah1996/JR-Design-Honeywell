//
//  ApprovedFlightPlanViewController.swift
//  Honeywell LAANC
//
//  Created by Colby Tobin on 4/6/19.
//  Copyright © 2019 jrdesign. All rights reserved.
//

import UIKit

class ApprovedFlightPlanViewController: UIViewController {

    @IBOutlet weak var googleMapView: GMSMapView!
    
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var flightName: UILabel!
    var flightPlan: SavedFlightObject? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let flightLocations = flightPlan!.userFlightLocations
        startTime.text = flightPlan!.startDate.description(with: Locale.current)
        endTime.text = flightPlan!.endDate.description(with: Locale.current)
        flightName.text = flightPlan!.flightName
        var places: [GMSPolygon] = []
        
        for polygon in flightLocations {
            let path = GMSMutablePath()
            for loc in polygon {
                path.add(CLLocationCoordinate2D(latitude: loc[0], longitude: loc[1]))
            }
            places.append(GMSPolygon(path: path))
        }
        
        googleMapView.isBuildingsEnabled = true
        let target = CLLocationCoordinate2D.init(latitude: 33.7490, longitude: -84.3880)
        
        let cameraPos = GMSCameraPosition(target: target, zoom: 10, bearing: 0, viewingAngle: 45)
        self.googleMapView.animate(to: cameraPos)
        
        for x in 0...(places.count - 1) {
            let place = places[x]
            place.strokeWidth = 3
            place.strokeColor = UIColor.black
            print(flightPlan!.heights)
            place.fillColor = UIColor.black.withAlphaComponent(CGFloat(Double(flightPlan!.heights[x]) / 400.0))
            place.map = googleMapView
        }
        
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
