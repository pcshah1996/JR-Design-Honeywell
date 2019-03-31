//
//  CoreMapViewController.swift
//  Honeywell LAANC
//
//  Created by Prateek Shah on 2/18/19.
//  Copyright © 2019 jrdesign. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class CoreMapViewController: UIViewController {
    
    @IBOutlet weak var googleMapView: GMSMapView!
    
    @IBOutlet weak var heightSlider: UISlider!
    
    @IBOutlet weak var cancelDrawingBtn: UIButton!{
        
        didSet{
            
            cancelDrawingBtn.isHidden = true
            let origImage = UIImage(named: "cross-1")
            let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            cancelDrawingBtn.setImage(tintedImage, for: .normal)
            cancelDrawingBtn.tintColor = UIColor.blue
            cancelDrawingBtn.backgroundColor = UIColor.white
            
        }
    }
    
    @IBAction func cancelDrawingActn(_ sender: AnyObject?) {
        
        isDrawingModeEnabled = false
        let _ =  userDrawablePolygons.map{ $0.map = nil }
        let _ = polygonDeleteMarkers.map{ $0.map = nil}
        let _ = polygonMoveMarkers.map{ $0.map = nil}
        polygonDeleteMarkers.removeAll()
        polygonMoveMarkers.removeAll()
        userDrawablePolygons.removeAll()
        cancelDrawingBtn.isHidden = true
        
        
    }
    
    @IBOutlet weak var drawBtn: UIButton!{
        didSet{
            
            let origImage = UIImage(named: "pen")
            let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            drawBtn.setImage(tintedImage, for: .normal)
            drawBtn.tintColor = UIColor.blue
            drawBtn.backgroundColor = UIColor.white
            
        }
        
    }
    
    @IBAction func drawActn(_ sender: AnyObject?) {
        
        self.coordinates.removeAll()
        self.view.addSubview(canvasView)
        let origImage = UIImage(named: "pen")
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        drawBtn.setImage(tintedImage, for: .normal)
        drawBtn.tintColor = UIColor.white
        drawBtn.backgroundColor = UIColor.red
        
    }
    
    lazy var canvasView:CanvasView = {
        
        var overlayView = CanvasView(frame: self.googleMapView.frame)
        overlayView.isUserInteractionEnabled = true
        overlayView.delegate = self
        return overlayView
        
    }()
    
    var isDrawingModeEnabled = false
    var coordinates = [CLLocationCoordinate2D]()
    var userDrawablePolygons = [GMSPolygon]()
    var polygonDeleteMarkers = [DeleteMarker]()
    var polygonMoveMarkers = [MoveMarker]()
    var move_marker = -1
    var move_idx = -1
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        googleMapView.delegate = self
        googleMapView.isBuildingsEnabled = true
        let target = CLLocationCoordinate2D.init(latitude: 33.7490, longitude: -84.3880)
        
        let cameraPos = GMSCameraPosition(target: target, zoom: 10, bearing: 0, viewingAngle: 45)
        self.googleMapView.animate(to: cameraPos)
        let path = Bundle.main.path(forResource: "Georgia", ofType: "geojson")
        let url = URL(fileURLWithPath: path!)
        let geoJsonParser = GMUGeoJSONParser(url: url)
        geoJsonParser.parse()
        
        let renderer = GMUGeometryRenderer(map: googleMapView, geometries: geoJsonParser.features)
        
        renderer.render()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createPolygonFromTheDrawablePoints(){
        
        let numberOfPoints = self.coordinates.count
        //do not draw in mapview a single point
        if numberOfPoints > 2 { addPolyGonInMapView(drawableLoc: coordinates) }//neglects a single touch
        coordinates = []
        self.canvasView.image = nil
        self.canvasView.removeFromSuperview()
        
        let origImage = UIImage(named: "pen")
        let tintedImage = origImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        drawBtn.setImage(tintedImage, for: .normal)
        drawBtn.tintColor = UIColor.red
        drawBtn.backgroundColor = UIColor.white
        
    }
    
    
    
    @IBAction func submitFlightPlan(_ sender: Any) {
        
        var geoJson: [String: Any] = [:]
        geoJson["type"] = "GeometryCollection"
        var geometries: [[String: Any]] = []
        
        for polygon in userDrawablePolygons {
            var geometry: [String: Any] = [:]
            geometry["type"] = "Polygon"
            
            var coordinates: [[Float]] = []
            let path = polygon.path!
            for i in 0...path.count() {
                let coordinate = path.coordinate(at: i)
                coordinates.append([Float(coordinate.latitude), Float(coordinate.longitude)])
            }
            geometry["coordinates"] = coordinates
            
            
            geometries.append(geometry)
        }
        
        geoJson["geometries"] = geometries
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: geoJson, options: .prettyPrinted)
            let jsonString = String(bytes: jsonData, encoding: .ascii)
            print(jsonString)
        }catch {
            print("error")
        }
        
    }
    func addPolyGonInMapView( drawableLoc:[CLLocationCoordinate2D]){
        
        isDrawingModeEnabled = true
        let path = GMSMutablePath()
        for loc in drawableLoc{
            path.add(loc)
        }
        let newpolygon = GMSPolygon(path: path)
        newpolygon.strokeWidth = 3
        newpolygon.strokeColor = UIColor.black
        newpolygon.fillColor = UIColor.black.withAlphaComponent(CGFloat(heightSlider!.value))
        newpolygon.map = googleMapView
        
        if cancelDrawingBtn.isHidden == true{ cancelDrawingBtn.isHidden = false }
        userDrawablePolygons.append(newpolygon)
        addPolygonDeleteAnnotation(endCoordinate: drawableLoc.last!,polygon: newpolygon)
        addPolygonMoveAnnotation(startCoordinate: drawableLoc.first!,polygon: newpolygon)
    }
    
    func addPolygonDeleteAnnotation(endCoordinate location:CLLocationCoordinate2D,polygon:GMSPolygon){
        
        let marker = DeleteMarker(location: location,polygon: polygon)
        let deletePolygonView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        deletePolygonView.layer.cornerRadius = 15
        deletePolygonView.backgroundColor = UIColor.white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        imageView.center = deletePolygonView.center
        imageView.image = UIImage(named: "delete")
        deletePolygonView.addSubview(imageView)
        marker.iconView = deletePolygonView
        marker.map = googleMapView
        polygonDeleteMarkers.append(marker)
    }
    
    func addPolygonMoveAnnotation(startCoordinate location:CLLocationCoordinate2D,polygon:GMSPolygon){
        let marker = MoveMarker(location: location,polygon: polygon)
        let movePolygonView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        movePolygonView.layer.cornerRadius = 15
        movePolygonView.backgroundColor = UIColor.white
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        imageView.center = movePolygonView.center
        imageView.image = UIImage(named: "move")
        movePolygonView.addSubview(imageView)
        marker.iconView = movePolygonView
        marker.map = googleMapView
        polygonMoveMarkers.append(marker)
    }
    
}

