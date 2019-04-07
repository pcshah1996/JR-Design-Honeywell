//
//  SavedFlightObject.swift
//  Honeywell LAANC
//
//  Created by Colby Tobin on 4/6/19.
//  Copyright © 2019 jrdesign. All rights reserved.
//

import UIKit

class SavedFlightObject: NSObject, NSCoding {

    var flightName: String = ""
    var startDate: Date = Date.distantPast
    var endDate: Date = Date.distantPast
    var drone: [String:String] = [:]
    
    var userFlightLocations: [[[CLLocationDegrees]]] = []
    
    var heights: [Int] = []
    
    init(flightName: String, startDate: Date, endDate: Date, drone: [String:String], userFlightLocations: [[[CLLocationDegrees]]], heights: [Int]) {
        self.flightName = flightName
        self.startDate = startDate
        self.endDate = endDate
        self.drone = drone
        self.userFlightLocations = userFlightLocations
        self.heights = heights
    }
    
    required init(coder aDecoder: NSCoder) {
        flightName = aDecoder.decodeObject(forKey: "flightName") as! String
        startDate = aDecoder.decodeObject(forKey: "startDate") as! Date
        endDate = aDecoder.decodeObject(forKey: "endDate") as! Date
        drone = aDecoder.decodeObject(forKey: "drone") as! [String:String]
        userFlightLocations = aDecoder.decodeObject(forKey: "userFlightLocations") as! [[[CLLocationDegrees]]]
        heights = aDecoder.decodeObject(forKey: "heights") as! [Int]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(flightName, forKey: "flightName")
        aCoder.encode(startDate, forKey: "startDate")
        aCoder.encode(endDate, forKey: "endDate")
        aCoder.encode(drone, forKey: "drone")
        aCoder.encode(userFlightLocations, forKey: "userFlightLocations")
        aCoder.encode(heights, forKey: "heights")
    }
    
    
}
