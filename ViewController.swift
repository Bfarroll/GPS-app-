//
//  ViewController.swift
//  GPSBillyFarroll
//
//  Created by Billy Farroll on 12/10/2015.
//  Copyright © 2015 Billy Farroll. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {

    @IBOutlet weak var TheMap: MKMapView!
    @IBOutlet weak var TheLabel: UILabel!
    
    
    var manager:CLLocationManager!
    var myLocations: [CLLocation] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Setting up our location (below)
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        //Setting up our map view (Below)
        
        TheMap.delegate = self
        TheMap.mapType = MKMapType.Satellite
        TheMap.showsUserLocation = true
        
        }
    
    
    func locationManager(manager:CLLocationManager,didUpdateLocations locations:[AnyObject]) {
        TheLabel.text = "\(locations[0])"
        myLocations.append(locations[0] as! CLLocation)
        
        
        
        let spanX = 0.007
        let spanY = 0.007
        let NewRegion = MKCoordinateRegion(center: TheMap.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        TheMap.setRegion(NewRegion, animated: true)
        
        
        
        if (myLocations.count > 1){
            let sourceIndex = myLocations.count - 1
            let destinationIndex = myLocations.count - 2
            
            let c1 = myLocations[sourceIndex].coordinate
            let c2 = myLocations[destinationIndex].coordinate
            var a = [c1, c2]
            let polyline = MKPolyline(coordinates: &a, count: a.count)
            TheMap.addOverlay(polyline)
        }
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return nil
    }
}
   
        