//MARK: MAPVIEW DELEGATE METHODS
extension CoreMapViewController:GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        //target on movement button
        if let movemarker = marker as? MoveMarker{
            
            if let index = userDrawablePolygons.index(of: movemarker.drawPolygon){
                move_idx = index
            }
            if let  indexToRemove =  polygonMoveMarkers.index(of: movemarker){
                move_marker = indexToRemove
            }
            return true
        }
        
        
        //do not accept touch of current location marker
        if let deletemarker = marker as? DeleteMarker{
            
            if let index = userDrawablePolygons.index(of: deletemarker.drawPolygon){
                
                userDrawablePolygons.remove(at: index)
                
            }
            if let  indexToRemove =  polygonDeleteMarkers.index(of: deletemarker){
                
                polygonDeleteMarkers.remove(at: indexToRemove)
                
            }
            
            deletemarker.drawPolygon.map = nil
            deletemarker.map = nil
            if userDrawablePolygons.count == 0{ cancelDrawingActn(nil) }
            return true
        }
        return false
    }
}

//MARK: GET DRAWABLE COORDINATES
extension CoreMapViewController:NotifyTouchEvents{
    
    func touchBegan(touch:UITouch){
        
        let location = touch.location(in: self.googleMapView)
        let coordinate = self.googleMapView.projection.coordinate(for: location)
        self.coordinates.append(coordinate)
        
    }
    
    func touchMoved(touch:UITouch){
        
        let location = touch.location(in: self.googleMapView)
        let coordinate = self.googleMapView.projection.coordinate(for: location)
        self.coordinates.append(coordinate)
        
    }
    
    func touchEnded(touch:UITouch){
        
        let location = touch.location(in: self.googleMapView)
        let coordinate = self.googleMapView.projection.coordinate(for: location)
        self.coordinates.append(coordinate)
        if (move_idx > 0) {
            
            userDrawablePolygons.remove(at: move_idx)
            polygonDeleteMarkers.remove(at: move_marker)
        
            move_idx = -1
            move_marker = -1
        }
        createPolygonFromTheDrawablePoints()
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
