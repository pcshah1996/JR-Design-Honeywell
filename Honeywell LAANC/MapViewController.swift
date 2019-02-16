//
//  MapViewController.swift
//  Honeywell LAANC
//
//  Created by Harsha Muddu on 2/16/19.
//  Copyright © 2019 jrdesign. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    override func loadView() {
        let initial_lat = 33.774002
        let initial_long = -84.384122
        let camera = GMSCameraPosition.camera(withLatitude: initial_lat, longitude: initial_long, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
    }
}
