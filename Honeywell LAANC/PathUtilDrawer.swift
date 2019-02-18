//
//  PathUtilDrawer.swift
//  Honeywell LAANC
//
//  Created by Prateek Shah on 2/18/19.
//  Copyright © 2019 jrdesign. All rights reserved.
//

import UIKit
import GoogleMaps

class DeleteMarker: GMSMarker {
    
    var drawPolygon:GMSPolygon
    var markers:[GMSMarker]?
    
    init(location:CLLocationCoordinate2D,polygon:GMSPolygon) {
        
        
        self.drawPolygon = polygon
        super.init()
        super.position = location
        
    }
    
}

class MoveMarker: GMSMarker {
    
    var drawPolygon:GMSPolygon
    var markers:[GMSMarker]?
    
    init(location:CLLocationCoordinate2D,polygon:GMSPolygon) {
        
        
        self.drawPolygon = polygon
        super.init()
        super.position = location
        
    }
    
}
