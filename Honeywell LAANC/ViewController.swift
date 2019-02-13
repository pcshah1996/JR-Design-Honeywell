//
//  ViewController.swift
//  MapKit Starter
//
//  Created by Pranjal Satija on 10/25/16.
//  Copyright © 2016 Pranjal Satija. All rights reserved.
//

import UIKit
import MapKit


extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
            
        else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            annotationView.image = UIImage(named: "place icon")
            return annotationView
        }    }
}


class ViewController: UIViewController {
    var points = [CLLocationCoordinate2D]() {
        didSet {
            print(points)
        }
    }
    
    var touched = true;
    
    @IBOutlet var mapView: MKMapView?
    
    let locationManager = CLLocationManager()
    
    let places = Place.getPlaces()
    
    override func viewDidLoad() {
        requestLocationAccess()
        
        addAnnotations()
        addPolyline()
        addPolygon()
        mapView?.isUserInteractionEnabled = false
    }
    
    func addAnnotations() {
        mapView?.delegate = self as? MKMapViewDelegate
        mapView?.addAnnotations(places)
        
        let overlays = places.map { MKCircle(center: $0.coordinate, radius: 100) }
        mapView?.addOverlays(overlays)
        
        var locations = places.map { $0.coordinate }
        let polyline = MKPolyline(coordinates: &locations, count: locations.count)
        mapView?.add(polyline)
    }
    
    func addPolyline() {
        var locations = places.map { $0.coordinate }
        let polyline = MKPolyline(coordinates: &locations, count: locations.count)
        
        mapView?.add(polyline)
    }
    
    func addPolygon() {
        var locations = places.map { $0.coordinate }
        let polygon = MKPolygon(coordinates: &locations, count: locations.count)
        mapView?.add(polygon)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touched) {
            if let touch = touches.first {
                let coordinate = mapView?.convert(touch.location(in: mapView), toCoordinateFrom: mapView)
                points.append(coordinate!)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touched) {
            if let touch = touches.first {
                let coordinate = mapView?.convert(touch.location(in: mapView), toCoordinateFrom: mapView)
                points.append(coordinate!)
                let polyline = MKPolyline(coordinates: points, count: points.count)
                mapView?.add(polyline) //Add lines
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let polygon = MKPolygon(coordinates: &points, count: points.count)
        mapView?.add(polygon) //Add polygon areas
        touched = false
        mapView?.isUserInteractionEnabled = true
        points = [] //Reset points
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 2
            return renderer
            
        } else if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.orange
            renderer.lineWidth = 3
            return renderer
        } else if overlay is MKPolygon {
            let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
            renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 2
            return renderer
        }
        
        return MKOverlayRenderer()
    }
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
}


