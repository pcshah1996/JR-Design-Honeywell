//
//  MapViewController.swift
//  Honeywell LAANC
//
//  Created by Harsha Muddu on 2/16/19.
//  Copyright © 2019 jrdesign. All rights reserved.
//

import UIKit
import GoogleMaps



class MapViewController: UIViewController, GMSMapViewDelegate {
    
    //var mapView: GMSMapView!
    var coordinates = [CLLocationCoordinate2D]()
    var mapView:GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
    //        print(marker.position)
    //        print("HELLO")
    //    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.scrollGestures = false
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        marker.isDraggable = true
        
        mapView.delegate = self
        view = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        coordinates.append(marker.position)
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        coordinates.append(marker.position)
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        coordinates.append(marker.position)
        coordinates.append(coordinates.first!)
        createPolygon()
    }
    
    func createPolygon() {
        let polypath = GMSMutablePath()
        coordinates.forEach { loc in
            polypath.add(loc)
        }
        let polygon = GMSPolygon(path: polypath)
        polygon.map = mapView
    }
    
    
    
}

