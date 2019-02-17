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
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 33.773980, longitude: -84.383950, zoom: 14.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.scrollGestures = false
        
        mapView.delegate = self
        view = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
        marker.isDraggable = true
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

