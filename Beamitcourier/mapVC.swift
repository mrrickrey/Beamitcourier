//
//  mapview.swift
//  Beamitcourier
//
//  Created by Enrique Reyes on 11/17/17.
//  Copyright © 2017 Enrique Reyes. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import CoreLocation
import Firebase

class mapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    
    @IBOutlet weak var mapHome: MKMapView!
    
    let locationManager = CLLocationManager()
    var fireRef: FIRDatabaseReference!

    var mapHasCenteredOnce = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        mapHome.delegate = self
        mapHome.userTrackingMode = MKUserTrackingMode.follow
        mapHome.layer.cornerRadius = 10
        
        fireRef = FIRDatabase.database().reference()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locartionAuthStatus()
    }
    
    func locartionAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapHome.showsUserLocation = true
            } else {
    locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapHome.showsUserLocation = true
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        
        mapHome.setRegion(coordinateRegion, animated: false)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            
            if !mapHasCenteredOnce {
                centerMapOnLocation(location: loc)
                mapHasCenteredOnce = true
            }
        }
    }

    

    
}
